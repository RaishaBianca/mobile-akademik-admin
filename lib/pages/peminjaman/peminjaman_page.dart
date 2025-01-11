import 'package:admin_fik_app/customstyle/barchart.dart';
import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/custombuttonone.dart';
import 'package:admin_fik_app/customstyle/custombuttontwo.dart';
import 'package:admin_fik_app/pages/peminjaman/menunggu_page.dart';
import 'package:admin_fik_app/pages/peminjaman/terkonfirmasi_page.dart';
import 'package:admin_fik_app/pages/peminjaman/ongoing_page.dart';
import 'package:admin_fik_app/pages/peminjaman/completed_page.dart';
import 'package:admin_fik_app/pages/peminjaman/kelastersedia_page.dart';
import 'package:admin_fik_app/pages/peminjaman/labtersedia_page.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

class PeminjamanPage extends StatefulWidget {
  @override
  _PeminjamanPageState createState() => _PeminjamanPageState();
}

class _PeminjamanPageState extends State<PeminjamanPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  Map<String, Map<String, int>> peminjamanCounts = {
    'lab': {'pending': 0, 'confirmed': 0, 'ongoing': 0, 'closed': 0},
    'kelas': {'pending': 0, 'confirmed': 0, 'ongoing': 0, 'closed': 0}
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchPeminjamanCount();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchPeminjamanCount() async {
    final countData = await api_data.getPeminjamanCount();
    setState(() {
      peminjamanCounts = {
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
                'Peminjaman Ruang $title FIK',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomButtonOne(
                      label: 'Dalam Antrian',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MenungguPage(room: roomType)),
                      ),
                      subText: peminjamanCounts[roomType]!['pending'].toString(),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomButtonOne(
                      label: 'Diterima/Ditolak',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TerkonfirmasiPage(room: roomType)),
                      ),
                      subText: peminjamanCounts[roomType]!['confirmed'].toString(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomButtonOne(
                      label: 'Dalam Proses',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OngoingPage(room: roomType)),
                      ),
                      subText: peminjamanCounts[roomType]!['ongoing'].toString(),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomButtonOne(
                      label: 'Selesai',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CompletedPage(room: roomType)),
                      ),
                      subText: peminjamanCounts[roomType]!['closed'].toString(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CustomButtonTwo(
                label: 'Lihat Ruang ${roomType == 'lab' ? 'Lab' : 'Kelas'} Tersedia',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => roomType == 'lab' ? LabtersediaPage() : KelastersediaPage(),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Statistika Peminjaman ${roomType == 'lab' ? 'Lab Komputer' : 'Ruang Kelas'} FIK',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              BarChart(room: roomType, type: 'peminjaman'),
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
          'Peminjaman Ruang Lab dan Kelas',
          style: TextStyle(
            color: Colors.white,
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
                Tab(text: 'Peminjaman Lab'),
                Tab(text: 'Peminjaman Kelas'),
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