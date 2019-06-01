import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_io_19/widget/sliding_card.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

class SlidingCardsView extends StatefulWidget {
  SlidingCardsView({Key key}) : super(key: key);

  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;

  File _imageFile;
  List<Face> _faces = [];
  List<Barcode> _barcodes = [];
  VisionText _texts;
  List<ImageLabel> _imageLabels = [];

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
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
            onPressed: () {},
          ),
          SlidingCard(
            title: 'Ml-Kit',
            description: '4-20-30',
            assetName: 'detection.jpg',
            offset: pageOffset - 1,
            onPressed: () {},
          ),
          SlidingCard(
            title: 'Ml-Kit',
            description: '4-20-30',
            assetName: 'detection.jpg',
            offset: pageOffset - 2,
            onPressed: () {},
          ),
          SlidingCard(
            title: 'Ml-Kit',
            description: '4-20-30',
            assetName: 'detection.jpg',
            offset: pageOffset - 3,
            onPressed: () {},
          )
        ],
      ),
    );
  }

  void _getImageAndDetectBarcodes() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final image = FirebaseVisionImage.fromFile(imageFile);
    final barCodeDetector = FirebaseVision.instance.barcodeDetector();
    final barcodes = await barCodeDetector.detectInImage(image);
    if (mounted) {
      setState(() {
        print('mounted');
        _imageFile = imageFile;
        _barcodes = barcodes;
      });
    }
  }

  void _getImageAndDetectText() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final image = FirebaseVisionImage.fromFile(imageFile);
    final barCodeDetector = FirebaseVision.instance.textRecognizer();
    final texts = await barCodeDetector.processImage(image);
    if (mounted) {
      setState(() {
        print('mounted');
        _imageFile = imageFile;
        _texts = texts;
      });
    }
  }

  void _getImageAndDetectFaces() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final image = FirebaseVisionImage.fromFile(imageFile);
    final barCodeDetector = FirebaseVision.instance.faceDetector();
    final faces = await barCodeDetector.processImage(image);
    if (mounted) {
      setState(() {
        print('mounted');
        _imageFile = imageFile;
        _faces = faces;
      });
    }
  }

  void _getImageAndDetectImageLabeler() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final image = FirebaseVisionImage.fromFile(imageFile);
    final barCodeDetector = FirebaseVision.instance.imageLabeler();
    final imageLabels = await barCodeDetector.processImage(image);
    if (mounted) {
      setState(() {
        print('mounted');
        _imageFile = imageFile;
        _imageLabels = imageLabels;
      });
    }
  }
}
