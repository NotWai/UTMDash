class UserClass {
  final String uid;

  UserClass({required this.uid});
}


class UserData {
  final String uid;
  final String fullName;
  final String phoneNumber;
  final String emailAddress;

  UserData({
    required this.uid,
    required this.fullName,
    required this.phoneNumber,
    required this.emailAddress,
  });
}

class UserObject {
  final String fullName;
  final String phoneNumber;
  final String emailAddress;

  UserObject({
    required this.fullName,
    required this.phoneNumber,
    required this.emailAddress,
  });
}
