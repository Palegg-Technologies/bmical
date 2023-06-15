import 'package:flutter/material.dart';

class InputSummary extends StatelessWidget {
  final gender;
  final person;

  const InputSummary({Key? key, this.gender, this.person})
      : super(key: key);

  int getValue(int max, double value) {
    return ((max) * (value)).round();
  }

  Widget _text(String text) {
    return Text(
      text,
      style: const TextStyle(
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
                child: TextButton(
                    onPressed: ()=>print("weight flip"),
                    child: _text("${getValue(142, person.weight)}"))),
            _divider(),
            Expanded(child: _text("$gender")),
            _divider(),
            Expanded(
                child: TextButton(
                    onPressed: ()=>print("height flip"),
                    child: _text("${getValue(211, person.height)}"))),
          ],
        ),
      ),
    );
  }
}
