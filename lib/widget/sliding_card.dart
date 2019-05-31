import 'package:flutter/material.dart';
import 'dart:math' as math;

class SlidingCard extends StatelessWidget {
  final String title;
  final String description;
  final String assetName;
  final VoidCallback onPressed;
  final double offset;
  const SlidingCard(
      {Key key, this.assetName,  this.offset, this.title, this.description, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));

    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
          child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                child: Container(
                  width: double.infinity,
                  color: Color(0xFF039BE5),
                  child: Image.asset(
                    'assets/$assetName',
                    alignment: Alignment(-offset.abs(), 0),
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.none,
                  ),
                )),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: CardContent(
                title: title,
                description: description,
                onPressed: onPressed,
                offset: gauss,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPressed;
  final double offset;
  const CardContent({Key key, this.offset, this.title, this.description, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            description,
            style: TextStyle(color: Colors.grey),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Transform.translate(
                offset: Offset(48 * offset, 0),
                child: RaisedButton(
                  color: Color(0xFF162A49),
                  child: Transform.translate(
                    offset: Offset(24 * offset, 0),
                    child: Text('Probar')),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  onPressed: onPressed,
                ),
              ),
              Spacer(),
              Transform.translate(
                 offset: Offset(24 * offset, 0),
                child: Text(
                  '1 test',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                width: 16,
              )
            ],
          )
        ],
      ),
    );
  }
}
