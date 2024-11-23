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
  final Future<List<Map<String, dynamic>>> peminjamanCount = api_data.getPeminjamanCount();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable back button
        title: Text(
          'Peminjaman Ruangan',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 24,
              fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(4.0), // Height of the bottom border
        //   child: Container(
        //     color: Colors.transparent,
        //     child: Container(
        //       height: 4.0,
        //       decoration: BoxDecoration(
        //         border: Border(
        //           bottom: BorderSide(
        //             color: Color(0xFFFFBE33), // Color of the bottom border
        //             width: 2.0, // Width of the bottom border
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar.secondary(
              controller: _tabController,
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
                    // margin: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks dan elemen lainnya rata kiri
                          children: [
                            Text(
                              'Peminjaman Ruang Lab Komputer FIK',
                              textAlign: TextAlign.left, // Teks rata kiri
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20), // Jarak antara teks dan tombol
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                              children: [
                                CustomButtonOne(
                                  label: 'Peminjaman Baru',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MenungguPage(room: 'lab')),
                                    );
                                  },
                                  subText: '6', // Angka tambahan di bawah label
                                ),
                                CustomButtonOne(
                                  label: 'Terkonfirmasi',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => TerkonfirmasiPage(room: 'lab')),
                                    );
                                  },
                                  subText: '12', // Angka tambahan di bawah label
                                ),
                              ],
                            ),
                            SizedBox(height: 20), // Jarak antara teks dan tombol
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                              children: [
                                CustomButtonTwo(
                                  label: 'Lihat Semua Daftar',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SemuadaftarPage(room: 'lab')),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 30), // Jarak antara tombol dan teks baru
                            Text(
                              'Statistika Peminjaman Lab Komputer FIK',
                              textAlign: TextAlign.left, // Teks rata kiri
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10), // Jarak antara teks dan gambar grafik
                            BarChart(room: 'lab', type: 'peminjaman'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    // margin: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks dan elemen lainnya rata kiri
                          children: [
                            Text(
                              'Peminjaman Ruang Kelas Komputer FIK',
                              textAlign: TextAlign.left, // Teks rata kiri
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20), // Jarak antara teks dan tombol
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                              children: [
                                CustomButtonOne(
                                  label: 'Peminjaman Baru',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MenungguPage(room: 'kelas')),
                                    );
                                  },
                                  subText: '6', // Angka tambahan di bawah label
                                ),
                                CustomButtonOne(
                                  label: 'Terkonfirmasi',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => TerkonfirmasiPage(room: 'kelas')),
                                    );
                                  },
                                  subText: '12', // Angka tambahan di bawah label
                                ),
                              ],
                            ),
                            SizedBox(height: 20), // Jarak antara teks dan tombol
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                              children: [
                                CustomButtonTwo(
                                  label: 'Lihat Semua Daftar',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SemuadaftarPage(room: 'kelas')),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 30), // Jarak antara tombol dan teks baru
                            Text(
                              'Statistika Peminjaman Ruang Kelas FIK',
                              textAlign: TextAlign.left, // Teks rata kiri
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10), // Jarak antara teks dan gambar grafik
                            BarChart(room: 'kelas', type: 'peminjaman'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: Container(
            //     color: Colors.white, // Warna putih untuk konten utama
            //     child: 
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
