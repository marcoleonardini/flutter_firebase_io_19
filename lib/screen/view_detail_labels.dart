import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class ViewDetailImageLabel extends StatelessWidget {
  final File imageFile;
  final List<ImageLabel> faces;

  ViewDetailImageLabel({this.imageFile, this.faces});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Image And Detect Barcodes',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              constraints: BoxConstraints.expand(),
              child: imageFile != null
                  ? Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/imgs/placeholder.png'),
            ),
          ),
          Flexible(
            flex: 2,
            child: ListView(
                children: faces.map<Widget>((f) => FacesCoordinates(f)).toList()),
          )
        ],
      ),
    );
  }
}

class FacesCoordinates extends StatelessWidget {
  final ImageLabel face;

  FacesCoordinates(this.face);

  @override
  Widget build(BuildContext context) {
    print('face.displayValue ${face.text}');
    //final pos = face.label; face.displayValue
    return ListTile(
      
      //title: Text('(${pos.top}),(${pos.bottom}),(${pos.right}),(${pos.left})'),
      title: Text(
        '${face.text} : ${face.confidence}',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
