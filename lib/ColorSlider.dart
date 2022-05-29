// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';


class ColorSlider extends StatefulWidget {
  final void Function(Color)  callBackColorTapped ;
  final Color noteColor ;
  ColorSlider({required this.callBackColorTapped, required this.noteColor});
  @override
  _ColorSliderState createState() => _ColorSliderState();
}

class _ColorSliderState extends State<ColorSlider> {

  final colors = [
    Color(0xffF28B81),
    Color(0xfff7bd02),
    Color(0xffFBF476),
    Color(0xffCDFF90),
    Color(0xffA7FEEB),
    Color(0xffCBF0F8),
    Color(0xffAFCBFA),
    Color(0xffD7AEFC),
    Color(0xffFBCFE9),
    Color(0xffE6C9A9),
    Color(0xffE9EAEE),
    Color(0xff1321E0)
  ];

  final Color borderColor = Color(0xffd3d3d3);
  final Color foregroundColor = Color(0xff595959);

  final _check = Icon(Icons.check);

  late Color noteColor;
  late int indexOfCurrentColor;
  @override void initState() {

    super.initState();
    this.noteColor = widget.noteColor;
    indexOfCurrentColor = colors.indexOf(noteColor);
  }



  @override
  Widget build(BuildContext context) {

    return ListView(
      scrollDirection: Axis.horizontal,
      children:
      List.generate(colors.length, (index)
      {
        return
          GestureDetector(
              onTap: ()=> _colorChangeTapped(index),
              child: Padding(
                  padding: EdgeInsets.only(left: 6, right: 6),
                  child:Container(
                      child: new CircleAvatar(
                        child: _checkOrNot(index),
                        foregroundColor: foregroundColor,
                        backgroundColor: colors[index],
                      ),
                      width: 38.0,
                      height: 38.0,
                      padding: const EdgeInsets.all(1.0), // border width
                      decoration: new BoxDecoration(
                        color: borderColor, // border color
                        shape: BoxShape.circle,
                      )
                  ) )
          );

      })
      ,);
  }


  void _colorChangeTapped(int indexOfColor) {
    setState(() {
      noteColor = colors[indexOfColor];
      indexOfCurrentColor = indexOfColor;
      widget.callBackColorTapped(colors[indexOfColor]);
    });

  }

  Widget? _checkOrNot(int index){
    if (indexOfCurrentColor == index) {
      return _check;
    }
    return null;
  }

}