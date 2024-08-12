<?php

// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 0); // Disable display errors for production
ini_set('log_errors', 1);
ini_set('error_log', 'path/to/error.log'); // Set the path to the error log

// Include the database connection file
include '../connection.php';

// Start session management
session_start();

// Set the content type to JSON
header('Content-Type: application/json');

// Retrieve and trim user input from POST request
$userEmail = trim($_POST['email']);
$userPassword = trim($_POST['password']);

// Prepare SQL query to select user by email
$sqlQuery = "SELECT * FROM loginsignup WHERE email = ?";
$stmt = $connectNow->prepare($sqlQuery);

if (!$stmt) {
    echo json_encode(array("success" => false, "error" => "Failed to prepare statement"));
    exit();
}

$stmt->bind_param("s", $userEmail);
$stmt->execute();
$resultofquery = $stmt->get_result();

if ($resultofquery->num_rows > 0) {
    $row = $resultofquery->fetch_assoc();
    // Verify the provided password against the password in the database
    if ($userPassword === $row['password']) {
        $_SESSION['user_id'] = $row['id'];
        $_SESSION['user_email'] = $row['email'];
        echo json_encode(array("success" => true));
    } else {
        echo json_encode(array("success" => false, "error" => "Invalid password"));
    }
} else {
    echo json_encode(array("success" => false, "error" => "Email not found"));
}
?>
