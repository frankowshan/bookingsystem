<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, GET");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

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

// --- HANDLE POST REQUESTS (SAVING DATA) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    
    try {
        // 1. Update Booking Status
        if (isset($input['booking_id']) && isset($input['status'])) {
            $stmt = $conn->prepare("UPDATE bookings SET status = ? WHERE booking_id = ?");
            $stmt->execute([$input['status'], $input['booking_id']]);
            echo json_encode(['success' => true, 'message' => 'Booking updated']);
        }
        // 2. Update Room
        elseif (isset($input['room_id'])) {
            $stmt = $conn->prepare("UPDATE rooms SET name = ?, price_per_night = ?, is_available = ? WHERE room_id = ?");
            $stmt->execute([$input['name'], $input['price_per_night'], $input['is_available'], $input['room_id']]);
            echo json_encode(['success' => true, 'message' => 'Room updated']);
        }
        // 3. Update User
        elseif (isset($input['user_id'])) {
            $stmt = $conn->prepare("UPDATE users SET name = ?, phone = ?, role = ? WHERE user_id = ?");
            $stmt->execute([$input['name'], $input['phone'], $input['role'], $input['user_id']]);
            echo json_encode(['success' => true, 'message' => 'User updated']);
        }
        // 4. Update Service (ADDED THIS BLOCK)
        elseif (isset($input['service_id'])) {
            $stmt = $conn->prepare("UPDATE services SET name = ?, description = ?, price = ?, duration_minutes = ? WHERE service_id = ?");
            $stmt->execute([
                $input['name'], 
                $input['description'], 
                $input['price'], 
                $input['duration_minutes'], 
                $input['service_id']
            ]);
            echo json_encode(['success' => true, 'message' => 'Service updated']);
        }
        else {
            echo json_encode(['success' => false, 'error' => 'No valid ID provided for update']);
        }
    } catch (Exception $e) {
        echo json_encode(['success' => false, 'error' => $e->getMessage()]);
    }
    exit;
}
?>