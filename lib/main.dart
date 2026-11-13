import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/home_screen.dart';
import 'providers/app_provider.dart';
import 'models/student.dart';
import 'models/note.dart';
import 'repositories/note_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Memuat konfigurasi aman dari .env[cite: 3]
  await dotenv.load(fileName: ".env");
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppProviderWrapper(
      child: MaterialApp(
        title: 'Profil Mahasiswa',
        theme: ThemeData(primarySwatch: Colors.blue), // Tema konsisten[cite: 6]
        home: HomeScreen(),
      ),
    );
  }
}

/// Wrapper untuk mengelola state dan menyediakannya ke AppProvider[cite: 4].
class AppProviderWrapper extends StatefulWidget {
  final Widget child;
  const AppProviderWrapper({Key? key, required this.child}) : super(key: key);

  @override
  State<AppProviderWrapper> createState() => _AppProviderWrapperState();
}

class _AppProviderWrapperState extends State<AppProviderWrapper> {
  final NoteRepository _noteRepository = NoteRepository();
  
  Student _student = Student(
    name: 'Nama Mahasiswa',
    nim: '12.34.5678',
    programStudi: 'S1 Informatika',
    email: 'email@students.amikom.ac.id',
  );
  
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final loadedNotes = await _noteRepository.getAllNotes();
    setState(() {
      _notes = loadedNotes;
    });
  }

  void _updateStudent(Student newStudent) {
    setState(() {
      _student = newStudent;
    });
  }

  void _addNote(Note note) async {
    await _noteRepository.saveNote(note);
    await _loadNotes(); // Refresh data
  }

  void _deleteNote(String id) async {
    await _noteRepository.deleteNote(id);
    await _loadNotes(); // Refresh data
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      student: _student,
      notes: _notes,
      updateStudent: _updateStudent,
      addNote: _addNote,
      deleteNote: _deleteNote,
      child: widget.child,
    );
  }
}