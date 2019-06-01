import 'package:flutter/material.dart';
import 'package:flutter_firebase_io_19/service/auth.dart';

class AuthProvider extends InheritedWidget {
  AuthProvider({Key key, Widget child, this.auth})
      : super(key: key, child: child);
  final Auth auth;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AuthProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AuthProvider) as AuthProvider);
  }
}