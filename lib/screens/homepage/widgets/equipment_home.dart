import 'package:flutter/material.dart';

class EquipmentHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/equipment.png',
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'My equipment',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Undrawn amount KES0',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
