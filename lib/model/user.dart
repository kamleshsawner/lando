class User {
  final int id;
  final String name_title;
  final String fname;
  final String lname;
  final String mobile;
  final String email;
  final String birth_date;
  final String type;
  final String full_name;
  final String is_verified;
  final String image;

  User(
      {this.id,
      this.name_title,
      this.fname,
      this.lname,
      this.mobile,
      this.email,
      this.birth_date,
      this.type,
      this.full_name,
      this.is_verified,
      this.image});

  factory User.fromjson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name_title: json['title'],
        fname: json['first_name'],
        lname: json['last_name'],
        mobile: json['mobile'],
        email: json['email'],
        birth_date: json['birth_date'],
        type: json['type'],
        full_name: json['name'],
        is_verified: json['is_verified'],
        image: json['image']);
  }
}
