
<?php
$serverHost = 'localhost';
$user = 'root';
$password = "";
$database = 'databaseproject';
$connectNow = new mysqli($serverHost, $user, $password, $database);

if ($connectNow->connect_error) {
    die("Connection failed: " . $connectNow->connect_error);
}
?>

