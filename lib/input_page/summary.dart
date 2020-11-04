import 'package:flutter/material.dart';

class InputSummary extends StatelessWidget {
  final gender;
  final double weight, height;

  const InputSummary({Key key, this.gender, this.height, this.weight})
      : super(key: key);

  int getValue(int max, double value) {
    return ((max) * (value)).round();
  }

  Widget _text(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(143, 144, 156, 1.0),
        fontSize: 15.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 10,
      color: Color.fromRGBO(160, 160, 160, 0.3),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = Size.copy(MediaQuery.of(context).size);
    return Padding(
      padding: EdgeInsets.only(left: _size.width / 8, right: _size.width / 8),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
                child: FlatButton(
                    onPressed: _flipWeightUnit(),
                    child: _text("${getValue(142, weight)} ${WUnit}"))),
            _divider(),
            Expanded(child: _text("$gender")),
            _divider(),
            Expanded(
                child: FlatButton(
                    onPressed: _flipHeightUnit(),
                    child: _text("${getValue(211, height)} ${HUnit}"))),
          ],
        ),
      ),
    );
  }
}
