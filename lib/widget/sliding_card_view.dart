import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_io_19/screen/view_detail.dart';
import 'package:flutter_firebase_io_19/screen/view_detail_faces.dart';
import 'package:flutter_firebase_io_19/screen/view_detail_labels.dart';
import 'package:flutter_firebase_io_19/screen/view_detail_text.dart';
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
            title: 'Image And Detect Barcodes',
            description: '',
            assetName: 'qr.png',
            offset: pageOffset,
            onPressed: _getImageAndDetectBarcodes,
          ),
          SlidingCard(
            title: 'Image And Detect Text',
            description: '4-20-30',
            assetName: 'text.png',
            offset: pageOffset - 1,
            onPressed: _getImageAndDetectText,
          ),
          SlidingCard(
            title: 'Image And Detect Image   Labeler',
            description: '4-20-30',
            assetName: 'context.png',
            offset: pageOffset - 2,
            onPressed: _getImageAndDetectImageLabeler,
          )
        ],
      ),
    );
  }

  void _getImageAndDetectBarcodes() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    final image = FirebaseVisionImage.fromFile(imageFile);
    final barCodeDetector = FirebaseVision.instance.barcodeDetector();
    final barcodes = await barCodeDetector.detectInImage(image);
    if (mounted) {
      print('barcodes ${barcodes.length}');
       Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewDetail(
                  imageFile: imageFile,
                  faces: barcodes,
                )));
    }
  }

  void _getImageAndDetectText() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    final image = FirebaseVisionImage.fromFile(imageFile);
    final barCodeDetector = FirebaseVision.instance.textRecognizer();
    final texts = await barCodeDetector.processImage(image);
    if (mounted && imageFile != null) {
      setState(() {
        print('mounted');
        _imageFile = imageFile;
        _texts = texts;
      });

       Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewDetailText(
                  imageFile: imageFile,
                  texts: texts,
                )));

    }
  }

  void _getImageAndDetectFaces() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    final image = FirebaseVisionImage.fromFile(imageFile);
    final barCodeDetector = FirebaseVision.instance.faceDetector();
    List<Face> faces = await barCodeDetector.processImage(image);
    print(faces[0].boundingBox);
    if (mounted) {
         Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewDetailFaces(
                  imageFile: imageFile,
                  faces: faces,
                )));
    }
  }

  void _getImageAndDetectImageLabeler() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    final image = FirebaseVisionImage.fromFile(imageFile);
    final barCodeDetector = FirebaseVision.instance.imageLabeler();
    final imageLabels = await barCodeDetector.processImage(image);
    if (mounted) {

       Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewDetailImageLabel(
                  imageFile: imageFile,
                  faces: imageLabels,
                )));
    }
  }
}
