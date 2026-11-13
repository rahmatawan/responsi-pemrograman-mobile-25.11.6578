import 'package:flutter/material.dart';
import '../models/student.dart';

/// Widget modular untuk menampilkan kartu profil mahasiswa.
class ProfileCard extends StatelessWidget {
  final Student student;

  const ProfileCard({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(student.name[0].toUpperCase()),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(student.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(student.nim),
              Text(student.programStudi),
              Text(student.email),
            ],
          )
        ],
      ),
    );
  }
}