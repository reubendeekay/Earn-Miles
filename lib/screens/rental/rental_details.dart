import 'package:earn_miles/constants.dart';
import 'package:earn_miles/models/solar_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class RentalDetails extends StatelessWidget {
  static const routeName = '/rental-details';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final solar = ModalRoute.of(context).settings.arguments as SolarModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kPrimaryColor.withOpacity(0.1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: size.height * 0.2,
                      child: Lottie.asset(
                        'assets/solarl.json',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        )),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            solar.type,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Row(
                            children: [
                              Text(
                                '${NumberFormat.simpleCurrency(
                                  locale: 'en_US',
                                  name: '',
                                ).format(solar.price)}',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                'KES/90 Days',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Daily income(KES)',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              // Spacer(),
                              Text(
                                '${NumberFormat.simpleCurrency(
                                  locale: 'en_US',
                                  name: '',
                                ).format(solar.dailyIncome)}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total income(KES)',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              // Spacer(),
                              Text(
                                '${NumberFormat.simpleCurrency(
                                  locale: 'en_US',
                                  name: '',
                                ).format(solar.dailyIncome * 90)}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
