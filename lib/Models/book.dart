import 'package:book_api/Models/volume_info.dart';

class Book {
  VolumeInfo? volumeInfo;

  Book({this.volumeInfo});

  factory Book.fromJson(Map<String,dynamic> json){

    var bookParsed = Book();
    bookParsed.volumeInfo = VolumeInfo.fromJson(json['volumeInfo']);

    return bookParsed;
  }
} // Book