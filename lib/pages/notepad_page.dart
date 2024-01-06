import 'package:flutter/material.dart';

class NotepadScreen extends StatefulWidget{
  const NotepadScreen({super.key});

  @override
  State<NotepadScreen> createState() => _NotepadScreenState();
}

class _NotepadScreenState extends State<NotepadScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Profile Page"),
      ),
    );
  }
}