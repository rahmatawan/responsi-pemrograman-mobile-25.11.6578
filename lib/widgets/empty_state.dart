import 'package:flutter/material.dart';

/// Widget yang ditampilkan jika tidak ada catatan (EmptyState)[cite: 6].
class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notes, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Belum ada catatan.\nTekan tombol + untuk menambah.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}