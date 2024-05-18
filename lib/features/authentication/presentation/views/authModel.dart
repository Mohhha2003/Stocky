class User {
  String? id;
  String name;
  String email;
  String password;
  String? image;

  User(
      {required this.name,
      required this.email,
      required this.password,
      this.id,
      this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      // image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id ?? 'noid';
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['image'] = image;
    return data;
  }
}
