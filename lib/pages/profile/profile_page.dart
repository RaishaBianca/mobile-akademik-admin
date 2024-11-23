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
  String profile = '';
  bool isLoading = true; // Add this variable to track loading state

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    final accessToken = prefs.getString('access_token');
    
    if (accessToken != null) {
      try {
        final response = await http.get(
          Uri.parse('http://127.0.0.1:8000/api/user'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'ngrok-skip-browser-warning': '69420',
          },
        );
    

        if (response.statusCode == 200) {
          final userData = jsonDecode(response.body);

          if (mounted) {
            setState(() {
              name = userData['nama'];
              nim = userData['id'];
              email = userData['email'];
              profile = userData['profil'];
              isLoading = false; // Set loading to false after data is fetched
            });
          }
        } else {
          print('Failed to load user data');
          if (mounted) {
            setState(() {
              isLoading = false; // Set loading to false if there's an error
            });
          }
        }
      } catch (e) {
        print('Error: $e');
        if (mounted) {
          setState(() {
            isLoading = false; // Set loading to false if there's an error
          });
        }
      }
    } else {
      if (mounted) {
        setState(() {
          isLoading = false; // Set loading to false if adminId is null
        });
      }
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loader if loading
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      // backgroundImage: AssetImage('images/bg1.png'),
                      backgroundImage: Image.network(profile ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png').image,
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
                    ElevatedButton(
                      onPressed: _logout,
                      child: const Text('Logout'),
                    ),
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