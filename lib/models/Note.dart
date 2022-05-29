import 'dart:convert';
import 'package:flutter/material.dart';


class Note {
  int id;
  String title;
  String content;
  Color note_color;

  Note(this.id, this.title, this.content, this.note_color);


  Map<String, dynamic> toMap(bool forUpdate) {
    var data = {
      'title': utf8.encode(title),
      'content': utf8.encode( content ),
      'note_color': note_color.value,
    };
    if(forUpdate){
      data["id"] = this.id;
    }
    return data;
  }



  @override toString() {
    return {
      'id': id,
      'title': title,
      'content': content ,
      'note_color': note_color.toString(),
    }.toString();
  }

}