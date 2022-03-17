import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AppDevTeamFirebaseUser {
  AppDevTeamFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

AppDevTeamFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AppDevTeamFirebaseUser> appDevTeamFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<AppDevTeamFirebaseUser>(
            (user) => currentUser = AppDevTeamFirebaseUser(user));
