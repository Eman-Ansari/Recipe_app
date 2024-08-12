class API {
  static const hostConnect = "http://172.29.0.1/db_project_database";
  static const hostConnectUser = "$hostConnect/user";

  static const validateEmail = "$hostConnect/user/validate_email.php";
  static const SignUp = "$hostConnect/user/signup.php";

  static const Login = "$hostConnect/user/login.php"; // Add this line
  static const ForgotPassword =
      "$hostConnectUser/forgot_password.php"; // Ensure this is correct
}
