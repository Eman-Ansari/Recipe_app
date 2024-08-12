<?php
session_start();
include '../connection.php';
$userName = $_POST['username'];
$userEmail = $_POST['email'];
$userPassword = password_hash($_POST['password'], PASSWORD_BCRYPT);

$sqlQuery = "INSERT INTO loginsignup (username, email, password) VALUES (?, ?, ?)";
$stmt = $connectNow->prepare($sqlQuery);
$stmt->bind_param("sss", $userName, $userEmail, $userPassword);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "error" => $stmt->error]);
}

$stmt->close();
?>
