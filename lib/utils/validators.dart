/// Kelas utilitas untuk validasi dan sanitasi input form.
class Validators {
  /// Memastikan judul memiliki 3-50 karakter.
  static String? validateTitle(String? value) {
    if (value == null || value.length < 3 || value.length > 50) {
      return 'Judul harus antara 3 dan 50 karakter';
    }
    return null;
  }

  /// Memastikan konten memiliki 10-1000 karakter.
  static String? validateContent(String? value) {
    if (value == null || value.length < 10 || value.length > 1000) {
      return 'Konten harus antara 10 dan 1000 karakter';
    }
    return null;
  }

  /// Membersihkan input dari karakter berbahaya (<, >, ", ').
  static String sanitize(String input) {
    return input.replaceAll(RegExp('[<>"\']'), '');
  }
}