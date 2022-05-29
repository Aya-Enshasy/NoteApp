import 'package:flutter/material.dart';

import 'ColorSlider.dart';

enum moreOptions { delete, share, copy }

class MoreOptionsSheet extends StatefulWidget {
   final Color color;
   final void Function(Color) Colors;

   final void Function(moreOptions) Options;

  const MoreOptionsSheet(
      {required Key key,
        required this.color,
        required this.Colors,
        required this.Options})
     : super(key: key);

  @override
  _MoreOptionsSheetState createState() => _MoreOptionsSheetState();
}

class _MoreOptionsSheetState extends State<MoreOptionsSheet> {
  var note_color;

  @override
  void initState() {
    note_color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.note_color,
      child: new Wrap(
        children: <Widget>[
          new ListTile(
              leading: new Icon(Icons.delete),
              title: new Text('Delete permanently'),
              onTap: () {
                Navigator.of(context).pop();
                widget.Options(moreOptions.delete);
              }),
          new ListTile(
              leading: new Icon(Icons.content_copy),
              title: new Text('Duplicate'),
              onTap: () {
                Navigator.of(context).pop();
                widget.Options(moreOptions.copy);
              }),
          new ListTile(
              leading: new Icon(Icons.share),
              title: new Text('Share'),
              onTap: () {
                Navigator.of(context).pop();
                widget.Options(moreOptions.share);
              }),
          new Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
              height: 44,
              width: MediaQuery.of(context).size.width,
              child: ColorSlider(
                callBackColorTapped: changeColor,
                // call callBack from notePage here
                noteColor: note_color, // take color from local variable
              ),
            ),
          ),

          new ListTile()
        ],
      ),
    );
  }

  void changeColor(Color color) {
    setState(() {
      this.note_color = color;
      widget.Colors(color);
    });
  }
}