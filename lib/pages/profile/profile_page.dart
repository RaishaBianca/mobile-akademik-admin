import 'package:admin_fik_app/pages/authentication/welcome_screen.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String nim = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    if (userId != null) {
      try {
        final response = await http.get(
          Uri.parse('http://192.168.1.64:8000/api/user/$userId'),
        );

        if (response.statusCode == 200) {
          final userData = jsonDecode(response.body);
          setState(() {
            name = userData['nama'];
            nim = userData['id_user'];
            email = userData['email'];
          });
        } else {
          print('Failed to load user data');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  // Future<void> _logout() async {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) => const WelcomeScreen()),
  //         (Route<dynamic> route) => false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
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
                name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildProfileField(label: 'Nama', value: name),
              const SizedBox(height: 20),
              _buildProfileField(label: 'NIM', value: nim),
              const SizedBox(height: 20),
              _buildProfileField(label: 'Email', value: email),
              const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
              //     );
              //   },
              //   child: const Text('Edit Password'),
              // ),
              // const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: _logout,
              //   child: const Text('Logout'),
              // ),
            ],
          ),
        ),
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