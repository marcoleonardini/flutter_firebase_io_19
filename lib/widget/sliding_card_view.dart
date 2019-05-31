import 'package:flutter/material.dart';
import 'package:flutter_firebase_io_19/widget/sliding_card.dart';

class SlidingCardsView extends StatefulWidget {
  SlidingCardsView({Key key}) : super(key: key);

  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset =0 ;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener((){
      setState(() {
        pageOffset = pageController.page; 
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView(
        controller: pageController,
        children: <Widget>[
          SlidingCard(
            title: 'Ml-Kit',
            description: '4-20-30',
            assetName: 'logo-logomark.png',
            offset: pageOffset,
            onPressed: (){},
          ),
          SlidingCard(
            title: 'Ml-Kit',
            description: '4-20-30',
            assetName: 'detection.jpg',
            offset: pageOffset-1,
            onPressed: (){},
          ),
          SlidingCard(
            title: 'Ml-Kit',
            description: '4-20-30',
            assetName: 'detection.jpg',
            offset: pageOffset-2,
            onPressed: (){},
          ),
          SlidingCard(
            title: 'Ml-Kit',
            description: '4-20-30',
            assetName: 'detection.jpg',
            offset: pageOffset-3,
            onPressed: (){},
          )
        ],
      ),
    );
  }
}
