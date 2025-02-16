import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/roomCard.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;
import 'package:intl/intl.dart';

class RuanganTersediaPage extends StatefulWidget {
  final String type;
  const RuanganTersediaPage({
    Key? key,
    required this.type
  }) : super(key: key);

  @override
  _RuanganTersediaPageState createState() => _RuanganTersediaPageState();
}

class _RuanganTersediaPageState extends State<RuanganTersediaPage> {
  late Future<List<Map<String, dynamic>>> _ruangantersediaFuture;
  late TextEditingController jamMulaiController;
  late TextEditingController jamSelesaiController;
  late TextEditingController keperluanController;
  late TextEditingController tglUndurController;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    jamMulaiController = TextEditingController();
    jamSelesaiController = TextEditingController();
    keperluanController = TextEditingController();
    tglUndurController = TextEditingController();
    _ruangantersediaFuture = fetchRuangantersedia();
  }

  @override
  void dispose() {
    jamMulaiController.dispose();
    jamSelesaiController.dispose();
    keperluanController.dispose();
    tglUndurController.dispose();
    super.dispose();
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
        widget.type,
      );
      return allRuangantersedia;
    } catch (e) {
      print("Error fetching ruangan tersedia: $e");
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
      final formattedTime = DateFormat('HH:mm').format(
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute)
      );
      setState(() {
        controller.text = formattedTime;
      });
    }
  }

  Future<void> _selectUndurDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }


  Future<Map<String, dynamic>?> _getRoomInfo(String idRuang) async {
    final rooms = await _ruangantersediaFuture;
    return rooms.firstWhere(
          (room) => room['id_ruang'] == idRuang,
      orElse: () => {},
    );
  }

  void _toggleStatus(String idRuang) async {
    final roomInfo = await _getRoomInfo(idRuang);
    if (roomInfo?['status'] == 'close' && roomInfo?['tipe'] == 'jadwal') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pilih Tindakan'),
            content: Text('Apakah anda yakin ingin membuka ruangan ini?' +
                (roomInfo?['alasan'] != null ? '\n\nRuangan ini sedang dipakai untuk: ${roomInfo?['alasan']}' : '')),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  final idJadwal = (roomInfo?['id'] ?? '').toString();
                  _showUndurDialog(idRuang, idJadwal);
                },
                child: Text('Buka'),
              ),
            ],
          );
        },
      );
    } else if(roomInfo?['status'] == 'close' && roomInfo?['tipe'] == 'peminjaman') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pilih Tindakan'),
            content: Text('Apakah anda yakin ingin membuka ruangan ini?' +
                (roomInfo?['alasan'] != null ? '\n\nRuangan ini sedang dipakai untuk: ${roomInfo?['alasan']}' : '')),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  final idPinjam = (roomInfo?['id'] ?? '').toString();
                  _showPinjamDialog(idRuang, idPinjam);
                },
                child: Text('Buka'),
              ),
            ],
          );
        },
      );
    }
    else if(roomInfo?['status'] == 'open') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Form Peminjaman'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Keperluan Input
                  TextFormField(
                    controller: keperluanController,
                    decoration: InputDecoration(
                      labelText: 'Keperluan',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  _handleRoomClosure(
                    idRuang,
                    jamMulaiController.text,
                    jamSelesaiController.text,
                    keperluanController.text,);
                  Navigator.of(context).pop();
                },
                child: Text('Simpan'),
              ),
            ],
          );
        },
      );
    }
  }

  void _showPinjamDialog(String idRuang, String idPinjam) {
    final keperluanController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Form Peminjaman'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Keperluan Input
                TextFormField(
                  controller: keperluanController,
                  decoration: InputDecoration(
                    labelText: 'Keperluan',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _handlePinjamClosure(idPinjam, keperluanController.text);
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showUndurDialog(String idRuang, String idJadwal) {
    final dialogJamMulaiController = TextEditingController();
    final dialogJamSelesaiController = TextEditingController();
    final dialogAlasanController = TextEditingController();
    final dialogTglUndurController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Form Pengunduran'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: dialogTglUndurController,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Undur',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        onTap: () => _selectUndurDate(context, dialogTglUndurController),
                        readOnly: true,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: dialogJamMulaiController,
                        decoration: InputDecoration(
                          labelText: 'Jam Mulai',
                          border: OutlineInputBorder(),
                        ),
                        onTap: () async {
                          await _selectTime(context, dialogJamMulaiController);
                        },
                        readOnly: true,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: dialogJamSelesaiController,
                        decoration: InputDecoration(
                          labelText: 'Jam Selesai',
                          border: OutlineInputBorder(),
                        ),
                        onTap: () async {
                          await _selectTime(context, dialogJamSelesaiController);
                        },
                        readOnly: true,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: dialogAlasanController,
                        decoration: InputDecoration(
                          labelText: 'Alasan',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () {
                      _handleJadwalClosure(
                        idJadwal,
                        idRuang,
                        dialogTglUndurController.text,
                        dialogJamMulaiController.text,
                        dialogJamSelesaiController.text,
                        dialogAlasanController.text,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text('Simpan'),
                  ),
                ],
              );
            });
      },
    );
  }

  void _handleRoomClosure(String idRuang, String jamMulai, String jamSelesai, String alasan) async {
    try {
      final tglAwal = DateFormat('yyyy-MM-dd').format(selectedDate);
      final response = await api_data.tutupPemakaianRuang(
        tglPinjam: tglAwal,
        jamMulai: jamMulai.isEmpty ? null : jamMulai,
        jamSelesai: jamSelesai.isEmpty ? null : jamSelesai,
        keterangan: alasan.isEmpty ? null : alasan,
        idRuang: idRuang,
      );

      if (response == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ruangan berhasil ditutup')),
        );
        updateRuangantersedia();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menutup ruangan: $e')),
      );
    }
  }

  void _handleJadwalClosure(
      String idJadwal,
      String idRuang,
      String tglUndur,
      String jamMulai,
      String jamSelesai,
      String alasan,
      ) async {
    try {
      final tglAwal = DateFormat('yyyy-MM-dd').format(selectedDate);

      final response = await api_data.bukaPemakaianJadwal(
        idJadwal: idJadwal,
        tglAwal: tglAwal,
        tglUndur: tglUndur.isEmpty ? null : tglUndur,
        jamMulai: jamMulai.isEmpty ? null : jamMulai,
        jamSelesai: jamSelesai.isEmpty ? null : jamSelesai,
        alasan: alasan.isEmpty ? null : alasan,
        idRuang: idRuang,
      );

      if (response == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ruangan berhasil dibuka')),
        );
        updateRuangantersedia();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menutup ruangan: $e')),
      );
    }
  }

  void _handlePinjamClosure(
      String idPinjam,
      String alasan) async {
    try {
      final response = await api_data.bukaPemakaianPinjam(
        idPinjam: idPinjam,
        alasan: alasan,
      );

      if (response == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ruangan berhasil dibuka')),
        );
        updateRuangantersedia();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membuka ruangan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Ruang ${widget.type == 'lab' ? 'Lab' : 'Kelas'} Tersedia',
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
                        List<Widget> availableSlots = [];

                        // Convert available_slots to widgets
                            if (ruangantersedia['available_slots'] != null) {
                              var slots = ruangantersedia['available_slots'] as List;
                              availableSlots = slots.map((slot) => 
                                ListTile(
                                  leading: const Icon(Icons.access_time),
                                  title: Text('${slot['start']} - ${slot['end']}'),
                                  dense: true,
                                ),
                              ).toList();
                            }

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: RoomCard(
                            idRuang: ruangantersedia['id_ruang'] ?? 'Unknown',
                            namaRuang: ruangantersedia['nama_ruang'] ?? 'Unknown',
                            status: ruangantersedia['status'] ?? 'Unknown',
                            onToggleStatus: _toggleStatus,
                            children: availableSlots,
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