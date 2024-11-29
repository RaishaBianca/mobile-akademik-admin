import 'package:flutter/material.dart';
import 'package:admin_fik_app/pages/jadwal/profiledetail_page.dart';
import 'package:admin_fik_app/customstyle/customsearchbar.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

class ProfildosenPage extends StatefulWidget {
  const ProfildosenPage({super.key});

  @override
  _ProfildosenPageState createState() => _ProfildosenPageState();
}

class _ProfildosenPageState extends State<ProfildosenPage> {
  String searchQuery = '';
  String selectedIdprodi = 'All';
  late Future<List<Map<String, dynamic>>> _profilesFuture;

  @override
  void initState() {
    super.initState();
    _profilesFuture = fetchProfiles();
  }

  Future<List<Map<String, dynamic>>> fetchProfiles() async {
    var data = await api_data.getAllProfildosen();
    return List<Map<String, dynamic>>.from(data.map((item) => {
      'nama': item['nama'].toString() ?? 'Unknown',
      'imageurl': item['imageurl'].toString() ?? '',
      'NIP': item['nip'].toString() ?? 'Unknown',
      'NIDN': item['nidn'].toString() ?? 'Unknown',
      'email': item['email'].toString() ?? 'Unknown',
      'jabatan_fungsi': item['jabatan_fungsi'].toString() ?? 'Unknown',
      'kepakaran': item['kepakaran'].toString() ?? 'Unknown',
      'id_gscholar': item['id_gscholar'].toString() ?? 'Unknown',
      'id_sinta': item['id_sinta'].toString() ?? 'Unknown',
      'id_scopus': item['id_scopus'].toString() ?? 'Unknown',
      'id_prodi': item['id_prodi'].toString() ?? 'Unknown',
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dosen Fakultas Ilmu Komputer',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFF5833),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set all icons to white
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                    onSearch: (query) {
                      setState(() {
                        searchQuery = query;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedIdprodi,
                  onChanged: (value) {
                    setState(() {
                      selectedIdprodi = value!;
                    });
                  },
                  items: [
                    'All',
                    'S1 Informatika',
                    'S1 Sistem Informasi',
                    'D3 Sistem Informasi',
                    'S1 Sains Data',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _profilesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  List<Map<String, String>> profiles = List<Map<String, String>>.from(snapshot.data!);
                  var filteredProfiles = profiles.where((profile) {
                    final matchesSearch = profile['nama']!.toLowerCase().contains(searchQuery.toLowerCase());
                    final matchesIdprodi = selectedIdprodi == 'All' ||
                        profile['id_prodi']!.toLowerCase().trim() == selectedIdprodi.toLowerCase().trim();
                    return matchesSearch && matchesIdprodi;
                  }).toList();
                  return GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: filteredProfiles.length,
                    itemBuilder: (context, index) {
                      final profile = filteredProfiles[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfiledetailPage(
                                nama: profile['nama']!,
                                imageUrl: profile['imageurl']!,
                                NIP: profile['NIP']!,
                                NIDN: profile['NIDN']!,
                                email: profile['email']!,
                                jabatan_fungsi: profile['jabatan_fungsi']!,
                                kepakaran: profile['kepakaran']!,
                                id_gscholar: profile['id_gscholar'] ?? 'Unknown',
                                id_sinta: profile['id_sinta'] ?? 'Unknown',
                                id_scopus: profile['id_scopus'] ?? 'Unknown',
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(profile['imageurl']!),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              profile['nama']!,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    );
  }
}
