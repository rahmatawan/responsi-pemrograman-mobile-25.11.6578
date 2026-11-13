import 'package:flutter/material.dart';
import '../providers/app_provider.dart';
import '../widgets/note_card.dart';
import '../widgets/empty_state.dart';
import 'profile_screen.dart';
import 'note_form_screen.dart';

/// Layar utama aplikasi yang menampilkan profil singkat dan daftar catatan.
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = AppProvider.of(context);
    final notes = provider?.notes ?? [];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil & Catatan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          if (provider != null) 
            ListTile(
              title: Text(provider.student.name),
              subtitle: Text(provider.student.nim),
            ),
          const Divider(),
          Expanded(
            child: notes.isEmpty
                ? const EmptyState()
                : ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return NoteCard(
                        note: note,
                        onDelete: () {
                          // Memanggil fungsi hapus dari provider
                          provider?.deleteNote(note.id);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoteFormScreen()),
          );
        },
      ),
    );
  }
}