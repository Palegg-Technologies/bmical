import 'package:flutter/material.dart';
import 'package:bmical/util.dart';

class ResultPage extends StatefulWidget {
  final person, color;
  const ResultPage({Key? key, this.person, this.color}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  PreferredSize myAppbar(Size size) {
    return PreferredSize(
      preferredSize: size / 12,
      child: AppBar(
        title: const Text(
          'BMI',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: widget.color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int height = getValue(211, widget.person.height),
        weight = getValue(142, widget.person.weight);
    return Hero(
      tag: '1',
      child: Scaffold(
        backgroundColor: widget.color,
        appBar: myAppbar(size),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ResultCard(
              bmi: calculateBMI(height: height, weight: weight),
              minWeight: calculateMinNormalWeight(height: height),
              maxWeight: calculateMaxNormalWeight(height: height),
            ),
            _buildBottomBar(widget.person.gender == 0? const Color(0xff2198f3) : const Color(0xfff713a7)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white70,
                size: 28.0,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          SizedBox(
              height: 52.0,
              width: 80.0,
              child: ElevatedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  foregroundColor: color
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 28.0,
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.white70,
                size: 28.0,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final num bmi;
  final num minWeight;
  final num maxWeight;

  ResultCard({Key? key, required this.bmi, required this.minWeight, required this.maxWeight})
      : super(key: key);
  Color? cardColor;
  @override
  Widget build(BuildContext context) {
    String _indicator(bmi) {
      if (bmi < 18.5) {
        cardColor = Colors.deepOrangeAccent;
        return '🤷🏻‍';
      }
      if (bmi < 24.9) {
        cardColor = Colors.green;
        return '💪🏻‍';
      }
      if (bmi < 29.9) {
        cardColor = Colors.yellow;
        return '🏋️‍♀️';
      }
      if (bmi < 39.9) {
        cardColor = Colors.orange;
        return '🐘‍';
      } else {
        cardColor = Colors.red;
        return '🦕';
      }
    }

    return Card(
      color: cardColor,
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Container(
          width: double.infinity,
          child: Column(children: [
            Text(
              _indicator(bmi),
              style: TextStyle(
                fontSize: 80.0,
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                bmi.toStringAsFixed(1),
                style: TextStyle(
                    fontSize: 140.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Text(
              'BMI = ${bmi.toStringAsFixed(2)} kg/m²',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Normal BMI weight range for the height:\n${minWeight.round()}kg - ${maxWeight.round()}kg',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
