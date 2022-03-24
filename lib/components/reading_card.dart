import 'package:baby_may_cry/static/colors.dart';
import 'package:flutter/material.dart';

class ReadingCard extends StatelessWidget {
  ReadingCard(
      {Key? key,
      required this.color,
      required this.image,
      required this.label,
      required this.reading,
      required this.unit})
      : super(key: key);
  Color color;
  String image;
  String label;
  String reading;
  String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withOpacity(0.8),
      ),
      width: 130,
      height: 175,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset(
            image,
            color: label == "heart rate" ? Colors.white : null,
            width: 35,
          ),
          const SizedBox(height: 20),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                reading,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                unit,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
