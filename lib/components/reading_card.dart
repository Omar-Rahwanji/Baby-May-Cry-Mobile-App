import 'package:flutter/material.dart';

class ReadingCard extends StatelessWidget {
  const ReadingCard(
      {Key? key,
      required this.color,
      required this.image,
      required this.label,
      required this.reading,
      required this.unit})
      : super(key: key);
  final Color color;
  final String image;
  final String label;
  final int reading;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withOpacity(0.8),
      ),
      width: 150,
      height: 195,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/' + image,
            color: Colors.white,
            width: 35,
          ),
          const SizedBox(height: 20),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                reading.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
