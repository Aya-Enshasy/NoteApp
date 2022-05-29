import 'package:flutter/material.dart';
import 'models/Note.dart';
import 'dart:async';
import 'MoreOptionsSheet.dart';
import 'package:flutter/services.dart';

class NotePage extends StatefulWidget {
  final Note noteInEditing;

  NotePage(this.noteInEditing);
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final title = TextEditingController();
  final contentController = TextEditingController();
  var note_color;
  final titleFocus = FocusNode();
  final contentFocus = FocusNode();
  var Timer;
  var editableNote;

  final GlobalKey<ScaffoldState> globalKey = new GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      child: Scaffold(
        key: globalKey,
        appBar: AppBar(brightness: Brightness.light,
          leading: BackButton(
            color: Colors.black,
          ),
          actions: archiveAction(context),
          elevation: 1,
          backgroundColor: note_color,
          title: Text('my note'),
        ),
        body: body(context),
      ),
      onWillPop: Pop,
    );
  }

  Widget body(BuildContext ctx) {
    return

      Container(
          color: note_color,
          padding: EdgeInsets.only(left: 16, right: 16, top: 12),
          child:

          SafeArea(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(5),
//          decoration: BoxDecoration(border: Border.all(color: CentralStation.borderColor,width: 1 ),borderRadius: BorderRadius.all(Radius.circular(10)) ),
                  child: EditableText(
                  //    onChanged: (str) => {updateNoteObject()},
                      maxLines: null,
                      controller: title,
                      focusNode: titleFocus,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      cursorColor: Colors.blue,
                      backgroundCursorColor: Colors.blue),
                ),
              ),

              Divider(color: Colors.black,),

              Flexible( child: Container(
                  padding: EdgeInsets.all(5),
//    decoration: BoxDecoration(border: Border.all(color: CentralStation.borderColor,width: 1),borderRadius: BorderRadius.all(Radius.circular(10)) ),
                  child: EditableText(
                   // onChanged: (str) => {updateNoteObject()},
                    maxLines: 300, // line limit extendable later
                    controller: contentController,
                    focusNode: contentFocus,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    backgroundCursorColor: Colors.red,
                    cursorColor: Colors.blue,
                  )
              )
              )

            ],
          ),
            left: true,right: true,top: false,bottom: false,
          )
      )



    ;
  }



  List<Widget> archiveAction(BuildContext context) {
    List<Widget> actions = [];
    actions += [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          child: GestureDetector(
            onTap: () => archivePopup(context),
            child: Icon(
              Icons.archive,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          child: GestureDetector(
          //  onTap: () => bottomSheet(context),
            child: Icon(
              Icons.more_vert,
            ),
          ),
        ),
      ),

    ];
    return actions;
  }

  // void bottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return MoreOptionsSheet(
  //           color: note_color,
  //           callBackColorTapped: _changeColor,
  //           callBackOptionTapped: bottomSheetOptionTappedHandler, key: null ,
  //
  //         );
  //       });
  // }

// this function will ne used to save the updated editing value of the note to the local variables as user types

  void bottomSheetOptionTappedHandler(moreOptions tappedOption) {
    print("option tapped: $tappedOption");
    switch (tappedOption) {
      case moreOptions.delete:
        {
          if (editableNote.id != -1) {
           // deleteNote(globalKey.currentContext);
          } else {
            exitWithoutSaving(context);
          }
          break;
        }
      case moreOptions.share:
        {
            var _editableNote;
            var Share;
            Share.share("${_editableNote.title}\n${_editableNote.content}");

          break;
        }
      case moreOptions.copy : {
        copy();
        break;
      }
    }
  }

  void deleteNote(BuildContext context) {
    if (editableNote.id != -1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirm ?"),
              content: Text("This note will be deleted permanently"),
              actions: <Widget>[
                FlatButton(
                    onPressed: ()  {
                //      var noteDB = NotesDBHandler();
                      Navigator.of(context).pop();
                    //  noteDB.deleteNote(_editableNote);
                //      CentralStation.updateNeeded = true;

                      Navigator.of(context).pop();

                    },
                    child: Text("Yes")),
                FlatButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    child: Text("No"))
              ],
            );
          });
    }
  }

  void changeColor(Color newColorSelected) {
    print("note color changed");
    setState(() {
      note_color = newColorSelected;
      editableNote.note_color = newColorSelected;
    });
    persistColorChange();
    //CentralStation.updateNeeded = true;
  }

  void persistColorChange() {
    if (editableNote.id != -1) {
     // var noteDB = NotesDBHandler();
      editableNote.note_color = note_color;
    //  noteDB.insertNote(_editableNote, false);
    }
  }


  Future<bool> Pop() async {

    Timer.cancel();
    //show saved toast after calling _persistData function.

    // _persistData();
    return true;
  }

  void archivePopup(BuildContext context) {

    if (editableNote.id != -1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirm ?"),
              content: Text("This note will be archived"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => archiveNote(context),
                    child: Text("Yes")),
                FlatButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    child: Text("No"))
              ],
            );
          });
    } else {
      exitWithoutSaving(context);
    }
  }

  void exitWithoutSaving(BuildContext context) {
    // Timer.cancel();
  //  CentralStation.updateNeeded = false;
    Navigator.of(context).pop();
  }

  void archiveNote(BuildContext context) {
    Navigator.of(context).pop();
    // set archived flag to true and send the entire note object in the database to be updated
   // var noteDB = NotesDBHandler();
  //  noteDB.archiveNote(editableNote);
 //   CentralStation.updateNeeded = true;
    // Timer.cancel(); // shutdown the timer

    Navigator.of(context).pop(); // pop back to staggered view
    // TODO: OPTIONAL show the toast of deletion completion
    Scaffold.of(context).showSnackBar(new SnackBar(content: Text("deleted")));
  }

  void copy(){
  //  var noteDB = NotesDBHandler();
    Note copy = Note(-1,
        editableNote.title,
        editableNote.content,
        editableNote.note_color) ;


  //  var status = noteDB.copyNote(copy);
  //   status.then((query_success){
  //     if (query_success){
  //       Navigator.of(_globalKey.currentContext).pop();
  //     }
  //   });
  }



}

