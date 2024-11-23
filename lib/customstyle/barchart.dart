import 'package:flutter/material.dart';
import 'package:flutter_sales_graph/flutter_sales_graph.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

class BarChart extends StatefulWidget {
  final String room;
  final String type;

  const BarChart({
    super.key,
    required this.room,
    required this.type
  });
  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  List<double> dataChart = [0,0,0,0,0];

  @override
  void initState() {
    super.initState();
    getStatistik();
  }

  Future<void> getStatistik() async {
    List<double> data;
    if (widget.type == 'peminjaman') {
      data = List<double>.from(await api_data.getPeminjamanStatistik(widget.room));
    } else {
      data = List<double>.from(await api_data.getKendalaStatistik(widget.room));
    }
    
    setState(() {
      dataChart = List<double>.from(data);
      while (dataChart.length < 5) {
        dataChart.add(0);
      }
    });
    // print(dataChart);
  }

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
            salesData: dataChart,
            labels: ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'],
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