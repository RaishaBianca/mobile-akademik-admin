import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/statusdropdown.dart';
import 'package:admin_fik_app/data/dummy_report.dart'; // Ganti dengan path yang sesuai

class DetailkendalaPage extends StatefulWidget {
  final String studentName;
  final String studentNim;
  final String inputDate;
  final String ruangan;
  final String jenis;
  final String bentuk;
  final String deskripsi;

  DetailkendalaPage({
    Key? key,
    required this.studentName,
    required this.studentNim,
    required this.inputDate,
    required this.ruangan,
    required this.jenis,
    required this.bentuk,
    required this.deskripsi,
  }) : super(key: key);

  @override
  _DetailkendalaPageState createState() => _DetailkendalaPageState();
}

class _DetailkendalaPageState extends State<DetailkendalaPage> {
  String? _lastSavedStatus;
  late TextEditingController reasonController;
  late String _deskripsi;

  @override
  void initState() {
    super.initState();
    reasonController = TextEditingController(text: widget.deskripsi);
    _deskripsi = widget.deskripsi;
  }

  void _handleSave(String status) {
    setState(() {
      _lastSavedStatus = status;
      _deskripsi = reasonController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Laporan Kendala",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833), // Warna biru untuk AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRowWithDivider('Nama', widget.studentName),
            buildRowWithDivider('NIM', widget.studentNim),
            buildRowWithDivider('Tgl Input', widget.inputDate),
            buildRowWithDivider('Ruangan', widget.ruangan),
            buildRowWithDivider('Jenis Kendala', widget.jenis),
            buildRowWithDivider('Bentuk Kendala', widget.bentuk),
            buildRowWithDivider('Deskripsi', _deskripsi),
            SizedBox(height: 16),
            Text(
              'Keterangan Pengerjaan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x99FF5833)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0x99FF5833)),
                ),
                hintText: 'Masukkan keterangan penanganan kendala',
              ),
              maxLines: 3, // Untuk menampung beberapa baris
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatusDropdown(onSave: _handleSave),
                // SizedBox(height: 20),
                // if (_lastSavedStatus != null)
                //   Text('Status Terakhir: $_lastSavedStatus'),
              ]
            )
          ],
        ),
      ),
    );
  }

  Widget buildRowWithDivider(String label, String value) {
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
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