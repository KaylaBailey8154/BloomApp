class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String fullName;
  final String companyName;
  final String phoneNumber;
  final String role;

  UserData(
      {this.uid, this.fullName, this.companyName, this.phoneNumber, this.role});
}
