import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/roomCard.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;
import 'package:intl/intl.dart';

class LabtersediaPage extends StatefulWidget {
  @override
  _LabtersediaPageState createState() => _LabtersediaPageState();
}

class _LabtersediaPageState extends State<LabtersediaPage> {
  late Future<List<Map<String, dynamic>>> _ruangantersediaFuture;
  TextEditingController jamMulaiController = TextEditingController();
  TextEditingController jamSelesaiController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _ruangantersediaFuture = fetchRuangantersedia();
  }

  void updateRuangantersedia() {
    setState(() {
      _ruangantersediaFuture = fetchRuangantersedia();
    });
  }

  Future<List<Map<String, dynamic>>> fetchRuangantersedia() async {
    try {
      List<Map<String, dynamic>> allRuangantersedia = await api_data.getAllRuangantersedia(
        jamMulaiController.text,
        jamSelesaiController.text,
        DateFormat('yyyy-MM-dd').format(selectedDate),
        'lab',
      );
      print("allRuangantersedia: $allRuangantersedia");
      return allRuangantersedia;
    } catch (e) {
      print("Error fetching ruangan tersedia: $e"); // Debug error
      return [];
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        updateRuangantersedia();
      });
    }
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final formattedTime = DateFormat('HH:mm').format(DateTime(now.year, now.month, now.day, picked.hour, picked.minute));
      setState(() {
        controller.text = formattedTime;
      });
    }
  }

  void _toggleStatus(String idRuang) {
    setState(() {
      _ruangantersediaFuture = _ruangantersediaFuture.then((rooms) {
        final room = rooms.firstWhere((room) => room['id_ruang'] == idRuang);
        print("room: $room");
        room['status'] = room['status'] == 'open' ? 'close' : 'open';
        print("room['status']: ${room['status']}");
        return rooms;
      });
      print('Toggled status for room $idRuang');
      print(_ruangantersediaFuture);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Ruang Lab Tersedia',
          style: TextStyle(
            fontSize: 16,
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
                    children: [
                      Text(
                        'Pilih Tanggal: ',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(selectedDate),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  buildTimePickerRow('Jam Mulai', jamMulaiController),
                  buildTimePickerRow('Jam Selesai', jamSelesaiController),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: updateRuangantersedia,
                    child: Text('Cari'),
                  ),
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
                future: _ruangantersediaFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    List<Map<String, dynamic>> ruangantersediaList = snapshot.data!;
                    return ListView.builder(
                      itemCount: ruangantersediaList.length,
                      itemBuilder: (context, index) {
                        var ruangantersedia = ruangantersediaList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: RoomCard(
                            idRuang: ruangantersedia['id_ruang'] ?? 'Unknown',
                            namaRuang: ruangantersedia['nama_ruang'] ?? 'Unknown',
                            status: ruangantersedia['status'] ?? 'Unknown',
                            onToggleStatus: _toggleStatus,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTimePickerRow(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 160,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => _selectTime(context, controller),
                child: IgnorePointer(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0x99FF5833)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0x99FF5833)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(color: Color(0x99FF5833)),
      ],
    );
  }
}