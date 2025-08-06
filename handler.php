<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

require_once 'config.php';

$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? '';

try {
    $conn = getDB();
    
    switch ($action) {
        case 'get_stats':
            echo json_encode(getStats($conn));
            break;
        case 'get_products':
            echo json_encode(getProducts($conn));
            break;
        case 'add_product':
            if ($method === 'POST') {
                echo json_encode(addProduct($conn, $_POST));
            }
            break;
        case 'get_farmers':
            echo json_encode(getFarmers($conn));
            break;
        case 'add_farmer':
            if ($method === 'POST') {
                echo json_encode(addFarmer($conn, $_POST));
            }
            break;
        case 'get_customers':
            echo json_encode(getCustomers($conn));
            break;
        case 'add_customer':
            if ($method === 'POST') {
                echo json_encode(addCustomer($conn, $_POST));
            }
            break;
        case 'get_orders':
            echo json_encode(getOrders($conn));
            break;
        case 'get_categories':
            echo json_encode(getCategories($conn));
            break;
        case 'get_units':
            echo json_encode(getUnits($conn));
            break;
        default:
            echo json_encode(['error' => 'Invalid action']);
    }
} catch (Exception $e) {
    echo json_encode(['error' => $e->getMessage()]);
}

// Get dashboard statistics
function getStats($conn) {
    $stats = [];
    
    // Total products
    $stmt = $conn->prepare("SELECT COUNT(*) as count FROM products WHERE status = 'active'");
    $stmt->execute();
    $stats['total_products'] = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    // Total farmers
    $stmt = $conn->prepare("SELECT COUNT(*) as count FROM farmers");
    $stmt->execute();
    $stats['total_farmers'] = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    // Total customers
    $stmt = $conn->prepare("SELECT COUNT(*) as count FROM customers WHERE status = 'active'");
    $stmt->execute();
    $stats['total_customers'] = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    // Total orders
    $stmt = $conn->prepare("SELECT COUNT(*) as count FROM orders");
    $stmt->execute();
    $stats['total_orders'] = $stmt->fetch(PDO::FETCH_ASSOC)['count'];
    
    return ['success' => true, 'data' => $stats];
}

// Get all products with farmer and category info
function getProducts($conn) {
    $stmt = $conn->prepare("
        SELECT p.*, f.name as farmer_name, c.name as category_name, u.name as unit_name, u.abbreviation as unit_abbrev
        FROM products p 
        JOIN farmers f ON p.farmer_id = f.id 
        JOIN categories c ON p.category_id = c.id 
        JOIN units u ON p.unit_id = u.id 
        WHERE p.status = 'active'
        ORDER BY p.created_at DESC
    ");
    $stmt->execute();
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    return ['success' => true, 'data' => $products];
}

// Add new product
function addProduct($conn, $data) {
    $stmt = $conn->prepare("
        INSERT INTO products (farmer_id, category_id, unit_id, name, description, price, quantity_available, image_url) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ");
    
    $result = $stmt->execute([
        $data['farmer_id'],
        $data['category_id'], 
        $data['unit_id'],
        $data['name'],
        $data['description'],
        $data['price'],
        $data['quantity_available'],
        $data['image_url'] ?? null
    ]);
    
    if ($result) {
        return ['success' => true, 'message' => 'Product added successfully', 'id' => $conn->lastInsertId()];
    } else {
        return ['success' => false, 'message' => 'Failed to add product'];
    }
}

// Get all farmers
function getFarmers($conn) {
    $stmt = $conn->prepare("
        SELECT f.*, COUNT(p.id) as product_count 
        FROM farmers f 
        LEFT JOIN products p ON f.id = p.farmer_id AND p.status = 'active'
        GROUP BY f.id 
        ORDER BY f.created_at DESC
    ");
    $stmt->execute();
    $farmers = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    return ['success' => true, 'data' => $farmers];
}

// Add new farmer
function addFarmer($conn, $data) {
    $stmt = $conn->prepare("
        INSERT INTO farmers (name, email, phone, address, city, state) 
        VALUES (?, ?, ?, ?, ?, ?)
    ");
    
    $result = $stmt->execute([
        $data['farmer_name'],
        $data['farmer_email'] ?? null,
        $data['farmer_phone'] ?? null,
        $data['farmer_address'] ?? null,
        $data['farmer_city'] ?? null,
        'Bangladesh' // Default state
    ]);
    
    if ($result) {
        return ['success' => true, 'message' => 'Farmer registered successfully', 'id' => $conn->lastInsertId()];
    } else {
        return ['success' => false, 'message' => 'Failed to register farmer'];
    }
}

// Get all customers
function getCustomers($conn) {
    $stmt = $conn->prepare("
        SELECT c.*, COUNT(o.id) as order_count, COALESCE(SUM(o.total_amount), 0) as total_spent
        FROM customers c 
        LEFT JOIN orders o ON c.id = o.customer_id 
        WHERE c.status = 'active'
        GROUP BY c.id 
        ORDER BY c.created_at DESC
    ");
    $stmt->execute();
    $customers = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    return ['success' => true, 'data' => $customers];
}

// Add new customer
function addCustomer($conn, $data) {
    // Generate a default password hash (in real app, customer would set this)
    $password_hash = password_hash('defaultpass123', PASSWORD_DEFAULT);
    
    $stmt = $conn->prepare("
        INSERT INTO customers (first_name, last_name, email, phone, password_hash, address, city, state) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ");
    
    $result = $stmt->execute([
        $data['customer_first_name'],
        $data['customer_last_name'],
        $data['customer_email'],
        $data['customer_phone'] ?? null,
        $password_hash,
        $data['customer_address'] ?? null,
        $data['customer_city'] ?? null,
        $data['customer_state'] ?? null
    ]);
    
    if ($result) {
        return ['success' => true, 'message' => 'Customer added successfully', 'id' => $conn->lastInsertId()];
    } else {
        return ['success' => false, 'message' => 'Failed to add customer'];
    }
}

// Get all orders with customer info
function getOrders($conn) {
    $stmt = $conn->prepare("
        SELECT o.*, CONCAT(c.first_name, ' ', c.last_name) as customer_name, c.phone as customer_phone
        FROM orders o 
        JOIN customers c ON o.customer_id = c.id 
        ORDER BY o.created_at DESC
    ");
    $stmt->execute();
    $orders = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Get order items for each order
    foreach ($orders as &$order) {
        $stmt = $conn->prepare("
            SELECT oi.*, p.name as product_name, u.abbreviation as unit 
            FROM order_items oi 
            JOIN products p ON oi.product_id = p.id 
            JOIN units u ON p.unit_id = u.id
            WHERE oi.order_id = ?
        ");
        $stmt->execute([$order['id']]);
        $order['items'] = $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    
    return ['success' => true, 'data' => $orders];
}

// Get all categories
function getCategories($conn) {
    $stmt = $conn->prepare("SELECT * FROM categories ORDER BY name");
    $stmt->execute();
    $categories = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    return ['success' => true, 'data' => $categories];
}

// Get all units
function getUnits($conn) {
    $stmt = $conn->prepare("SELECT * FROM units ORDER BY name");
    $stmt->execute();
    $units = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    return ['success' => true, 'data' => $units];
}
?>