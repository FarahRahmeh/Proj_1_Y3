class User {
  // final variable = do NOT want to update it
  String? email;
  String? role;
  String? name;

  User({
    this.email,
    this.role,
    this.name,
  });

  static User empty() => User(name: '', email: '', role: '');

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
    };
  }

  factory User.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData.isNotEmpty) {
      return User(
        name: jsonData['name'] ?? '',
        email: jsonData['email'] ?? '',
        role: jsonData['role'] ?? '',
      );
    } else {
      return User.empty();
    }
  }
}
