import 'package:flutter/material.dart';
import 'NotePage.dart';
import 'models/Note.dart';

class StaggeredTile extends StatefulWidget {
  final Note note;
  StaggeredTile(this.note);
  @override
  StaggeredTiles createState() => StaggeredTiles();
}



class StaggeredTiles extends State<StaggeredTile> {

  late String content ;
  late Color tileColor ;
  late String title;

  @override
  Widget build(BuildContext context) {

    content = widget.note.content;
    tileColor = widget.note.note_color;
    title = widget.note.title;

    return GestureDetector(
      onTap: ()=> _noteTapped(context),
      child: Container(
        decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: EdgeInsets.all(8),
        child:  constructChild(),) ,
    );
  }

  void _noteTapped(BuildContext ctx) {
   // CentralStation.updateNeeded = false;
    Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => NotePage(widget.note)));
  }

  Widget constructChild() {

    List<Widget> contentsOfTiles = [];




    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children:     contentsOfTiles
    );
  }



}