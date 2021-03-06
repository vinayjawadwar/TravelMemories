import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travelmemories/data/travellist.dart';
import 'package:travelmemories/widget/background_widget.dart';
import 'package:travelmemories/widget/travel_card_widget.dart';

class Body extends StatelessWidget {
  final controller = PageController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            BackgroundWidget(controller: controller),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CarouselSlider(
                    items: traveling
                        .map((e) => TravelCardWidget(memories: e))
                        .toList(),
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      viewportFraction: 0.75,
                      height: MediaQuery.of(context).size.height * 0.7,
                      enlargeCenterPage: true,
                      onPageChanged: (index, _) => controller.animateToPage(
                        index,
                        duration: Duration(seconds: 1),
                        curve: Curves.ease,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      );
}
