<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

$host = 'localhost';
$dbname = 'booking_system';
$username = 'root';
$password = '';

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    echo json_encode(['success' => false, 'error' => 'Database connection failed']);
    exit;
}

try {
    if (isset($_GET['stats'])) {
        $sql = "SELECT COUNT(*) as total,
                       SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) as pending,
                       COALESCE(SUM(total_amount), 0) as revenue
                FROM bookings";
        $stmt = $conn->query($sql);
        echo json_encode(['success' => true, 'data' => $stmt->fetch()]);
        exit;
    }

    if (isset($_GET['bookings'])) {
        $sql = "SELECT b.*, u.name as customer_name, u.email as customer_email, 
                       r.name as room_name
                FROM bookings b
                LEFT JOIN users u ON b.user_id = u.user_id
                LEFT JOIN rooms r ON b.room_id = r.room_id
                ORDER BY b.booking_id DESC";
        $stmt = $conn->query($sql);
        echo json_encode(['success' => true, 'data' => $stmt->fetchAll()]);
        exit;
    }

    if (isset($_GET['payments'])) {
        $sql = "SELECT p.*, b.total_amount 
                FROM payments p
                LEFT JOIN bookings b ON p.booking_id = b.booking_id
                ORDER BY p.payment_id DESC";
        $stmt = $conn->query($sql);
        echo json_encode(['success' => true, 'data' => $stmt->fetchAll()]);
        exit;
    }

    if (isset($_GET['rooms'])) {
        $sql = "SELECT * FROM rooms ORDER BY room_id";
        $stmt = $conn->query($sql);
        echo json_encode(['success' => true, 'data' => $stmt->fetchAll()]);
        exit;
    }

    if (isset($_GET['services'])) {
        $sql = "SELECT * FROM services ORDER BY service_id";
        $stmt = $conn->query($sql);
        echo json_encode(['success' => true, 'data' => $stmt->fetchAll()]);
        exit;
    }

    if (isset($_GET['users'])) {
        $sql = "SELECT user_id, name, email, phone, role, is_active, created_at FROM users ORDER BY created_at DESC";
        $stmt = $conn->query($sql);
        echo json_encode(['success' => true, 'data' => $stmt->fetchAll()]);
        exit;
    }

} catch(PDOException $e) {
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>