import 'package:admin_fik_app/pages/peminjaman/menunggu_page.dart';
import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/buttonaccept.dart';
import 'package:admin_fik_app/customstyle/buttonreject.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;
import 'package:url_launcher/url_launcher.dart';
import '';

const List<String> list = <String>['disetujui', 'ditolak'];
const List<String> roomTypes = <String>['lab', 'kelas'];

class DetailpeminjamanPage extends StatefulWidget {
  final int id;
  final String studentName;
  final String no_tlp;
  final String studentNim;
  final String inputDate;
  final String ruangan;
  final String bookDate;
  final String jamMulai;
  final String jamSelesai;
  final String jumlahPengguna;
  final String keterangan;
  final bool isAccepted;

  const DetailpeminjamanPage({
    Key? key,
    required this.id,
    required this.studentName,
    required this.no_tlp,
    required this.studentNim,
    required this.inputDate,
    required this.ruangan,
    required this.bookDate,
    required this.jamMulai,
    required this.jamSelesai,
    required this.jumlahPengguna,
    required this.keterangan,
    required this.isAccepted, required String time,
  }) : super(key: key);

  @override
  _DetailpeminjamanPageState createState() => _DetailpeminjamanPageState();
}

class _DetailpeminjamanPageState extends State<DetailpeminjamanPage> {
  String statusDropdown = list.first;
  String selectedRoomType = roomTypes.first;
  String? selectedRoom;
  List<Map<String, String>> ruanganList = [];
  bool isLoadingRuangan = false;
  TextEditingController reasonController = TextEditingController();
  TextEditingController jamMulaiController = TextEditingController();
  TextEditingController jamSelesaiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    jamMulaiController.text = widget.jamMulai;
    jamSelesaiController.text = widget.jamSelesai;
    selectedRoom = widget.ruangan;
    getRuangan(selectedRoomType);
  }

  Future<void> getRuangan(String roomType) async {
    setState(() {
      isLoadingRuangan = true;
    });

    var data = await api_data.getRuang(roomType);

    setState(() {
      ruanganList = List<Map<String, String>>.from(data.map((item) => {
        'id_ruangan': item['id_ruangan'].toString(),
        'nama_ruangan': item['nama_ruangan'].toString(),
      }));
      isLoadingRuangan = false;

      // Ensure selectedRoom is in the list
      if (!ruanganList.any((room) => room['id_ruangan'] == selectedRoom)) {
        selectedRoom = null;
      }
    });
  }

  Future<void> _handlePost() async {
    await api_data.verifikasiPeminjaman(
      widget.id.toString(),
      statusDropdown,
      reasonController.text,
      jamMulaiController.text,
      jamSelesaiController.text,
      selectedRoom ?? '',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Berhasil menyimpan'),
        duration: Duration(seconds: 2),
      ),
    );
    // Close widget
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Tidak dapat launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Peminjaman",
          style: TextStyle(
            fontSize: 16,
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
            children: [
              buildRowWithDivider('Nama', widget.studentName),
              Row(
                children: [
                  Container(
                    width: 160,
                    child: const Text('No. Telp', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => _launchURL('https://wa.me/${widget.no_tlp}'),
                      child: Text(widget.no_tlp, style: const TextStyle(fontSize: 12, color: Colors.blue, decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: const Color(0x99FF5833)),
              buildRowWithDivider('NIM', widget.studentNim),
              buildRowWithDivider('Tgl Input', widget.inputDate),
              buildDropdownRow('Tipe Ruang', roomTypes, selectedRoomType, (String? newValue) {
                setState(() {
                  selectedRoomType = newValue!;
                  getRuangan(selectedRoomType);
                });
              }, false),
              buildDropdownRow('Ruang', ruanganList.map((room) => room['id_ruangan']!).toList(), selectedRoom, (String? newValue) {
                setState(() {
                  selectedRoom = newValue;
                });
              }, isLoadingRuangan),
              buildRowWithDivider('Tgl Peminjaman', widget.bookDate),
              buildEditableRow('Jam Mulai', jamMulaiController),
              buildEditableRow('Jam Selesai', jamSelesaiController),
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
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableRow(String label, TextEditingController controller, {bool isPhoneNumber = false}) {
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
          ],
        ),
        Divider(color: Color(0x99FF5833)),
      ],
    );
  }

  Widget buildDropdownRow(String label, List<String> items, String? selectedItem, ValueChanged<String?> onChanged, bool isLoading) {
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
              child: DropdownButton<String>(
                value: selectedItem,
                hint: Text("Pilih", style: TextStyle(color: Colors.black)),
                items: items.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: isLoading ? null : onChanged,
                dropdownColor: Color(0xFFFFBE33),
                underline: SizedBox(),
              ),
            ),
          ],
        ),
        Divider(color: Color(0x99FF5833)),
      ],
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
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 12,
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
//             Expanded(
//               child: isPhoneNumber
//                   ? InkWell(
//                 onTap: () => _launchURL('https://wa.me/$value'),
//                 child: Text(
//                   value,
//                   style: const TextStyle(
//                     color: Colors.blue,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               )
//                   : Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Divider(color: Color(0x99FF5833)),
//       ],
//     );
//   }
// }