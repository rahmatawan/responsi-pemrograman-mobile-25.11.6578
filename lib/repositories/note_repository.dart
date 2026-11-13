import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';
import '../services/secure_storage_service.dart';

/// Repository untuk mengelola penyimpanan catatan.
class NoteRepository {
  static const String _metadataKey = 'notes_metadata';
  final SecureStorageService _secureStorage = SecureStorageService();

  /// Menyimpan catatan baru (metadata di prefs, content di secure storage).
  Future<void> saveNote(Note note) async {
    final prefs = await SharedPreferences.getInstance();
    
    // 1. Ambil metadata lama
    final metadataString = prefs.getString(_metadataKey);
    List<dynamic> metadataList = metadataString != null ? jsonDecode(metadataString) : [];
    
    // 2. Tambahkan metadata baru
    metadataList.add(note.toJsonMetadata());
    await prefs.setString(_metadataKey, jsonEncode(metadataList));
    
    // 3. Simpan isi catatan (content) dengan aman
    await _secureStorage.saveContent(note.id, note.content);
  }

  /// Mengambil semua catatan beserta isinya.
  Future<List<Note>> getAllNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final metadataString = prefs.getString(_metadataKey);
    if (metadataString == null) return [];

    List<dynamic> metadataList = jsonDecode(metadataString);
    List<Note> notes = [];

    for (var meta in metadataList) {
      final content = await _secureStorage.getContent(meta['id']) ?? '';
      notes.add(Note(
        id: meta['id'],
        title: meta['title'],
        content: content,
        date: DateTime.parse(meta['date']),
      ));
    }
    return notes;
  }

  /// Menghapus catatan berdasarkan ID.
  Future<void> deleteNote(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final metadataString = prefs.getString(_metadataKey);
    
    if (metadataString != null) {
      List<dynamic> metadataList = jsonDecode(metadataString);
      metadataList.removeWhere((item) => item['id'] == id);
      await prefs.setString(_metadataKey, jsonEncode(metadataList));
    }
    
    await _secureStorage.deleteContent(id);
  }
}