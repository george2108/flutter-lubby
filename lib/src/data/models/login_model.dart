class LoginModel {
  String email;
  String password;

  LoginModel({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return ({
      "email": email,
      "password": password,
    });
  }

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
        email: json["email"],
        password: json["password"],
      );
}
