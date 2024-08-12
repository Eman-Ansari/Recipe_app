<?php

include '../connection.php'; // Ensure this file contains a valid database connection
header('Content-Type: application/json');
date_default_timezone_set('America/New_York');

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

ob_clean(); 

session_start(); // Start session to use session variables

$response = ['success' => false, 'error' => 'Unknown error']; // Default response

if (isset($_POST['email']) && isset($_POST['otp'])) {
    $email = trim($_POST['email']);
    $otp = trim($_POST['otp']);

    file_put_contents('debug.log', "Received Email: $email, Received OTP: $otp, Current Time: " . date('Y-m-d H:i:s') . "\n", FILE_APPEND);

    $sql = "SELECT * FROM loginsignup WHERE email = ? AND otp_code = ?";
    file_put_contents('debug.log', "SQL Query: $sql\n", FILE_APPEND);

    $stmt = $connectNow->prepare($sql);
    if ($stmt === false) {
        file_put_contents('debug.log', "Prepare failed: " . $connectNow->error . "\n", FILE_APPEND);
        $response = ['success' => false, 'error' => 'Failed to prepare statement.'];
    } else {
        $stmt->bind_param("si", $email, $otp);

        if ($stmt->execute()) {
            $result = $stmt->get_result();
            if ($result->num_rows > 0) {
                $update_sql = "UPDATE loginsignup SET otp_code = 0 WHERE email = ? AND otp_code = ?";
                file_put_contents('debug.log', "Update SQL Query: $update_sql\n", FILE_APPEND);

                $update_stmt = $connectNow->prepare($update_sql);
                if ($update_stmt === false) {
                    file_put_contents('debug.log', "Update prepare failed: " . $connectNow->error . "\n", FILE_APPEND);
                    $response = ['success' => false, 'error' => 'Failed to prepare update statement.'];
                } else {
                    $update_stmt->bind_param("si", $email, $otp);

                    if ($update_stmt->execute()) {
                        $fetch_data = $result->fetch_assoc();
                        $_SESSION['name'] = $fetch_data['username'];
                        $_SESSION['email'] = $fetch_data['email'];

                        $response = ['success' => true];
                    } else {
                        file_put_contents('debug.log', "Update execution failed: " . $update_stmt->error . "\n", FILE_APPEND);
                        $response = ['success' => false, 'error' => 'Failed while updating OTP.'];
                    }
                    $update_stmt->close();
                }
            } else {
                $response = ['success' => false, 'error' => 'Invalid or expired OTP'];
            }
        } else {
            $response = ['success' => false, 'error' => 'Database query failed: ' . $stmt->error];
        }

        $stmt->close();
    }
} else {
    $response = ['success' => false, 'error' => 'Email and OTP are required'];
}

file_put_contents('debug.log', "Response: " . json_encode($response) . "\n", FILE_APPEND);

echo json_encode($response);
?>
