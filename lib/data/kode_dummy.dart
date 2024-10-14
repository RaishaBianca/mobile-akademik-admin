class KodeDummy {
  final String namaMatkul;
  final String kodeMatkul;
  final String namaDosen;
  final String kodeDosen;

  KodeDummy({
    required this.namaMatkul,
    required this.kodeMatkul,
    required this.namaDosen,
    required this.kodeDosen,
  });
}

List<KodeDummy> kodeDummyList = [
  KodeDummy(
    namaMatkul: 'Kalkulus',
    kodeMatkul: 'SSI123456789',
    namaDosen: 'John Doe',
    kodeDosen: 'SSI987654321',
  ),
  KodeDummy(
    namaMatkul: 'Pemrograman',
    kodeMatkul: 'INF123456780',
    namaDosen: 'Jane Smith',
    kodeDosen: 'IF987654322',
  ),
  KodeDummy(
    namaMatkul: 'Sistem Operasi',
    kodeMatkul: 'DSI123456781',
    namaDosen: 'Michael Johnson',
    kodeDosen: 'DSI987654323',
  ),
  KodeDummy(
    namaMatkul: 'Jaringan Komputer',
    kodeMatkul: 'SSD123456782',
    namaDosen: 'Emily Davis',
    kodeDosen: 'SSD987654324',
  ),
];
