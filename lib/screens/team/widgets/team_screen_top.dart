import 'package:earn_miles/constants.dart';
import 'package:flutter/material.dart';

class TeamScreenTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.15,
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.transparent,
                ],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Container(
              height: size.height * 0.15,
              color: kPrimaryColor,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    'Refferal Program',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: Text(
              'Refferal bonus from friends in tier one',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
