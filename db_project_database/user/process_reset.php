<?php
session_start();
include '../connection.php'; // Ensure this file contains a valid database connection

header('Content-Type: application/json');

// Debugging session variable
error_log("Session ID: " . session_id());
error_log("Session Email: " . (isset($_SESSION['email']) ? $_SESSION['email'] : 'Not set'));

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    error_log("POST Data: " . print_r($_POST, true));

    if (isset($_POST['change-password'])) {
        $_SESSION['info'] = "";
        $password = $_POST['password'];
        $cpassword = $_POST['cpassword'];

        if ($password !== $cpassword) {
            echo json_encode(['success' => false, 'error' => 'Confirm password does not match!']);
            exit();
        }

        if (!isset($_SESSION['email'])) {
            error_log("Session expired: Session email not set");
            echo json_encode(['success' => false, 'error' => 'Session expired. Please try again.']);
            exit();
        }

        $email = $_SESSION['email'];
        $encpass = password_hash($password, PASSWORD_BCRYPT);
        $code = 0;

        $update_pass = "UPDATE loginsignup SET code = ?, password = ? WHERE email = ?";
        $stmt = $con->prepare($update_pass);
        if ($stmt === false) {
            echo json_encode(['success' => false, 'error' => 'Failed to prepare SQL statement']);
            exit();
        }

        $stmt->bind_param("iss", $code, $encpass, $email);
        if ($stmt->execute()) {
            $_SESSION['info'] = "Your password has been changed. Now you can login with your new password.";
            echo json_encode(['success' => true, 'message' => 'Password changed successfully']);
        } else {
            echo json_encode(['success' => false, 'error' => 'Failed to change your password!']);
        }

        $stmt->close();
    } else {
        error_log("Invalid request: missing 'change-password' parameter");
        echo json_encode(['success' => false, 'error' => 'Invalid request']);
    }
} else {
    error_log("Invalid request method: " . $_SERVER['REQUEST_METHOD']);
    echo json_encode(['success' => false, 'error' => 'Invalid request']);
}
?>
