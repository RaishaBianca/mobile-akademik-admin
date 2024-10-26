import 'package:flutter/material.dart';
import 'package:admin_fik_app/pages/datas/api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    final apiService = ApiService();
    _userData = apiService.fetchData('users').then((data) => data.firstWhere((user) => user['id_user'] == 'LtWDWKVSVr8O8FWpQaml4bNOV5xNWe'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.wb_sunny, color: Colors.white),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final user = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/sylus.jpg'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      user['nama'] ?? 'N/A',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    _buildProfileField(label: 'Nama', value: user['nama'] ?? 'N/A'),
                    const SizedBox(height: 20),
                    _buildProfileField(label: 'NIM', value: user['nim'] ?? 'N/A'),
                    const SizedBox(height: 20),
                    _buildProfileField(label: 'Email', value: user['email'] ?? 'N/A'),
                    const SizedBox(height: 20),
                    _buildProfileField(label: 'Phone Number', value: user['no_tlp'] ?? 'N/A'),
                    const SizedBox(height: 20),
                    _buildProfileField(label: 'Prodi', value: user['prodi'] ?? 'N/A'),
                    const SizedBox(height: 40),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProfileField({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}