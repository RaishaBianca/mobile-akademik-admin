import 'package:admin_fik_app/customstyle/barchart.dart';
import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/custombuttonone.dart';
import 'package:admin_fik_app/customstyle/custombuttontwo.dart';
import 'package:admin_fik_app/pages/peminjaman/menunggu_page.dart';
import 'package:admin_fik_app/pages/peminjaman/terkonfirmasi_page.dart';
import 'package:admin_fik_app/pages/peminjaman/semuadaftar_page.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

class PeminjamanPage extends StatefulWidget {
  @override
  _PeminjamanPageState createState() => _PeminjamanPageState();
}

class _PeminjamanPageState extends State<PeminjamanPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int labTerkonfirmasi = 0;
  int labBaru = 0;
  int kelasTerkonfirmasi = 0;
  int kelasBaru = 0;

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
    var countData = await api_data.getPeminjamanCount();
    setState(() {
      labTerkonfirmasi = countData['lab_confirmed'];
      labBaru = countData['lab_pending'];
      kelasTerkonfirmasi = countData['kelas_confirmed'];
      kelasBaru = countData['kelas_pending'];
    });
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
                Tab(text: 'Peminjaman Lab'),
                Tab(text: 'Peminjaman Kelas'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Card(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Peminjaman Ruang Lab Komputer FIK',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: CustomButtonOne(
                                    label: 'Peminjaman Baru',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MenungguPage(room: 'lab')),
                                      );
                                    },
                                    subText: labBaru.toString(),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: CustomButtonOne(
                                    label: 'Terkonfirmasi',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => TerkonfirmasiPage(room: 'lab')),
                                      );
                                    },
                                    subText: labTerkonfirmasi.toString(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: CustomButtonTwo(
                                    label: 'Lihat Semua Daftar',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SemuadaftarPage(room: 'lab')),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Text(
                              'Statistika Peminjaman Lab Komputer FIK',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            BarChart(room: 'lab', type: 'peminjaman'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Peminjaman Ruang Kelas Komputer FIK',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: CustomButtonOne(
                                    label: 'Peminjaman Baru',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MenungguPage(room: 'kelas')),
                                      );
                                    },
                                    subText: kelasBaru.toString(),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: CustomButtonOne(
                                    label: 'Terkonfirmasi',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => TerkonfirmasiPage(room: 'kelas')),
                                      );
                                    },
                                    subText: kelasTerkonfirmasi.toString(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: CustomButtonTwo(
                                    label: 'Lihat Semua Daftar',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SemuadaftarPage(room: 'kelas')),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Text(
                              'Statistika Peminjaman Ruang Kelas FIK',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            BarChart(room: 'kelas', type: 'peminjaman'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}