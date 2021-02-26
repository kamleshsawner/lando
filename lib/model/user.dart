class User {
  final int id;
  final String firebase_chatid;
  final String name;
  final String email;
  final String mobile;
  final String birth_date;
  final String image;
  final String gender;

  User(
      {this.id,
        this.firebase_chatid,
      this.name,
      this.mobile,
      this.email,
      this.birth_date,
      this.image,
      this.gender,
      });

  factory User.fromjson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firebase_chatid: json['firebase_chatid'],
        name: json['name'],
        mobile: json['phone'],
        email: json['email'],
        birth_date: json['dob'] != null ? json['dob'] : '',
        image: json['profile'],
        gender: json['gender'] != null ? json['gender'] : '');
  }
}
