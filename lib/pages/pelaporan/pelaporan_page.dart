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
  int labsemua = 0;
  int labbaru = 0;
  int labdikerjakan = 0;
  int labselesai = 0;
  int kelassemua = 0;
  int kelasbaru = 0;
  int kelasdikerjakan = 0;
  int kelasselesai = 0;

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
     setState(() {
        labsemua = countData['lab_semua'];
        labbaru = countData['lab_baru'];
        labdikerjakan = countData['lab_dikerjakan'];
        labselesai = countData['lab_selesai'];
        kelassemua = countData['kelas_semua'];
        kelasbaru = countData['kelas_baru'];
        kelasdikerjakan = countData['kelas_dikerjakan'];
        kelasselesai = countData['kelas_selesai'];
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable back button
        title: Text(
          'Pelaporan Kendala/Kerusakan Ruangan',
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
                Tab(text: 'Pelaporan Lab'),
                Tab(text: 'Pelaporan Kelas'),
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
                              'Pelaporan Ruang Lab Komputer FIK',
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
                                  label: 'Laporan Baru',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => KendalabaruPage(room: 'lab')),
                                    );
                                  },
                                  subText: labbaru.toString(),
                                ),
                                CustomButtonOne(
                                  label: 'Laporan Dikerjakan',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => KendaladikerjakanPage(room: 'lab')),
                                    );
                                  },
                                  subText: labdikerjakan.toString(),
                                ),
                              ],
                            ),
                            SizedBox(height: 20), // Jarak antara teks dan tombol
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                              children: [
                                CustomButtonOne(
                                  label: 'Laporan Selesai',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => KendalaselesaiPage(room: 'lab')),
                                    );
                                  },
                                  subText: labselesai.toString(),
                                ),
                                CustomButtonOne(
                                  label: 'Semua Laporan',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SemuakendalaPage(room: 'lab')),
                                    );
                                  },
                                  subText: labsemua.toString(),
                                ),
                              ],
                            ),
                            SizedBox(height: 30), // Jarak antara tombol dan teks baru
                            Text(
                              'Statistika Pelaporan Lab Komputer FIK',
                              textAlign: TextAlign.left, // Teks rata kiri
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10), // Jarak antara teks dan gambar grafik
                            BarChart(room: 'lab', type: 'kendala',),
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
                              'Pelaporan Ruang Kelas FIK',
                              textAlign: TextAlign.left, // Teks rata kiri
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10), // Jarak antara teks dan gambar grafik
                            SizedBox(height: 20), // Jarak antara teks dan tombol
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                              children: [
                                CustomButtonOne(
                                  label: 'Laporan Baru',
                                  onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => KendalabaruPage(room: 'kelas')),
                                      );
                                  },
                                  subText: kelasbaru.toString(), // Angka tambahan di bawah label
                                ),
                                CustomButtonOne(
                                  label: 'Laporan Dikerjakan',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => KendaladikerjakanPage(room: 'kelas')),
                                    );
                                  },
                                  subText: kelasdikerjakan.toString(), // Angka tambahan di bawah label
                                ),
                              ],
                            ),
                            SizedBox(height: 20), // Jarak antara teks dan tombol
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                              children: [
                                CustomButtonOne(
                                  label: 'Laporan Selesai',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => KendalaselesaiPage(room: 'kelas')),
                                    );
                                  },
                                  subText: kelasselesai.toString(), // Angka tambahan di bawah label
                                ),
                                CustomButtonOne(
                                  label: 'Semua Laporan',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SemuakendalaPage(room: 'kelas')),
                                    );
                                  },
                                  subText: kelassemua.toString(), // Angka tambahan di bawah label
                                ),
                              ],
                            ),
                            SizedBox(height: 30), // Jarak antara tombol dan teks baru
                            Text(
                              'Statistika Pelaporan Ruang Kelas FIK',
                              textAlign: TextAlign.left, // Teks rata kiri
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10), // Jarak antara teks dan gambar grafik
                            BarChart(room: 'kelas', type: 'kendala'),
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
