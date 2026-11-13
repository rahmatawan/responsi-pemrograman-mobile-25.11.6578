import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Konfigurasi aplikasi yang memuat environment variables.
class AppConfig {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}