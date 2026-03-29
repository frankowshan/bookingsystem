<?php
require_once 'config.php';

$input = json_decode(file_get_contents('php://input'), true);

if (empty($input['name']) || empty($input['email']) || empty($input['password']) || empty($input['phone'])) {
    echo json_encode(['success' => false, 'error' => 'All fields are required']);
    exit;
}

$stmt = $conn->prepare("SELECT user_id FROM users WHERE email = ?");
$stmt->execute([$input['email']]);
if ($stmt->fetch()) {
    echo json_encode(['success' => false, 'error' => 'Email already registered']);
    exit;
}

$stmt = $conn->prepare("INSERT INTO users (name, email, phone, password, role) VALUES (?, ?, ?, ?, ?)");
$stmt->execute([
    $input['name'],
    $input['email'],
    $input['phone'],
    $input['password'],
    $input['role'] ?? 'customer'
]);

echo json_encode([
    'success' => true,
    'message' => 'Account created!',
    'user_id' => (int)$conn->lastInsertId()
]);