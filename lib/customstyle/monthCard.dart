import 'package:flutter/material.dart';

class MonthCard extends StatelessWidget {
  final String month;
  final String imagePath;
  final String description;

  const MonthCard({
    Key? key,
    required this.month,
    required this.imagePath,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          month,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFFFF5833),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 100,
          width: double.infinity,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 36),
      ],
    );
  }
}