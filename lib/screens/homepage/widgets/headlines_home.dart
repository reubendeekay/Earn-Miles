import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeadlinesHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text(
              'Headlines Today',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            height: size.height * 0.4,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 130,
                viewportFraction: 0.23,
                initialPage: 0,
                enableInfiniteScroll: true,

                reverse: false,
                autoPlay: true,

                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(seconds: 2),
                autoPlayCurve: Curves.fastOutSlowIn,
                // enlargeCenterPage: true,
                scrollDirection: Axis.vertical,
              ),
              items: [
                HeadlinesWidget(
                  isDeposit: true,
                  price: 1000,
                ),
                HeadlinesWidget(
                  isDeposit: false,
                  price: 600,
                ),
                HeadlinesWidget(
                  isDeposit: false,
                  price: 20000,
                ),
                HeadlinesWidget(
                  isDeposit: true,
                  price: 12000,
                ),
                HeadlinesWidget(
                  isDeposit: false,
                  price: 3000,
                ),
                HeadlinesWidget(
                  isDeposit: true,
                  price: 600,
                ),
                HeadlinesWidget(
                  isDeposit: true,
                  price: 7000,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeadlinesWidget extends StatelessWidget {
  final bool isDeposit;
  final double price;
  HeadlinesWidget({this.isDeposit, this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isDeposit ? FontAwesomeIcons.coins : FontAwesomeIcons.coins,
            color: isDeposit ? Colors.lightBlue : Colors.purple,
            size: 32,
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                      text: '***082 ',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                      children: [
                    TextSpan(
                        text: isDeposit
                            ? ' Successfully deposited'
                            : ' Successfully withdrew',
                        style: TextStyle(color: Colors.black, fontSize: 13)),
                    TextSpan(text: ' KES$price')
                  ])),
              if (isDeposit)
                SizedBox(
                  height: 5,
                ),
              if (isDeposit)
                Text(
                  'Deposited',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                )
            ],
          )
        ],
      ),
    );
  }
}
