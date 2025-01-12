import 'package:admin_fik_app/customstyle/barchart.dart';
import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/custombuttonone.dart';
import 'package:admin_fik_app/pages/pelaporan/kendalabaru_page.dart';
import 'package:admin_fik_app/pages/pelaporan/kendaladikerjakan_page.dart';
import 'package:admin_fik_app/pages/pelaporan/kendalaselesai_page.dart';
import 'package:admin_fik_app/pages/pelaporan/semuakendala_page.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

class PelaporanPage extends StatefulWidget {
  @override
  _PelaporanPageState createState() => _PelaporanPageState();
}

class _PelaporanPageState extends State<PelaporanPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  // int labsemua = 0;
  // int labbaru = 0;
  // int labdikerjakan = 0;
  // int labselesai = 0;
  // int kelassemua = 0;
  // int kelasbaru = 0;
  // int kelasdikerjakan = 0;
  // int kelasselesai = 0;
  Map<String, Map<String, int>> kendalaCounts = {
    'lab': {'pending': 0, 'on_progress': 0, 'resolved': 0},
    'kelas': {'pending': 0, 'on_progress': 0, 'resolved': 0}
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchKendalaCount();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchKendalaCount() async {
    var countData = await api_data.getKendalaCount();
    print(countData);
    setState(() {
      // labsemua = countData['lab_semua'];
      // labbaru = countData['lab_baru'];
      // labdikerjakan = countData['lab_dikerjakan'];
      // labselesai = countData['lab_selesai'];
      // kelassemua = countData['kelas_semua'];
      // kelasbaru = countData['kelas_baru'];
      // kelasdikerjakan = countData['kelas_dikerjakan'];
      // kelasselesai = countData['kelas_selesai'];
      kendalaCounts = {
        'lab': Map<String, int>.from(countData['lab']),
        'kelas': Map<String, int>.from(countData['kelas'])
      };
    });
  }

  Widget _buildRoomSection(String roomType) {
    final String title = roomType == 'lab' ? 'Lab Komputer' : 'Kelas';
    return Card(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pelaporan Kendala Ruang $title FIK',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomButtonOne(
                      label: 'Laporan Baru',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KendalabaruPage(room: roomType)),
                      ),
                      subText: kendalaCounts[roomType]!['pending'].toString(),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomButtonOne(
                      label: 'Laporan Dikerjakan',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KendaladikerjakanPage(room: roomType)),
                      ),
                      subText: kendalaCounts[roomType]!['on_progress'].toString(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomButtonOne(
                      label: 'Laporan Selesai',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KendalaselesaiPage(room: roomType)),
                      ),
                      subText: kendalaCounts[roomType]!['resolved'].toString(),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomButtonOne(
                      label: 'Semua Laporan',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SemuakendalaPage(room: roomType)),
                      ),
                      subText: (kendalaCounts[roomType]!['pending']! + kendalaCounts[roomType]!['on_progress']! + kendalaCounts[roomType]!['resolved']!).toString(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Statistika Pelaporan Kendala ${roomType == 'lab' ? 'Lab Komputer' : 'Ruang Kelas'} FIK',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              BarChart(room: roomType, type: 'kendala'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Pelaporan Kendala Ruang Lab dan Kelas',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar.secondary(
              controller: _tabController,
              labelColor: Color(0xFFFF5833),
              unselectedLabelColor: Colors.black,
              tabs: const <Widget>[
                Tab(text: 'Pelaporan Lab'),
                Tab(text: 'Pelaporan Kelas'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  _buildRoomSection('lab'),
                  _buildRoomSection('kelas'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}