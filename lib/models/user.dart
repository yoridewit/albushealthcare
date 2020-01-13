class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final List<String> subscribedChecklists;
  final List<String> ownedChecklists;
  UserData(
      {this.uid, this.name, this.ownedChecklists, this.subscribedChecklists});
}
