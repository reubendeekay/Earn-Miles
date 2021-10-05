import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_miles/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
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
                height: size.height * 0.3,
                color: kPrimaryColor,
                child: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.fitHeight,
                ),
              )),
          Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'Earn Miles',
                style: GoogleFonts.notoSans(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Spacer(),
              TopAds(),
            ],
          )
        ],
      ),
    );
  }
}

class TopAds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('admin')
            .doc('media')
            .collection('images')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return Container(
              height: 150,
            );
          } else {
            List<DocumentSnapshot> docs = snapshot.data.docs;
            return CarouselSlider(
              options: CarouselOptions(
                height: 150,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,

                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(seconds: 2),
                autoPlayCurve: Curves.fastOutSlowIn,
                // enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: docs
                  .map((e) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            e['imageUrl'],
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ))
                  .toList(),
            );
          }
        });
  }
}
