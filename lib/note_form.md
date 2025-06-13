import 'package:flutter/material.dart';

class NoteFormPage extends StatefulWidget {
  const NoteFormPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _NoteFormPageState createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  /*void _saveNote() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      // Ici, vous pouvez ajouter la logique pour enregistrer la note dans la base de données
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Note enregistrée: $_title')));

      Navigator.pop(context);
      // print("Titre: $_title");
      // print("Contenu: $_content");

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Données du formulaire traitées !')),
      // );
      // _titleController.clear();
      // _contentController.clear();
      // _formKey.currentState!.reset();
    }
    // print("Hello");
  }
*/

  void _saveNote() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      print("Titre : $_title");
      print("Contenu : $_content");

      // Ici, vous pouvez ajouter la logique pour enregistrer la note dans la base de données
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Note enregistrée : $_title')));

      Navigator.pop(context);
    } else {
      print("Formulaire non valide");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouvelle Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                _title = value ?? '';
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
                _content = value ?? '';
              },
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                textStyle: const TextStyle(fontSize: 16),
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () => {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text('Données du formulaire traitées !'),
                //   ),
                // ),
                _saveNote(),
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
    );
  }
}
