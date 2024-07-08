class User {
  String? firstName;
  String? lastName;
  String? email;
  int? id;

  User({this.firstName, this.lastName, this.email, this.id});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['id'] = this.id;
    return data;
  }
}
