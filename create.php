<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

$host = 'localhost';
$dbname = 'booking_system';
$username = 'root';
$password = '';

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $input = json_decode(file_get_contents('php://input'), true);

    if (!$input) {
        echo json_encode(['success' => false, 'error' => 'No data received']);
        exit;
    }

    // === CREATE BOOKING ===
    if (isset($input['type']) && $input['type'] === 'booking') {
        $stmt = $conn->prepare("INSERT INTO bookings 
            (user_id, room_id, booking_type, check_in_date, check_out_date, booking_date, guests, special_requests, total_amount, status, payment_status) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending', 'pending')");
        
        $stmt->execute([
            $input['user_id'] ?? 1,
            $input['room_id'] ?? null,
            $input['booking_type'] ?? 'room',
            $input['check_in_date'] ?? null,
            $input['check_out_date'] ?? null,
            date('Y-m-d'),
            $input['guests'] ?? 1,
            $input['special_requests'] ?? '',
            $input['total_amount'] ?? 0
        ]);

        $booking_id = $conn->lastInsertId();

        echo json_encode([
            'success' => true,
            'message' => 'Booking created successfully!',
            'booking_id' => (int)$booking_id
        ]);
    }
    // === CREATE ROOM ===
    elseif (isset($input['type']) && $input['type'] === 'room') {
        $stmt = $conn->prepare("INSERT INTO rooms (category_id, room_number, name, price_per_night, capacity, bed_type) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->execute([
            $input['category_id'] ?? 1,
            $input['room_number'] ?? '',
            $input['name'] ?? '',
            $input['price_per_night'] ?? 0,
            $input['capacity'] ?? 2,
            $input['bed_type'] ?? 'Queen'
        ]);
        
        echo json_encode(['success' => true, 'message' => 'Room added!', 'room_id' => (int)$conn->lastInsertId()]);
    }
    else {
        echo json_encode(['success' => false, 'error' => 'Invalid request type']);
    }

} catch(Exception $e) {
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>