import 'package:flutter/material.dart';
// import 'package:sqflite_common/sqflite.dart';
import 'package:my_crud_app/note_form_page.dart';
import 'package:my_crud_app/database_helper.dart';

Future<void> main() async {
  // Assurez-vous que les bindings Flutter sont initialisés avant de lancer l'application
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Initialisez la base de données si nécessaire
    await DatabaseHelper().database;
    print("Base de données initialisée avec succès!");
  } catch (e) {
    print('Erreur lors de l\'initialisation de la base de données: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // Cette méthode est appelée pour construire l'interface utilisateur de l'application

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon App CRUD',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Application de Notes CRUD'),
      routes: {
        '/newNote': (context) => const NoteFormPage(),
        // Ajoutez d'autres routes ici si nécessaire
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/newNote',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Définissez ici les variables d'état nécessaires pour votre application
  // late Database database;

  // @override
  // void initState() {
  //   super.initState();
  //   _initializeDatabase();
  // }

  // Future<void> _initializeDatabase() async {
  //   // Initialisez la base de données SQLite ici
  //   final directory = await getApplicationDocumentsDirectory();
  //   final path = join(directory.path, 'notes.db');
  //   database = await openDatabase(path, version: 1, onCreate: (db, version) {
  //     return db.execute(
  //       'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT)',
  //     );
  //   });
  // }
  void _navigateToNoteForm() {
    Navigator.push(
      context,
      // Utilisez MaterialPageRoute pour naviguer vers la page de formulaire de note
      MaterialPageRoute(builder: (context) => const NoteFormPage()),
    );
    // Navigator.pushNamed(context, '/newNote');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(child: Text('Bienvenue dans l\'application CRUD de Notes!')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToNoteForm(),
        tooltip: 'Ajouter une Note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
