import 'package:flutter/material.dart';
import 'package:flutter_firebase_io_19/service/auth.dart';
import 'package:flutter_firebase_io_19/service/auth_provider.dart';
import 'package:flutter_firebase_io_19/widget/exhibition_button_sheet.dart';
import 'package:flutter_firebase_io_19/widget/sliding_card.dart';
import 'package:flutter_firebase_io_19/widget/sliding_card_view.dart';

enum AuthStatus { NOT_DETERMINED, NOT_LOGGED_IN, LOGGED_IN }

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthStatus _authStatus = AuthStatus.NOT_DETERMINED;
  String user;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var auth = AuthProvider.of(context).auth;

    await auth.getCurrentUser().then((uId) async {
      setState(() {
        user = uId;
        _authStatus =
            user == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  _onLoggedIn() {
    setState(() {
      _authStatus = AuthStatus.LOGGED_IN;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Firebase',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          Card(
            elevation: 8,
            child: IconButton(
              icon: Image.asset('assets/google.png'),
              onPressed: () async {
                var auth = Auth();
                try{
                 await auth.googleSignIn(context).then((e){
                   print('se registro');
                 });       
                }catch(e){
                  print(e);
                }
              },
              tooltip: 'Sign in Google count',
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 8,
                ),
                SlidingCardsView()
              ],
            ),
          ),
          ExhibitionBottomSheet()
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: <Widget>[
          Text(
            'Firebase',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
