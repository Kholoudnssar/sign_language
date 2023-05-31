class User_Data {
  static const String CollecationName = 'user';
  String id;
  String fName;
  String lName;
  String userName;
  String email;

  User_Data(
      {required this.id,
      required this.fName,
      required this.lName,
      required this.userName,
      required this.email});

  User_Data.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          fName: json['fName'] as String,
          lName: json['lName'] as String,
          userName: json['userName'] as String,
          email: json['email'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fName': fName,
      'lName': lName,
      'userName': userName,
      'email': email,
    };
  }
}
