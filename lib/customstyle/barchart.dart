import 'package:flutter/material.dart';
import 'package:flutter_sales_graph/flutter_sales_graph.dart';

class BarChart extends StatelessWidget {
  const BarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Set the width to double infinity
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        border: Border.all(
          color: Color(0xFFFFBE33), // Border color
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(12), // Optional: Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: FlutterSalesGraph(
            salesData: [100, 200, 150, 300, 250, 350],
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
            maxBarHeight: 250.0,
            barWidth: 45.0,
            colors: [Color(0xFFFFBE33), Color(0xFF3374FF), Color(0xFFFF3374)],
            dateLineHeight: 20.0,
          ),
        ),
      ),
    );
  }
}