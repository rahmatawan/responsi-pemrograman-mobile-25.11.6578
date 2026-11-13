import 'package:flutter/material.dart';
import '../models/note.dart';
import '../providers/app_provider.dart';
import '../utils/validators.dart';

/// Layar untuk menambahkan catatan baru.
class NoteFormScreen extends StatefulWidget {
  const NoteFormScreen({Key? key}) : super(key: key);

  @override
  State<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Sanitasi input
      final cleanTitle = Validators.sanitize(_title);
      final cleanContent = Validators.sanitize(_content);
      
      final newNote = Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: cleanTitle,
        content: cleanContent,
        date: DateTime.now(),
      );

      final provider = AppProvider.of(context);
      provider?.addNote(newNote); // Mengubah state yang perlu[cite: 5]
      
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Catatan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Judul Catatan'),
                validator: Validators.validateTitle, // Validasi 3-50 karakter[cite: 5]
                onSaved: (value) => _title = value ?? '',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Isi Catatan'),
                maxLines: 5,
                validator: Validators.validateContent, // Validasi 10-1000 karakter[cite: 5]
                onSaved: (value) => _content = value ?? '',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveNote,
                child: const Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}