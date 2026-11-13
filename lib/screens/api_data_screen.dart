import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import '../config/app_config.dart';

/// Layar untuk menampilkan data dari API publik.
class ApiDataScreen extends StatefulWidget {
  const ApiDataScreen({Key? key}) : super(key: key);

  @override
  State<ApiDataScreen> createState() => _ApiDataScreenState();
}

class _ApiDataScreenState extends State<ApiDataScreen> {
  List<dynamic> _users = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Menggunakan BASE_URL dari AppConfig/.env[cite: 5]
      final url = Uri.parse('${AppConfig.baseUrl}/users');
      final response = await http.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        setState(() {
          _users = jsonDecode(response.body);
          _isLoading = false;
        });
        developer.log('Data berhasil dimuat', name: 'HTTP_LOG'); // Logging aman[cite: 5]
      } else {
        setState(() {
          _errorMessage = 'Gagal memuat data: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } on SocketException {
      setState(() {
        _errorMessage = 'Tidak ada koneksi internet'; // Error handling SocketException[cite: 5]
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Terjadi kesalahan saat memuat data';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Publik (API)')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Loading state yang jelas
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!)) // Error state
              : ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    final user = _users[index];
                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(user['name']),
                      subtitle: Text(user['email']),
                    );
                  },
                ),
    );
  }
}