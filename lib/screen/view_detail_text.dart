  import 'dart:io';

  import 'package:flutter/material.dart';
  import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/rendering.dart';

  class ViewDetailText extends StatelessWidget {
    final File imageFile;
    final VisionText texts;

    ViewDetailText({this.imageFile, this.texts,});

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
          elevation: 0.0,),
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
              child: Center(
                child: Text(
                  '${texts.text}',style: TextStyle(fontSize: 16),
                ),
              ))
          ],
        ),
      );
    }
  }
