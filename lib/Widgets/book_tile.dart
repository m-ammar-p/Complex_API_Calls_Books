import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  String bookTitle;
  String authorName;
  String image;
  GestureTapCallback onTap;

   BookTile(
      {required this.bookTitle,
      required this.authorName,
      required this.image,
        required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: this.onTap,
      title: Text(this.bookTitle),
      subtitle: Text(this.authorName),
      leading: Image.network(this.image,
      ),
    );
  }
}
