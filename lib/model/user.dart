class User {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String birth_date;
  final String image;

  User(
      {this.id,
      this.name,
      this.mobile,
      this.email,
      this.birth_date,
      this.image});

  factory User.fromjson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        mobile: json['phone'],
        email: json['email'],
        birth_date: json['dob'] != null ? json['dob'] : '',
        image: json['profile']);
  }
}
