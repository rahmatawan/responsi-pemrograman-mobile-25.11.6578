import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Layanan untuk mengelola penyimpanan aman.
class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  /// Menyimpan isi catatan secara terenkripsi.
  Future<void> saveContent(String noteId, String content) async {
    await _storage.write(key: 'note_content_$noteId', value: content);
  }

  /// Membaca isi catatan terenkripsi.
  Future<String?> getContent(String noteId) async {
    return await _storage.read(key: 'note_content_$noteId');
  }

  /// Menghapus isi catatan terenkripsi.
  Future<void> deleteContent(String noteId) async {
    await _storage.delete(key: 'note_content_$noteId');
  }
}