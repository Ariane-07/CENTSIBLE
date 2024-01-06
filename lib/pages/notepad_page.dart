import 'package:flutter/material.dart';
import 'package:groceryapp/model/note_database.dart';
import 'package:provider/provider.dart';

import '../model/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeNotes();
  }

  Future<void> initializeNotes() async {
    try {
      await context.read<NoteDataBase>().fetchNotes();
    } catch (e) {
      print('Error initializing notes: $e');
      // Handle initialization/fetching errors here
      // For example, show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error initializing notes: $e'),
        ),
      );
    }
  }

  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<NoteDataBase>().addNote(textController.text);
              Navigator.pop(context);
            },
            child: const Text("Create"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDataBase>();
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          final note = currentNotes[index];

          return ListTile(
            title: Text(note.text),
          );
        },
      ),
    );
  }
}
