import 'package:flutter/material.dart';
import 'package:travelmemories/model/travel.dart';

class TravelCardWidget extends StatelessWidget {
  final Travel memories;

  const TravelCardWidget({
    @required this.memories,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              Expanded(child: buildImage(memories: memories)),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 10),
                  Text(
                    memories.location,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(height: 4),
                  Icon(Icons.category),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[600]),
                          borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        memories.locationtype,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 10),
                  Text(
                    memories.visitor,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.rate_review),
                  buildRating(memories: memories),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildImage({@required Travel memories}) => Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: Image.asset(memories.imageUrl, fit: BoxFit.cover),
        ),
      );

  Widget buildRating({@required Travel memories}) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 10),
          ...List.generate(
            memories.stars,
            (index) => Icon(Icons.star_rate, size: 18, color: Colors.orange),
          ),
        ],
      );
}
