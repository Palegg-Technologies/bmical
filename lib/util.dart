import 'package:flutter/material.dart';
import 'dart:math' as math;

int getValue(int max, double value) {
  return ((max) * (value)).round();
}

class FadeRoute<T> extends MaterialPageRoute<T> {
  FadeRoute({required WidgetBuilder builder, required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 900);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}

num calculateBMI({required int height, required int weight}) =>
    weight / _heightSquared(height);

num calculateMinNormalWeight({required int height}) => 18.5 * _heightSquared(height);

num calculateMaxNormalWeight({required int height}) => 25 * _heightSquared(height);

num _heightSquared(int height) => math.pow(height / 100, 2);

