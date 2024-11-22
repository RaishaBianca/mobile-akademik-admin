import 'package:admin_fik_app/pages/pelaporan/pelaporan_page.dart';
import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/buttonaccept.dart';
import 'package:admin_fik_app/customstyle/buttonreject.dart';
import 'package:admin_fik_app/customstyle/statusdropdown.dart';
// import 'package:admin_fik_app/data/dummy_report.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

class DetailkendalaPage extends StatefulWidget {
  final int id;
  final String nama_pelapor;
  final String nim_nrp;
  final String tanggal;
  final String nama_ruangan;
  final String jenis_kendala;
  final String bentuk_kendala;
  final String deskripsi_kendala;
  final String status;
  final String keterangan_penyelesaian;

  DetailkendalaPage({
    Key? key,
    required this.id,
    required this.nama_pelapor,
    required this.nim_nrp,
    required this.tanggal,
    required this.nama_ruangan,
    required this.jenis_kendala,
    required this.bentuk_kendala,
    required this.deskripsi_kendala,
    required this.status,
    required this.keterangan_penyelesaian,
  }) : super(key: key);

  @override
  _DetailkendalaPageState createState() => _DetailkendalaPageState();
}

const List<String> list = <String>['Terima', 'Selesai'];
class _DetailkendalaPageState extends State<DetailkendalaPage> {
  late Future<List<Map<String, dynamic>>> _kendalaFuture;
  String? _lastSavedStatus;
  late TextEditingController reasonController;
  late String _deskripsi_kendala;
  String statusDropdown = 'approved';

  @override
  void initState() {
    super.initState();
    _kendalaFuture = fetchKendala();
    reasonController = TextEditingController(text: widget.keterangan_penyelesaian);
    _deskripsi_kendala = widget.deskripsi_kendala;
  }

  Future<void> _handlePost() async {
    api_data.verifikasiKendala(
      widget.id.toString(),
      statusDropdown,
      reasonController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
      content: Text('Berhasil menyimpan'),
      duration: Duration(seconds: 2),
      ),
    );
    //close widget
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Future<List<Map<String, dynamic>>> fetchKendala() async {
    List<Map<String, dynamic>> allKendala = await api_data.getAllKendala();
    return allKendala.toList();
  }

  void _handleSave(String status) {
    setState(() {
      _lastSavedStatus = status;
      _deskripsi_kendala = reasonController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Laporan Kendala",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: SingleChildScrollView(
        child: 
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildRowWithDivider('Nama', widget.nama_pelapor),
                buildRowWithDivider('NIM', widget.nim_nrp),
                buildRowWithDivider('Tgl Input', widget.tanggal),
                buildRowWithDivider('Ruangan', widget.nama_ruangan),
                buildRowWithDivider('Jenis Kendala', widget.jenis_kendala),
                buildRowWithDivider('Bentuk Kendala', widget.bentuk_kendala),
                buildRowWithDivider('Deskripsi', _deskripsi_kendala),
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
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: statusDropdown,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x99FF5833)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x99FF5833)),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      statusDropdown = newValue!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                        value: 'approved',
                        child: Text('Terima'),
                    ),
                    DropdownMenuItem(
                        value: 'rejected',
                        child: Text('Tolak'),
                    ),
                    DropdownMenuItem(
                        value: 'finished',
                        child: Text('Selesai'),
                    ),
                  ],
                  // items: list.map<DropdownMenuItem<String>>((String value) {
                  //   return DropdownMenuItem<String>(
                  //     value: value,
                  //     child: Text(value),
                  //   );
                  // }).toList(),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonAccept(
                      label: 'Simpan',
                      onPressed: () {
                        _handlePost();
                        // print("Diterima");
                      },
                    ),
                    // SizedBox(width: 40),
                    // ButtonReject(
                    //   label: 'Tolak',
                    //   onPressed: () {
                    //     print("Ditolak dengan alasan: ${reasonController.text}");
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
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