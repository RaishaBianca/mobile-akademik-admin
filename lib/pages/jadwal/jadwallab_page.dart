import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/jamCard.dart';
import 'package:admin_fik_app/customstyle/JadwalCard.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

class JadwallabPage extends StatefulWidget {
  @override
  _JadwallabPageState createState() => _JadwallabPageState();
}

class _JadwallabPageState extends State<JadwallabPage> {
  late Future<List<Map<String, dynamic>>> _jadwalFuture;
  String? selectedRoom;

  @override
  void initState() {
    super.initState();
    _jadwalFuture = fetchJadwal();
  }

  Future<List<Map<String, dynamic>>> fetchJadwal() async {
    List<Map<String, dynamic>> allJadwal = await api_data.getAllJadwal();
    return allJadwal;
  }

  // // Dummy data list untuk dosen dan mata kuliah
  // final List<Map<String, String>> jadwalmkList = [
  //   {
  //     'ruangan': 'KHD Kelas 201',
  //     'hari': 'Senin',
  //     'jamMulai': '07:00',
  //     'jamSelesai': '09:00',
  //     'namaMatkul': 'Kalkulus',
  //     'kodeMatkul': 'SSI123456789',
  //     'namaDosen': 'John Doe',
  //     'kodeDosen': 'SSI987654321',
  //   },
  //   {
  //     'ruangan': 'KHD Kelas 301',
  //     'hari': 'Senin',
  //     'jamMulai': '09:30',
  //     'jamSelesai': '12:00',
  //     'namaMatkul': 'Pemrograman',
  //     'kodeMatkul': 'INF123456780',
  //     'namaDosen': 'Jane Smith',
  //     'kodeDosen': 'IF987654322',
  //   },
  //   {
  //     'ruangan': 'DS Kelas 401',
  //     'hari': 'Selasa',
  //     'jamMulai': '07:00',
  //     'jamSelesai': '09:00',
  //     'namaMatkul': 'Sistem Operasi',
  //     'kodeMatkul': 'DSI123456781',
  //     'namaDosen': 'Michael Johnson',
  //     'kodeDosen': 'DSI987654323',
  //   },
  //   {
  //     'ruangan': 'DS Kelas 402',
  //     'hari': 'Selasa',
  //     'jamMulai': '09:30',
  //     'jamSelesai': '12:00',
  //     'namaMatkul': 'Jaringan Komputer',
  //     'kodeMatkul': 'SSD123456782',
  //     'namaDosen': 'Emily Davis',
  //     'kodeDosen': 'SSD987654324',
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Penggunaan Ruang Lab',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //use easy date timeline
                  EasyDateTimeLine(initialDate: DateTime.now()),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // SizedBox(width: 8),
                      Text("Ruang Lab: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      // SizedBox(width: 20),
                      Container(
                        width: 160,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color(0x99FF5833),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButton<String>(
                          value: selectedRoom,
                          hint: Text("Pilih", style: TextStyle(color: Colors.white)),
                          items: [
                            DropdownMenuItem(
                              value: "KHD 301",
                              child: Text("KHD 301 Lab Programming", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "KHD 302",
                              child: Text("KHD 302 Lab Cybersecurity", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "KHD 303",
                              child: Text("KHD 303 Lab Data Mining dan Data Science", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "KHD 304",
                              child: Text("KHD 304 Lab Artificial Intelligence", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "KHD 401",
                              child: Text("KHD 401 Lab Business Intelligence", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "KHD 402",
                              child: Text("KHD 402 Lab Database", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "KHD 403",
                              child: Text("KH3 402 Lab Internet of Things", style: TextStyle(color: Colors.white)),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRoom = newValue;
                            });
                          },
                          dropdownColor: Color(0xFFFFBE33),
                          underline: SizedBox(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Color(0xFFFF5833),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _jadwalFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    List<Map<String, dynamic>> jadwalList = snapshot.data!;
                    return ListView.builder(
                      itemCount: jadwalList.length,
                      itemBuilder: (context, index) {
                        var jadwal = jadwalList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            children: [
                              JamCard(
                                jamMulai: jadwal['jamMulai']!,
                                jamSelesai: jadwal['jamSelesai']!,
                              ),
                              SizedBox(width: 10),
                              JadwalCard(
                                namaMatkul: jadwal['namaMatkul']!,
                                kodeMatkul: jadwal['kodeMatkul']!,
                                namaDosen: jadwal['namaDosen']!,
                                kodeDosen: jadwal['kodeDosen']!,
                                ruangan: jadwal['ruangan']!,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}