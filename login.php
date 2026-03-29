<?php
require_once 'config.php';

$input = json_decode(file_get_contents('php://input'), true);

$email = $input['email'] ?? '';
$password = $input['password'] ?? '';

if (empty($email) || empty($password)) {
    echo json_encode(['success' => false, 'error' => 'Email and password are required']);
    exit;
}

$stmt = $conn->prepare("SELECT * FROM users WHERE email = ? AND is_active = 1");
$stmt->execute([$email]);
$user = $stmt->fetch();

if ($user && $user['password'] === $password) {
    echo json_encode([
        'success' => true,
        'message' => 'Login successful',
        'user' => [
            'id' => (int)$user['user_id'],
            'name' => $user['name'],
            'email' => $user['email'],
            'role' => $user['role']
        ]
    ]);
} else {
    echo json_encode(['success' => false, 'error' => 'Invalid email or password']);
}