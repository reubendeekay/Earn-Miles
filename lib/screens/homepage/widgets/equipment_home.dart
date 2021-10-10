import 'package:earn_miles/providers/auth_provider.dart';
import 'package:earn_miles/screens/rental/my_solars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EquipmentHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(MySolars.routeName),
      child: Container(
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
                    'Undrawn amount KES${(user.balance - 50).toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
