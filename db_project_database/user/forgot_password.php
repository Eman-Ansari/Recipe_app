<?php
session_start();
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
require '../vendor/autoload.php';
include '../connection.php'; // Include your database connection
header('Content-Type: application/json');

$mail = new PHPMailer(true);
try {
    // Generate a 6-digit OTP code
    $otpCode = random_int(100000, 999999);
    $otpExpiry = date('Y-m-d H:i:s', strtotime('+10 minutes')); // OTP valid for 10 minutes
    
    $userEmail = $_POST['email']; // Get this from a form submission or other means

    // Store OTP code and expiry in the database
    $stmt = $connectNow->prepare("UPDATE loginsignup SET otp_code = ?, otp_expiry = ? WHERE email = ?");
    $stmt->bind_param("iss", $otpCode, $otpExpiry, $userEmail);
    if (!$stmt->execute()) {
        throw new Exception('Failed to store OTP code');
    }
    $stmt->close();

    // Set up email
    $mail->SMTPDebug = 0; // Disable debug output
    $mail->isSMTP();
    $mail->Host = 'smtp.gmail.com';
    $mail->SMTPAuth = true;
    $mail->Username = 'emanmehmoodansari@gmail.com'; // Your Gmail address
    $mail->Password = 'bowqyhofbeyczmsv'; // Your app password
    $mail->SMTPSecure = 'tls';
    $mail->Port = 587;
    $mail->setFrom('emanmehmoodansari@gmail.com', 'Mailer');
    $mail->addAddress($userEmail); // Recipient's email
    $mail->isHTML(true);
    $mail->Subject = 'Password Reset OTP Code';
    $mail->Body    = "
        <p>We received a request to reset your password. Your OTP code is:</p>
        <h2>$otpCode</h2>
        <p>This OTP is valid for 10 minutes. If you did not request this, please ignore this email.</p>
    ";
    $mail->AltBody = "We received a request to reset your password. Your OTP code is: $otpCode. This OTP is valid for 10 minutes. If you did not request this, please ignore this email.";
    $mail->send();

    echo json_encode(['success' => true, 'message' => 'OTP code sent successfully']);
} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => $mail->ErrorInfo]);
}
?>
