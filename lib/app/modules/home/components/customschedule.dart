import 'package:flutter/material.dart';

class CustomSchedule extends StatelessWidget {
  final String time;
  final String info;
  final IconData icon;
  const CustomSchedule({
    super.key,
    required this.time,
    required this.info,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 35,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          info,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
