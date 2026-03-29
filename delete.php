<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

$host = 'localhost';
$dbname = 'booking_system';
$username = 'root';
$password = '';

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $data = json_decode(file_get_contents("php://input"), true);

    if (isset($data['booking_id'])) {
        $stmt = $conn->prepare("DELETE FROM bookings WHERE booking_id = ?");
        $success = $stmt->execute([$data['booking_id']]);
    }
    elseif (isset($data['room_id'])) {
        $stmt = $conn->prepare("DELETE FROM rooms WHERE room_id = ?");
        $success = $stmt->execute([$data['room_id']]);
    }
    elseif (isset($data['service_id'])) {
        $stmt = $conn->prepare("DELETE FROM services WHERE service_id = ?");
        $success = $stmt->execute([$data['service_id']]);
    }
    elseif (isset($data['user_id'])) {
        $stmt = $conn->prepare("DELETE FROM users WHERE user_id = ?");
        $success = $stmt->execute([$data['user_id']]);
    }
    else {
        echo json_encode(['success' => false, 'error' => 'Invalid data']);
        exit;
    }

    echo json_encode(['success' => $success]);

} catch(Exception $e) {
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>