import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  String bookTitle;
  String authorName;
  String image;

   BookTile(
      {required this.bookTitle,
      required this.authorName,
      required this.image,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.bookTitle),
      subtitle: Text(this.authorName),
      leading: Image.network(this.image,
      ),
    );
  }
}
