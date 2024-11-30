import 'package:admin_fik_app/pages/peminjaman/menunggu_page.dart';
import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/buttonaccept.dart';
import 'package:admin_fik_app/customstyle/buttonreject.dart';
// import 'package:admin_fik_app/data/dummy_data.dart'; // Ganti dengan path yang sesuai
import 'package:admin_fik_app/data/api_data.dart' as api_data; // Ganti dengan path yang sesuai

const List<String> list = <String>['Terima', 'Tolak'];
class DetailpeminjamanPage extends StatefulWidget {
  final int id;
  final String studentName;
  final String studentNim;
  final String inputDate;
  final String ruangan;
  final String bookDate;
  final String jamMulai;
  final String jamSelesai;
  final String jumlahPengguna;
  final String keterangan;

  const DetailpeminjamanPage({
    Key? key,
    required this.id,
    required this.studentName,
    required this.studentNim,
    required this.inputDate,
    required this.ruangan,
    required this.bookDate,
    required this.jamMulai,
    required this.jamSelesai,
    required this.jumlahPengguna,
    required this.keterangan,
    required bool isAccepted, required String time,
  }) : super(key: key);
  @override
  _DetailpeminjamanPageState createState() => _DetailpeminjamanPageState();
  }
  
  class _DetailpeminjamanPageState extends State<DetailpeminjamanPage> {
  String statusDropdown = list.first;
  TextEditingController reasonController = TextEditingController();

  Future<void> _handlePost() async {
    api_data.verifikasiPeminjaman(
      widget.id.toString(),
      statusDropdown,
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
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Peminjaman",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRowWithDivider('Nama', widget.studentName),
              buildRowWithDivider('NIM', widget.studentNim),
              buildRowWithDivider('Tgl Input', widget.inputDate),
              buildRowWithDivider('Ruangan', widget.ruangan),
              buildRowWithDivider('Tgl Peminjaman', widget.bookDate),
              buildRowWithDivider('Jam Mulai', widget.jamMulai),
              buildRowWithDivider('Jam Selesai', widget.jamSelesai),
              buildRowWithDivider('Jml Pengguna', widget.jumlahPengguna),
              buildRowWithDivider('Keterangan', widget.keterangan),
              SizedBox(height: 16),
              Text(
                'Alasan Ditolak:',
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
                  hintText: 'Masukkan alasan ditolak',
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
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonAccept(
                    label: 'Simpan',
                    onPressed: () {
                      _handlePost();
                      // print("id: ${widget.id}");
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