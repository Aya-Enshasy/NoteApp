import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'StaggeredView.dart';
import 'models/Note.dart';
import 'NotePage.dart';

enum viewType {
  List,
  Staggered
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override void initState() {
   viewType.Staggered;
  }

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(brightness: Brightness.light,
          actions: appBarAction(),
          elevation: 1,
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: Text("Notes"),
        ),
        body: SafeArea(child:   _body(), right: true, left:  true, top: true, bottom: true,),
        bottomSheet: bottomBar(),
      );

  }

  Widget _body() {
    return Container(child: StaggeredGridPage(notesViewType: viewType.Staggered ,));
  }

  Widget bottomBar() {
    return Row(

      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(

          shape: CircleBorder(),
          color: Colors.blueAccent,
          height: 50,
          child: Text(
            "+",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
          ),
          onPressed: () => newNote(context),
        )
      ],
    );
  }


  void newNote(BuildContext ctx) {
    // "-1" id indicates the note is not new
    var emptyNote = new Note(-1, "", "", Colors.white);
    Navigator.push(ctx,MaterialPageRoute(builder: (ctx) => NotePage(emptyNote)));
  }



  List<Widget> appBarAction() {

    return [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          child: GestureDetector(
            onTap: () => viewType.Staggered ,
            child: Icon(
                Icons.view_headline,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ];
  }


}