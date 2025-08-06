<?php
// config.php
function getDB() {
    $host = 'localhost';
    $dbname = 'farmer_ecommerce';
    $username = 'root';  // Default XAMPP username
    $password = '';      // Default XAMPP password (empty)
    
    try {
        $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $pdo;
    } catch(PDOException $e) {
        throw new Exception("Database connection failed: " . $e->getMessage());
    }
}
?>