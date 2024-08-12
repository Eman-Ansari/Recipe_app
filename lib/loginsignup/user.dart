class User {
  String user_name;
  String user_email;
  String user_password;
  User(this.user_name, this.user_email, this.user_password);
  Map<String, dynamic> toJson() => {
        'username': user_name.toString(),
        'email': user_email.toString(),
        'password': user_password.toString(),
      };
}
