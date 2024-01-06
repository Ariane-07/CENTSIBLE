import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceryapp/model/note_database.dart';
import 'package:provider/provider.dart';

import '../model/note.dart';

class NotesPage extends StatefulWidget{
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // text controller to access what the user types
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // on app startup, fetch existing notes

    readNotes();
  }

  // create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            content: TextField(
              controller: textController,
            ),
            actions: [
              // create button
              MaterialButton(
                onPressed: () {
                  // add to db
                  context.read<NoteDataBase>().addNote(textController.text);

                  // clear controller
                  textController.clear();


                  // pop dialog box
                  Navigator.pop(context);
                },
                child: const Text("Create"),
              )
            ],
          ),
    );
  }

  // read notes
  void readNotes() {
    context.read<NoteDataBase>().fetchNotes();
  }

  // update a note
  void updateNote(Note note){
    // pre-fill the current note text
    textController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: TextField(controller: textController),
          actions: [
            // update button
            MaterialButton(onPressed: () {
              // update note in db
              context
                .read<NoteDataBase>()
                .updateNote(note.id, textController.text);
              // clear controller
              textController.clear();
              // pop dialog box
              Navigator.pop(context);
             },
              child: const Text("Update"),
            )
          ],
        ),
    );
  }
  // delete a note
  void deleteNote(int id){
    context.read<NoteDataBase>().deleteNote(id);
  }
  @override
  Widget build(BuildContext context) {
    // note database
    final noteDatabase = context.watch <NoteDataBase>();

    // current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADING
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),

          // LIST OF NOTES
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                // get individual note
                final note = currentNotes[index];

                // list title UI
                return ListTile(
                  title: Text(
                    note.text,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // edit button
                      IconButton(
                        onPressed: () => updateNote(note),
                        icon: const Icon(Icons.edit),
                      ),

                      // delete button
                      IconButton(
                        onPressed: () => deleteNote(note.id),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}