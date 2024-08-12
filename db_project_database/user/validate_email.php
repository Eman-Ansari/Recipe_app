<?php
session_start();
include '../connection.php';
$userEmail = $_POST['email'];

$sqlQuery = "SELECT * FROM loginsignup WHERE email = ?";
$stmt = $connectNow->prepare($sqlQuery);
$stmt->bind_param("s", $userEmail);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    echo json_encode(["emailfound" => true]);
} else {
    echo json_encode(["emailfound" => false]);
}

$stmt->close();
?>
