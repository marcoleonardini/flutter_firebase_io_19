import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class ViewDetail extends StatelessWidget {
  final File imageFile;
  final List<Barcode> faces;

  ViewDetail({this.imageFile, this.faces});

  @override
  Widget build(BuildContext context) {
    print('faces ${faces.length}');
    return Scaffold(
        appBar: AppBar(
        title: Text(
          'Image And Detect Barcodes',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,),
          body: Column(
        children: <Widget>[
          SizedBox(height: 20.0,),
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
            child: FacesCoordinates(faces[0])
          )
        ],
      ),
    );
  }
}

class FacesCoordinates extends StatelessWidget {
  final Barcode face;

  FacesCoordinates(this.face);

  @override
  Widget build(BuildContext context) {
    print('face.displayValue ${face.displayValue}');
    //final pos = face.label; face.displayValue
    return Center(
      child: Text(
          face.displayValue,
          style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
    );
  }
}
