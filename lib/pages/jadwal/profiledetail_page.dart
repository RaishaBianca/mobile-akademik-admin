import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfiledetailPage extends StatelessWidget {
  final String nama;
  final String imageUrl;
  final String NIP;
  final String NIDN;
  final String kepakaran;
  final String email;
  final String jabatan_fungsi;
  final String id_gscholar;
  final String id_sinta;
  final String id_scopus;

  const ProfiledetailPage({
    super.key,
    required this.nama,
    required this.imageUrl,
    required this.NIP,
    required this.NIDN,
    required this.kepakaran,
    required this.email,
    required this.jabatan_fungsi,
    required this.id_gscholar,
    required this.id_sinta,
    required this.id_scopus,
  });

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nama, style: TextStyle(
          fontSize: 18,
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: Color(0xFFFF5833),
        iconTheme: IconThemeData(
          color: Colors.white, // Set all icons to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            SizedBox(height: 20),
            Text(
              nama,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Table(
              columnWidths: {
                0: FixedColumnWidth(160.0),
                1: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('NIP:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(NIP, style: TextStyle(fontSize: 14)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('NIDN:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(NIDN, style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Email:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        onTap: () => _launchURL('mailto:$email'),
                        child: Text(email, style: TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline)),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Jabatan Fungsi:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(jabatan_fungsi, style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Kepakaran:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(kepakaran, style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('ID Google Scholar:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: id_gscholar.contains('-')
                          ? Text(id_gscholar, style: TextStyle(fontSize: 14))
                          : InkWell(
                        onTap: () => _launchURL('https://scholar.google.com/citations?user=$id_gscholar'),
                        child: Text(id_gscholar, style: TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline)),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('ID SINTA:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: id_sinta.contains('-')
                          ? Text(id_sinta, style: TextStyle(fontSize: 14))
                          : InkWell(
                        onTap: () => _launchURL('https://sinta.kemdikbud.go.id/authors/profile/$id_sinta'),
                        child: Text(id_sinta, style: TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline)),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('ID Scopus:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: id_scopus.contains('-')
                          ? Text(id_scopus, style: TextStyle(fontSize: 14))
                          : InkWell(
                        onTap: () => _launchURL('https://www.scopus.com/authid/detail.uri?authorId=$id_scopus'),
                        child: Text(id_scopus, style: TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}