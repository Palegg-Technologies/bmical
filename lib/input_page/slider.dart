import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bmical/util.dart';

class CustomSliderThumbRect extends SliderComponentShape {
  final double thumbRadius;
  final thumbHeight;
  final int min, max, rotation;

  const CustomSliderThumbRect({
    this.thumbRadius,
    this.thumbHeight,
    this.min,
    this.max,
    this.rotation,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        Animation<double> activationAnimation,
        Animation<double> enableAnimation,
        bool isDiscrete,
        TextPainter labelPainter,
        RenderBox parentBox,
        SliderThemeData sliderTheme,
        TextDirection textDirection,
        double value,
      }) {
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center, width: thumbHeight * 1.2, height: thumbHeight * .7),
      Radius.circular(thumbRadius * .4),
    );

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
        style: new TextStyle(
            fontSize: thumbHeight * .3,
            fontWeight: FontWeight.w700,
            color: sliderTheme.thumbColor,
            height: 0.9),
        text: '${getValue(max, value)}');
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.rtl);
    tp.layout();
    Offset textCenter =
    Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));
    canvas.drawRRect(rRect, paint);
    tp.paint(canvas, textCenter);
  }
}

class SliderWidget extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final person, onChange, sColors;
  final String type;
  final fullWidth;

  SliderWidget(
      {this.sliderHeight = 42,
        this.person,
        this.type,
        this.min = 0,
        this.onChange,
        this.fullWidth = false,
      this.sColors});

  int get max => type == 'W' ? 142 : 211;
  int get rotation => type == 'W'? -1 : 1;
  List<Color> get kgrad => type == 'W' ? sColors : [sColors[1], sColors[0]];

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    double paddingFactor = .2;

    if (this.widget.fullWidth) paddingFactor = .3;

    return Container(
      width: this.widget.sliderHeight * 10.0,
      height: this.widget.sliderHeight * 1.0,
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(
          Radius.circular(this.widget.sliderHeight * .3),
        ),
        gradient: new LinearGradient(
            colors: this.widget.kgrad,
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.00),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(this.widget.sliderHeight * paddingFactor,
            2, this.widget.sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            RotatedBox(
              quarterTurns: this.widget.rotation,
              child: Text(
                '${this.widget.min}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: this.widget.sliderHeight * .3,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: widget.sliderHeight * 0.02,
            ),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white.withOpacity(1),
                    inactiveTrackColor: Colors.white.withOpacity(.5),
                    trackHeight: 4.0,
                    thumbShape: CustomSliderThumbRect(
                      thumbHeight: this.widget.sliderHeight * .7,
                      thumbRadius: this.widget.sliderHeight * .35,
                      min: this.widget.min,
                      max: this.widget.max,
                      rotation: this.widget.rotation,
                    ),
                    overlayColor: Colors.white.withOpacity(.4),
//valueIndicatorColor: Colors.white,
                    activeTickMarkColor: Colors.white,
                    inactiveTickMarkColor: Colors.red.withOpacity(.7),
                  ),
                  child: Slider(
                    value: this.widget.type == 'W'
                        ? this.widget.person.weight
                        : this.widget.person.height,
                    onChanged: this.widget.onChange,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: this.widget.sliderHeight * .02,
            ),
            RotatedBox(
              quarterTurns: this.widget.rotation,
              child: Text(
                '${this.widget.max}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: this.widget.sliderHeight * .3,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
