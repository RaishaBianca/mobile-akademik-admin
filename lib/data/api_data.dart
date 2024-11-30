import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

final String base_url = 'https://02a6-180-252-92-160.ngrok-free.app/api/';
late String endpoint;
late SharedPreferences prefs;

Future<void> initializePreferences() async {
  prefs = await SharedPreferences.getInstance();
}

Future<String?> getAccessToken() async {
  await initializePreferences();
  return prefs.getString('access_token');
}

Future<Map<String, String>> _getHeaders() async {
  final accessToken = await getAccessToken();

  if (base_url.contains('ngrok')) {
    return {
      'Authorization' : 'Bearer $accessToken',
      'ngrok-skip-browser-warning': '69420',
    };
  }
  return {
    'Authorization' : 'Bearer $accessToken',
  };
}

Future<Map<String, dynamic>> login(String identifier, String password) async {
  endpoint = 'login';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'identifier': identifier,
    'password': password,
    'role': 'admin,admin_fakultas,admin_kelas,super_admin',
  });
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}

Future<Map<String, dynamic>?> fetchUserData() async {
  endpoint = 'user';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');
  if (accessToken != null) {
    try {
      final response = await http.get(
        Uri.parse(base_url + endpoint),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        return userData;
      } else {
        print('Failed to load user data');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  return null;
}

Future<List<Map<String, dynamic>>> getAllPeminjaman() async {
  endpoint = 'peminjaman';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, 
    headers: await _getHeaders()
    );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getPeminjamanLab() async {
  endpoint = 'peminjaman/lab';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, 
    headers: await _getHeaders()
    );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getPeminjamanKelas() async {
  endpoint = 'peminjaman/kelas';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, 
    headers: await _getHeaders()
    );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Map<String, dynamic>> getPeminjamanCount() async {
  endpoint = 'peminjaman/count';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Map<String, dynamic>> getKendalaCount() async {
  endpoint = 'kendala/count';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiPeminjaman(String id, String status) async {
  endpoint = 'peminjaman/verifikasi';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
  }, headers: await _getHeaders());
  print(response.body);
  return response.statusCode;
}

Future<List<Map<String, dynamic>>> getAllKendala() async {
  endpoint = 'kendala';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getKendalaLab() async {
  endpoint = 'kendala/lab';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getKendalaKelas() async {
  endpoint = 'kendala/kelas';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiKendala(String id, String status, String keterangan) async {
  endpoint = 'kendala/verifikasi';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
    'keterangan_penyelesaian': keterangan,
  }, headers: await _getHeaders());
  print(response.body);
  return response.statusCode;
}

Future<List<Map<String, dynamic>>> getAllJadwal() async {
  endpoint = 'jadwal';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

// Future<Map<String, dynamic>> getAllProfildosen() async {
//   endpoint = 'profildosen';
//   var url = Uri.parse(base_url + endpoint);
//   var response = await http.get(url, headers: await _getHeaders());
//   if (response.statusCode == 200) {
//     return json.decode(response.body);
//   } else {
//     throw Exception('Failed to load data');
//   }
// }

Future<List<Map<String, dynamic>>> getAllProfildosen() async {
  endpoint = 'profildosen';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  print(response.body);
  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return List<Map<String, dynamic>>.from(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}


Future<int> verifikasiJadwal(String id, String status) async {
  endpoint = 'verifikasi_jadwal';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
  }, headers: await _getHeaders());
  print(response.body);
  return response.statusCode;
}

Future<List<Map<String, dynamic>>> getAllKode() async {
  endpoint = 'kode';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiKode(String id, String status) async {
  endpoint = 'verifikasi_kode';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
  }, headers: await _getHeaders());
  print(response.body);
  return response.statusCode;
}

Future<List> getRuang(String tipe) async {
  endpoint = 'ruangan';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'tipe_ruang': tipe,
  }, headers: await _getHeaders());
  var responseBody = json.decode(response.body);
  return responseBody;
}

Future<List> getPeminjamanStatistik(String room) async {
  endpoint = 'peminjaman/statistik?tipe=$room';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  // print(response.body);
  var responseBody = json.decode(response.body);
  return responseBody['data'];
}

Future<List> getKendalaStatistik(String room) async {
  endpoint = 'kendala/statistik?tipe=$room';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  var responseBody = json.decode(response.body);
  // print(responseBody['data']);
  return responseBody['data'];
}

// Future<Map<String, List<Map<String, dynamic>>>> getKalender() async {
//   endpoint = 'kalender';
//   var url = Uri.parse(base_url + endpoint);
//   var response = await http.get(url, headers: await _getHeaders());
//
//   if (response.statusCode == 200) {
//     Map<String, dynamic> responseBody = json.decode(response.body);
//     return responseBody.map((key, value) => MapEntry(
//         key,
//         List<Map<String, dynamic>>.from(value.map((item) => Map<String, dynamic>.from(item)))
//     ));
//   } else {
//     throw Exception('Failed to load kalender data');
//   }
// }