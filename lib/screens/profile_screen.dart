import 'package:flutter/material.dart';
import '../providers/app_provider.dart';
import '../widgets/profile_card.dart';
import '../models/student.dart';

/// Layar untuk menampilkan profil mahasiswa.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mengambil data student dari provider
    final provider = AppProvider.of(context);
    final student = provider?.student;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
      ),
      body: student == null
          ? const Center(child: Text('Data profil tidak ditemukan'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Menampilkan komponen ProfileCard yang modular[cite: 4]
                  ProfileCard(student: student),
                  const SizedBox(height: 24),
                  // Tombol Edit Profil[cite: 4]
                  // Ganti ElevatedButton sebelumnya dengan ini
                  ElevatedButton(
                    onPressed: () {
                      _showEditProfileDialog(context, provider);
                    },
                    child: const Text('Edit Profil'),
                  ),
                ],
              ),
            ),
    );
  }
}

// Letakkan di luar class ProfileScreen
void _showEditProfileDialog(BuildContext context, AppProvider? provider) {
  if (provider == null) return;
  
  final nameController = TextEditingController(text: provider.student.name);
  final nimController = TextEditingController(text: provider.student.nim);

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Edit Profil'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Nama'),
          ),
          TextField(
            controller: nimController,
            decoration: const InputDecoration(labelText: 'NIM'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            // Update data melalui provider
            final updatedStudent = Student(
              name: nameController.text,
              nim: nimController.text,
              programStudi: provider.student.programStudi,
              email: provider.student.email,
            );
            provider.updateStudent(updatedStudent);
            Navigator.pop(ctx);
          },
          child: const Text('Simpan'),
        ),
      ],
    ),
  );
}