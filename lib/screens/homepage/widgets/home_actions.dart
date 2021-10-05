import 'package:earn_miles/screens/faq/faq.dart';
import 'package:earn_miles/screens/message_center/message_center_screen.dart';
import 'package:earn_miles/screens/transcations/deposit_screen.dart';
import 'package:earn_miles/screens/transcations/withdraw_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeActionsIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String routeName;
  HomeActionsIcon({this.title, this.icon, this.color, this.routeName});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, routeName),
        child: Container(
          height: 80,
          margin: EdgeInsets.fromLTRB(0, 10, 10, 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey[100],
                  spreadRadius: 1,
                )
              ]),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                icon,
                color: color,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 13),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class HomeActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 15,
          ),
          HomeActionsIcon(
            title: 'Deposit',
            icon: FontAwesomeIcons.coins,
            color: Colors.amber,
            routeName: DepositScreen.routeName,
          ),
          HomeActionsIcon(
            title: 'Withdraw',
            icon: FontAwesomeIcons.coins,
            color: Colors.lightGreen,
            routeName: WithdrawScreen.routeName,
          ),
          HomeActionsIcon(
            title: 'Message',
            icon: FontAwesomeIcons.solidCommentDots,
            color: Colors.blue,
            routeName: MessageCenterScreen.routeName,
          ),
          HomeActionsIcon(
            title: 'FAQ',
            icon: FontAwesomeIcons.solidQuestionCircle,
            color: Colors.purple,
            routeName: FAQ.routeName,
          ),
        ],
      ),
    );
  }
}
