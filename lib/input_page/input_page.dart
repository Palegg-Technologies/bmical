import 'package:bmical/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bmical/input_page/summary.dart';
import 'package:bmical/input_page/slider.dart';
import 'package:bmical/result_page/result_page.dart';
import 'package:lottie/lottie.dart';

class Person {
  double height = 0, weight = 0;
  int gender = 0;

  void _flipGender() {
    gender = 1 - gender;
  }

  void _flipWeightUnit() {}

  void _flipHeightUnit() {}
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Person _person;
  int sliderHeight = 40, min = 0, max = 211;
  double paddingFactor = .2;
  final List<ImageIcon> _iconList = [
    const ImageIcon(
      AssetImage("images/feather.png"),
      color: Colors.white,
    ),
    const ImageIcon(
      AssetImage("images/giraffe.png"),
      color: Colors.white,
    ),
    const ImageIcon(
      AssetImage("images/elephant.png"),
      color: Colors.white,
    ),
    const ImageIcon(
      AssetImage("images/rabbit.png"),
      color: Colors.white,
    ),
  ];
  List<String> genders = ["Male", "Female"];
  final List<String> _gsPics = ["images/person.png", "images/woman.png"];
  int _mode = 0;
  static final List<Color> _modes = [
    const Color(0xffffdd13),
    const Color(0xff672af4)
  ];
  final List<SystemUiOverlayStyle> _sosModes = [
    SystemUiOverlayStyle(
      statusBarColor: _modes[0],
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: _modes[0],
      systemNavigationBarIconBrightness: Brightness.light,
    ),
    SystemUiOverlayStyle(
      statusBarColor: _modes[1],
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: _modes[1],
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ];

  void _flipMode() {
    _mode = 1 - _mode;
    SystemChrome.setSystemUIOverlayStyle(_sosModes[_mode]);
    _mode == 1 ? _controller.forward() : _controller.reverse();
    setState(() {});
  }

  PreferredSize myAppbar(Size size) {
    return PreferredSize(
      preferredSize: size / 12,
      child: AppBar(
        title: const Text(
          'BMI',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: _modes[_mode],
        actions: <Widget>[
          TextButton(
            onPressed: () => _flipMode(),
            child: SizedBox(
              height: size.height / 20,
              child: LottieBuilder.asset(
                "images/data.json",
                controller: _controller,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Map<String, List<Color>> _gsColors = {
    'BG': [const Color(0x7f003f6f), const Color(0x7f850056)],
    'main': [const Color(0xff2198f3), const Color(0xfff713a7)],
    'sGrad1': [const Color(0xFF00c6ff), const Color(0xffff00ff)],
    'sGrad2': [const Color(0xFF0072ff), const Color(0xffff008f)],
  };

  @override
  void initState() {
    _person = Person();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _goToResultPage(color) async {
    Navigator.of(context).push(FadeRoute(
      builder: (context) => ResultPage(
        person: _person,
        color: color,
      ),
      settings: const RouteSettings(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppbar(size),
      backgroundColor:
          _mode == 1 ? _gsColors['BG']![_person.gender] : Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(height: size.height / 40),
          InputSummary(
            gender: genders[_person.gender],
            person: _person,
          ),
          SizedBox(height: size.height / 120),
          _iconRow(_iconList.sublist(0, 2), size.width),
          SizedBox(
            height: size.height / 1.6,
            width: size.width,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: size.width / 30,
                  top: size.height / 90,
                  child: Row(
                    children: [
                      RotatedBox(
                        quarterTurns: 1,
                        child: SliderWidget(
                          person: _person,
                          type: 'W',
                          onChange: (value) {
                            setState(() {
                              _person.weight = value;
                            });
                          },
                          sColors: [
                            _gsColors['sGrad1']![_person.gender],
                            _gsColors['sGrad2']![_person.gender]
                          ],
                        ),
                      ),
                      Card(
                        color: _gsColors['main']![_person.gender],
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width / 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 6.0),
                          child: SizedBox(
                            height: size.height / 1.75,
                            width: size.width / 1.75,
                            child: ButtonTheme(
                              height: size.height / 1.8,
                              minWidth: size.width / 1.875,
                              child: TextButton(
                                onPressed: () => setState(() {
                                  _person._flipGender();
                                }),
                                child: SizedBox(
                                  height: _person.height * 400,
                                  width: _person.weight * 160,
                                  child: Image.asset(
                                    _gsPics[_person.gender],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: -1,
                        child: SliderWidget(
                          person: _person,
                          type: 'H',
                          onChange: (value) {
                            setState(() {
                              _person.height = value;
                            });
                          },
                          sColors: [
                            _gsColors['sGrad1']![_person.gender],
                            _gsColors['sGrad2']![_person.gender]
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _iconRow(_iconList.sublist(2), size.width),
          Hero(
            tag: '1',
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.5,
              child: RawMaterialButton(
                onPressed: () => _goToResultPage(_modes[_mode]),
                fillColor: _modes[_mode],
                elevation: 2.0,
                padding: const EdgeInsets.fromLTRB(80.0, 10.0, 80.0, 69.2),
                shape: const CircleBorder(),
                child: const Column(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                    Text(
                      'BMI',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _iconRow(List<ImageIcon> icons, double w) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: w / 16,
      ),
      icons[0],
      SizedBox(
        width: w / 1.34,
      ),
      icons[1],
    ],
  );
}
