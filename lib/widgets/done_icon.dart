import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DoneIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Lottie.asset('assets/done.json'),
    );
  }
}
