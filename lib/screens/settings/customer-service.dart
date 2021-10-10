import 'package:earn_miles/constants.dart';
import 'package:earn_miles/models/social_group_model.dart';
import 'package:earn_miles/providers/general_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerService extends StatelessWidget {
  static const routeName = '/customer-service';
  @override
  Widget build(BuildContext context) {
    final groupData = Provider.of<GeneralProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Service'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          GroupCategory(
            title: 'WhatsApp Customer Service List',
            groups: groupData.waService,
          ),
          GroupCategory(
            title: 'Telegram Members\' Groups List',
            groups: groupData.tgMembers,
          ),
          GroupCategory(
            title: 'Whatsapp Members\' Groups List',
            groups: groupData.waMembers,
          ),
          GroupCategory(
            title: 'Telegram Customer Service List',
            groups: groupData.tgService,
          ),
        ],
      ),
    );
  }
}

class GroupCategory extends StatelessWidget {
  final List<SocialGroupModel> groups;
  final String title;
  GroupCategory({this.title, this.groups});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ExpansionTile(
          title: Row(
            children: [
              Container(
                height: 20,
                width: 5,
                color: Colors.amber[200],
              ),
              SizedBox(
                width: 8,
              ),
              Text(title),
            ],
          ),
          children: groups.map((e) => GroupItem(e)).toList()),
    );
  }
}

class GroupItem extends StatelessWidget {
  final SocialGroupModel group;
  GroupItem(this.group);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launch(group.link);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Icon(
              Icons.headset_mic,
              color: Colors.amber,
            ),
            SizedBox(width: 10),
            Expanded(child: Container(child: Text(group.name)))
          ],
        ),
      ),
    );
  }
}
