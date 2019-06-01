import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class ViewDetail extends StatelessWidget {
  final File imageFile;
  final List<Barcode> faces;

  ViewDetail(this.imageFile, this.faces);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class FacesCoordinates extends StatelessWidget {
  final Barcode face;

  FacesCoordinates(this.face);

  @override
  Widget build(BuildContext context) {
    //final pos = face.label; face.displayValue
    return ListTile(
      //title: Text('(${pos.top}),(${pos.bottom}),(${pos.right}),(${pos.left})'),
      title: Text(
        face.displayValue,
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
