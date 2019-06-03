import 'package:flutter/material.dart';
import 'package:flutter_firebase_io_19/screen/splash_screen.dart';
import 'package:flutter_firebase_io_19/service/auth.dart';
import 'package:flutter_firebase_io_19/service/auth_provider.dart';

void main() {
  runApp(AuthProvider(
    auth: Auth(),
    child: MaterialApp(
      title: 'Firebase',
      home: SplashScreen(),
    ),
  ));
}
