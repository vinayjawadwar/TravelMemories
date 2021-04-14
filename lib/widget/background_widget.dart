import 'package:flutter/material.dart';
import 'package:travelmemories/data/travellist.dart';
import 'package:travelmemories/model/travel.dart';

class BackgroundWidget extends StatelessWidget {
  final PageController controller;

  const BackgroundWidget({
    @required this.controller,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PageView.builder(
        reverse: true,
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        itemBuilder: (context, index) {
          final movie = traveling[index];

          return buildBackground(movie: movie);
        },
        itemCount: traveling.length,
      );

  Widget buildBackground({@required Travel movie}) => Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(movie.imageUrl, fit: BoxFit.cover),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.15, 0.75],
                colors: [
                  Colors.white.withOpacity(0.0001),
                  Colors.white,
                ],
              ),
            ),
          )
        ],
      );
}
