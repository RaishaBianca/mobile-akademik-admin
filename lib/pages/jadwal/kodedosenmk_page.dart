import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/dosenCard.dart';
import 'package:admin_fik_app/customstyle/mkCard.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

class KodedosenmkPage extends StatefulWidget {
  @override
  _KodedosenmkPageState createState() => _KodedosenmkPageState();
}

class _KodedosenmkPageState extends State<KodedosenmkPage> {
  String? selectedProgram;

  // Dummy data list untuk dosen dan mata kuliah
  final List<Map<String, String>> kodeDosenMkList = [
    {'namaDosen': 'John Doe', 'kodeDosen': 'IF987654321', 'namaMatkul': 'Pemrograman Flutter', 'kodeMatkul': 'IF123456789'},
    {'namaDosen': 'Jane Smith', 'kodeDosen': 'IF876543210', 'namaMatkul': 'Basis Data', 'kodeMatkul': 'IF234567890'},
    {'namaDosen': 'Alice Wonderland', 'kodeDosen': 'IF765432109', 'namaMatkul': 'Sistem Operasi', 'kodeMatkul': 'IF345678901'},
    // Tambahkan data dosen dan mata kuliah lainnya
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Kode Dosen dan Mata Kuliah',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Program Studi:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color(0xCCFF5833),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButton<String>(
                          value: selectedProgram,
                          hint: Text("Pilih Program", style: TextStyle(color: Colors.white)),
                          items: [
                            DropdownMenuItem(
                              value: "S1 - Informatika",
                              child: Text("S1 - Informatika",
                                  style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "S1 - Sains Data",
                              child: Text("S1 - Sains Data",
                                  style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "S1 - Sistem Informasi",
                              child: Text("S1 - Sistem Informasi",
                                  style: TextStyle(color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              value: "D3 - Sistem Informasi",
                              child: Text("S1 - Sistem Informasi",
                                  style: TextStyle(color: Colors.white)),
                            ),
                            // Tambahkan pilihan lain jika perlu
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedProgram = newValue;
                            });
                          },
                          dropdownColor: Color(0x99FF5833),
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
                        'Dosen',
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
                itemCount: kodeDosenMkList.length,
                itemBuilder: (context, index) {
                  final data = kodeDosenMkList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        DosenCard(
                          dosenName: data['namaDosen']!,
                          dosenCode: data['kodeDosen']!,
                        ),
                        SizedBox(width: 10),
                        MkCard(
                          mkName: data['namaMatkul']!,
                          mkCode: data['kodeMatkul']!,
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
