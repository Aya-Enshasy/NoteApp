
import 'dart:convert';
import 'package:flutter/material.dart';
import 'models/Note.dart';
import 'HomePage .dart';
import 'StaggeredTiles.dart';

class StaggeredGridPage extends StatefulWidget {
  final notesViewType;
  const StaggeredGridPage({Key? key, this.notesViewType}) : super(key: key);
  @override
  StaggeredGridPageState createState() => StaggeredGridPageState();
}

class StaggeredGridPageState extends State<StaggeredGridPage> {

 // var  noteDB = NotesDBHandler();
  List<Map<String, dynamic>> allNotesInQueryResult = [];
  late viewType notesViewType ;

  @override
  void initState() {
    super.initState();
    this.notesViewType = widget.notesViewType;
  }


  @override void setState(fn) {
    super.setState(fn);
    this.notesViewType = widget.notesViewType;
  }

  @override
  Widget build(BuildContext context) {



    // print("update needed?: ${CentralStation.updateNeeded}");
    // if(CentralStation.updateNeeded) {  retrieveAllNotesFromDatabase();  }
   return Container(child: Padding(padding:  paddingForView(context),
    //, child:
    // new StaggeredGridView.count(key: _stagKey,
    //   crossAxisSpacing: 6,
    //   mainAxisSpacing: 6,
    //   crossAxisCount: _colForStaggeredView(context),
    //   children: List.generate(_allNotesInQueryResult.length, (i){ return _tileGenerator(i); }),
    //   staggeredTiles: _tilesForView() ,
    // ),
   )
   );
  }

  int colForStaggeredView(BuildContext context) {

    if (widget.notesViewType == viewType.List)
      return 1;
    // for width larger than 600 on grid mode, return 3 irrelevant of the orientation to accommodate more notes horizontally
    return MediaQuery.of(context).size.width > 600 ? 3:2  ;
  }
  //
  // List<StaggeredTiles> _tilesForView() { // Generate staggered tiles for the view based on the current preference.
  // //  return List.generate(_allNotesInQueryResult.length,(index){ return StaggeredTiles.fit(1); }
  //   ) ;
  // }


  EdgeInsets paddingForView(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    double padding ;
    double top_bottom = 8;
    if (width > 500) {
      padding = ( width ) * 0.05 ; // 5% padding of width on both side
    } else {
      padding = 8;
    }
    return EdgeInsets.only(left: padding, right: padding, top: top_bottom, bottom: top_bottom);
  }


  StaggeredTile tileGenerator(int i){
    return StaggeredTile(  Note(
        allNotesInQueryResult[i]["id"],
        allNotesInQueryResult[i]["title"] == null ? "" : utf8.decode(allNotesInQueryResult[i]["title"]),
        allNotesInQueryResult[i]["content"] == null ? "" : utf8.decode(allNotesInQueryResult[i]["content"]),
        Color(allNotesInQueryResult[i]["note_color"] ))
    );
  }


  void retrieveAllNotesFromDatabase() {
    // queries for all the notes from the database ordered by latest edited note. excludes archived notes.
    // var _testData = noteDB.selectAllNotes();
    // _testData.then((value){
    //   setState(() {
    //     this._allNotesInQueryResult = value;
    //     CentralStation.updateNeeded = false;
    //   });
    // });
  }


}


