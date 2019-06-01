import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_io_19/data/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<String> getCurrentUser();

  Future<void> signOut();

  Future<void> addUser(User user);

  Future<bool> checkUserExist(String userID);

  Future<DocumentSnapshot> getUser(String userId);
  Future<FirebaseUser> googleSignIn(BuildContext context);
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  final GoogleSignIn _googleSing = GoogleSignIn();
  
  Future<FirebaseUser> googleSignIn(BuildContext context) async {
    GoogleSignInAccount googleSignInAccount = await _googleSing.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: gSA.accessToken, idToken: gSA.idToken);
    FirebaseUser user = await _firebaseAuth.signInWithCredential(credential);
    
    User usuario = User(
      uId: user.uid,
      email: user.email,
      nombre: user.displayName
    );

    await addUser(usuario);
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user?.uid;
  }

  Future<DocumentSnapshot> getUser(String userId) async {
    return await Firestore.instance.collection('users').document(userId).get();
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> addUser(User user) async {
    await checkUserExist(user.uId).then((value) async {
      if (!value) {
        await _firestore
            .document('users/${user.uId}')
            .setData(user.toJson())
            .catchError((e) => print(e));
      } else {
        print("user ${user.nombre} ${user.email} exists");
      }
    });
  }

  Future<bool> checkUserExist(String userID) async {
    bool exists = false;
    try {
      await _firestore.document("users/$userID").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }
}
