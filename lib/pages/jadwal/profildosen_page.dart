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
  String selectedProdi = 'All';
  late Future<List<Map<String, dynamic>>> _profilesFuture;
  List<Map<String, dynamic>> profiles = [];
  List<String> prodiList = ['All'];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _profilesFuture = _fetchProfiles();
  }

  Future<List<Map<String, dynamic>>> _fetchProfiles() async {
    var data = await api_data.getAllProfildosen();
    profiles = List<Map<String, dynamic>>.from(data.map((item) => {
      'nama': item['nama'].toString() ?? 'Unknown',
      'imageurl': item['imageurl'].toString() ?? '',
      'NIP': item['nip'].toString() ?? 'Unknown',
      'NIDN': item['nidn'].toString() ?? 'Unknown',
      'email': item['email'].toString() ?? 'Unknown',
      'jabatan': item['jabatan'].toString() ?? 'Unknown',
      'jabatan_fungsi': item['jabatan_fungsi'].toString() ?? 'Unknown',
      'kepakaran': item['kepakaran'].toString() ?? 'Unknown',
      'id_gscholar': item['id_gscholar'].toString() ?? 'Unknown',
      'id_sinta': item['id_sinta'].toString() ?? 'Unknown',
      'id_scopus': item['id_scopus'].toString() ?? 'Unknown',
      'id_prodi': item['id_prodi'].toString() ?? 'Unknown',
    }));
    _extractProdiList();
    return profiles;
  }

  void _extractProdiList() {
    final prodiSet = profiles.map((profile) => profile['id_prodi'].toString()).toSet();
    setState(() {
      prodiList = ['All', ...prodiSet];
    });
  }

  List<Map<String, dynamic>> get filteredProfiles {
    return profiles.where((profile) {
      final matchesSearch = profile['nama']!.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesProdi = selectedProdi == 'All' || profile['id_prodi'] == selectedProdi;
      return matchesSearch && matchesProdi;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dosen FIK',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFF5833),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set all icons to white
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _profilesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No profiles found.'));
          } else {
            final profiles = filteredProfiles;
            return Column(
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
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: DropdownButton<String>(
                          value: selectedProdi,
                          isExpanded: true,
                          items: prodiList.map((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: selectedProdi == value
                                    ? Text(
                                  value,
                                  overflow: TextOverflow.ellipsis,
                                )
                                    : Flexible(child: Text(
                                  value,
                                  maxLines: 2,
                                  overflow: TextOverflow.visible,
                                ))

                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedProdi = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: profiles.length,
                    itemBuilder: (context, index) {
                      final profile = profiles[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(profile['imageurl'] ?? ''),
                        ),
                        title: Text(profile['nama'] ?? 'Unknown'),
                        subtitle: Text(profile['jabatan'] ?? 'Unknown'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfiledetailPage(
                                // id_prodi: profile['id_prodi'] ?? 'Unknown',
                                nama: profile['nama'] ?? 'Unknown',
                                imageUrl: profile['imageurl'] ?? "",
                                NIP: profile['NIP'] ?? 'Unknown',
                                NIDN: profile['NIDN'] ?? 'Unknown',
                                email: profile['email'] ?? 'Unknown',
                                // jabatan: profile['jabatan'] ?? 'Unknown',
                                jabatan_fungsi: profile['jabatan_fungsi'] ?? 'Unknown',
                                kepakaran: profile['kepakaran'] ?? 'Unknown',
                                id_gscholar: profile['id_gscholar'] ?? 'Unknown',
                                id_sinta: profile['id_sinta'] ?? 'Unknown',
                                id_scopus: profile['id_scopus'] ?? 'Unknown',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}