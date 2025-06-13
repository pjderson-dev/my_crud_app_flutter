import 'package:flutter/material.dart';

class NoteFormPage extends StatefulWidget {
  const NoteFormPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _NoteFormPageState createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouvelle Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // <-- Ajout du widget Form ici
          key: _formKey, // <-- Association de la clé
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  hintText: 'Entrez le titre de la note',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _titleController.text =
                      value ?? ''; // <-- Utilisation du contrôleur
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Contenu',
                  hintText: 'Entrez le contenu de la note',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer du contenu';
                  }
                  return null;
                },
                onSaved: (value) {
                  _contentController.text =
                      value ?? ''; // <-- Utilisation du contrôleur
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 16),
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save(); // <-- Sauvegarde des valeurs
                    print("Titre : ${_titleController.text}");
                    print("Contenu : ${_contentController.text}");

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Note enregistrée : ${_titleController.text}',
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    print("Formulaire non valide");
                  }
                },
                child: const Text(
                  'Enregistrer la Note',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
