import 'package:flutter/material.dart';
import 'package:flutter_firebase_io_19/widget/exhibition_button_sheet.dart';
import 'package:flutter_firebase_io_19/widget/sliding_card.dart';
import 'package:flutter_firebase_io_19/widget/sliding_card_view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                Header(),
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
      child: Text(
        'Firebase',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}