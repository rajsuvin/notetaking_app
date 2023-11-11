import 'package:flutter/material.dart';


import '../colors/colors.dart';
import '../firebase.dart';
import '../widgets/button.dart';
import '../widgets/models.dart';
import '../widgets/note.dart';
import 'createpage.dart';
import 'editpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkBackgroundColor,
        title: Text(
          "Notes",
          style: TextStyle(fontSize: 40),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              children: [
                ButtonWidget(icon: Icons.search),
                SizedBox(
                  width: 10,
                ),
                ButtonWidget(icon: Icons.info_outline),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          backgroundColor: Colors.black54,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => CreateNotePage()));
          },
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<List<NoteModel>>(
          stream: Firebase.getNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Image.asset(
                  "assets/ios_loading.gif",
                  width: 50,
                  height: 50,
                ),
              );
            }
            if (snapshot.hasData == false) {
              return _noNotesWidget();
            }
            if (snapshot.data!.isEmpty) {
              return _noNotesWidget();
            }
            if (snapshot.hasData) {
              final notes = snapshot.data;
              return ListView.builder(
                itemCount: notes!.length,
                itemBuilder: (context, index) {
                  return SingleNoteWidget(
                    title: notes[index].title,
                    body: notes[index].body,
                    color: notes[index].color,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => EditNotePage(noteModel: notes[index],)));
                    },
                    onLongPress: () {
                      showDialogBoxWidget(
                        context,
                        height: 250,
                        title: "Are you sure you want\nto delete this note ?",
                        onTapYes: () {
                          Firebase.deleteNote(notes[index].id!);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              );
            }
            return Center(
              child: Image.asset(
                "assets/ios_loading.gif",
                width: 50,
                height: 50,
              ),
            );
          }),
    );
  }

  _noNotesWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 200,
              height: 200,
              child: Image.asset("assets/add_notes_image.png")),
          SizedBox(
            height: 15,
          ),
          Text(
            "Create Colorful Notes",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  void showDialogBoxWidget(BuildContext context, {required int height, required String title, required Null Function() onTapYes}) {}
}