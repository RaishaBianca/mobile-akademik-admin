import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/jamCard.dart';
import 'package:admin_fik_app/customstyle/JadwalCard.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

class JadwalkelasPage extends StatefulWidget {
  @override
  _JadwalkelasPageState createState() => _JadwalkelasPageState();
}

class _JadwalkelasPageState extends State<JadwalkelasPage> {
  late Future<List<Map<String, dynamic>>> _jadwalFuture;
  List<Map<String, String>> ruanganList = [];
  String? selectedRoom;
  String? selectedDay;

  @override
  void initState() {
    super.initState();
    selectedDay = _getDayOfWeek(DateTime.now());
    _jadwalFuture = fetchJadwal();
    getRuangan();
    selectedDay = _getDayOfWeek(DateTime.now());
  }

  Future<void> getRuangan() async {
    var data = await api_data.getRuang('kelas');

    setState(() {
      ruanganList = List<Map<String, String>>.from(data.map((item) => {
        'id_ruangan': item['id_ruangan'].toString(),
        'nama_ruangan': item['nama_ruangan'].toString(),
      }));
    });
  }

  Future<List<Map<String, dynamic>>> fetchJadwal() async {
    List<Map<String, dynamic>> allJadwal = await api_data.getAllJadwal();
    allJadwal = allJadwal.where((jadwal) => jadwal['tipe_ruang'] == 'kelas').toList();

    if (selectedRoom != null) {
      print("Selected Room: $selectedRoom");
      allJadwal = allJadwal.where((jadwal) => jadwal['id_ruang'] == selectedRoom).toList();
      print("All Jadwal: $allJadwal");
    }
    if (selectedDay != null) {
      print("Selected Day: $selectedDay");
      allJadwal = allJadwal.where((jadwal) => jadwal['hari'] == selectedDay).toList();
      print("All Jadwal: $allJadwal");
    }
    print("All Jadwal: $allJadwal");
    return allJadwal;
  }

  void updateJadwal() {
    setState(() {
      _jadwalFuture = fetchJadwal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Penggunaan Ruang Kelas',
          style: TextStyle(
            fontSize: 20,
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
                  EasyDateTimeLine(
                    initialDate: DateTime.now(),
                    onDateChange: (date) {
                      setState(() {
                        selectedDay = _getDayOfWeek(date);
                        updateJadwal(); // Update jadwal when day changes
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Ruang Kelas: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color(0x99FF5833),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButton<String>(
                          value: selectedRoom,
                          hint: Text("Pilih", style: TextStyle(color: Colors.white)),
                          items: ruanganList.map((room) {
                            return DropdownMenuItem(
                              value: room['id_ruangan'],
                              child: Text(room['id_ruangan']!),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRoom = newValue;
                              print('Selected Room: $selectedRoom');
                              print('Selected Day: $selectedDay');
                              updateJadwal(); // Update jadwal when room changes
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
                                ruangan: jadwal['id_ruang']!,
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

  String _getDayOfWeek(DateTime date) {
    List<String> days = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    return days[date.weekday % 7];
  }
}