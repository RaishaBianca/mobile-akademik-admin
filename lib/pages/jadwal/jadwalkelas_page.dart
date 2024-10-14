import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/jamCard.dart';
import 'package:admin_fik_app/customstyle/JadwalCard.dart';

class JadwalkelasPage extends StatefulWidget {
  @override
  _JadwalkelasPageState createState() => _JadwalkelasPageState();
}

class _JadwalkelasPageState extends State<JadwalkelasPage> {
  String? selectedRoom;

  // Dummy data list untuk dosen dan mata kuliah
  final List<Map<String, String>> jadwalmkList = [
    {
      'ruangan': 'KHD Kelas 201',
      'hari': 'Senin',
      'jamMulai': '07:00',
      'jamSelesai': '09:00',
      'namaMatkul': 'Kalkulus',
      'kodeMatkul': 'SSI123456789',
      'namaDosen': 'John Doe',
      'kodeDosen': 'SSI987654321',
    },
    {
      'ruangan': 'KHD Kelas 301',
      'hari': 'Senin',
      'jamMulai': '09:30',
      'jamSelesai': '12:00',
      'namaMatkul': 'Pemrograman',
      'kodeMatkul': 'INF123456780',
      'namaDosen': 'Jane Smith',
      'kodeDosen': 'IF987654322',
    },
    {
      'ruangan': 'DS Kelas 401',
      'hari': 'Selasa',
      'jamMulai': '07:00',
      'jamSelesai': '09:00',
      'namaMatkul': 'Sistem Operasi',
      'kodeMatkul': 'DSI123456781',
      'namaDosen': 'Michael Johnson',
      'kodeDosen': 'DSI987654323',
    },
    {
      'ruangan': 'DS Kelas 402',
      'hari': 'Selasa',
      'jamMulai': '09:30',
      'jamSelesai': '12:00',
      'namaMatkul': 'Jaringan Komputer',
      'kodeMatkul': 'SSD123456782',
      'namaDosen': 'Emily Davis',
      'kodeDosen': 'SSD987654324',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Jadwal Penggunaan Ruang Kelas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[700],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '24',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Wed',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'Aug 2024',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 70),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButton<String>(
                          value: selectedRoom,
                          hint: Text("Pilih Ruang Kelas", style: TextStyle(color: Colors.white)),
                          items: [
                            DropdownMenuItem(
                              value: "KHD 201",
                              child: Text("KHD 201", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "KHD 202",
                              child: Text("KHD 202", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "KHD 203",
                              child: Text("KHD 203", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "DS 201",
                              child: Text("DS 201", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "DS 202",
                              child: Text("DS 202", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "DS 203",
                              child: Text("DS 203", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "DS 301",
                              child: Text("DS 301", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "DS 302",
                              child: Text("DS 302", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "DS 303",
                              child: Text("DS 303", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "DS 401",
                              child: Text("DS 401", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "DS 402",
                              child: Text("DS 402", style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "DS 403",
                              child: Text("DS 403", style: TextStyle(color: Colors.white)),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRoom = newValue;
                            });
                          },
                          dropdownColor: Colors.blue[200],
                          underline: SizedBox(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Jam',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Mata Kuliah',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            // ListView.builder untuk menampilkan banyak DosenCard dan MkCard
            Expanded(
              child: ListView.builder(
                itemCount: jadwalmkList.length,
                itemBuilder: (context, index) {
                  final data = jadwalmkList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        JamCard(
                          jamMulai: data['jamMulai']!,
                          jamSelesai: data['jamSelesai']!,
                        ),
                        SizedBox(width: 10),
                        JadwalCard(
                          namaMatkul: data['namaMatkul']!,
                          kodeMatkul: data['kodeMatkul']!,
                          namaDosen: data['namaDosen']!,
                          kodeDosen: data['kodeDosen']!,
                          ruangan: data['ruangan']!,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}