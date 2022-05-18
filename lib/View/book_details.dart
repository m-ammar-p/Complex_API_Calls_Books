import 'dart:convert';

import 'package:book_api/Models/book.dart';
import 'package:book_api/Widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookDetails extends StatefulWidget {
  final Book book;

  const BookDetails({required this.book});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {

  late Book book;
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    book = widget.book;
    _getBookDetail();
  }

  _getBookDetail() async {

    setState((){
      isLoading = true;
    });

    try {
        var uri = Uri.parse("https://www.googleapis.com/books/v1/volumes/${book.id}");
        var response = await http.get(uri);
        var jsonDecoded = jsonDecode(response.body);
        setState((){
          book = Book.fromJson(jsonDecoded);
        });

    } catch(e){
      setState((){
        book = widget.book;
      });
    }

    setState((){
      isLoading = false;
    });

  } // _getBookDetail

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Details"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                AppText(text: book.volumeInfo?.title ?? "", fontSize: 25),
                Image.network(book.volumeInfo?.imageLinks?.extraLarge ?? book.volumeInfo?.imageLinks?.thumbnail ?? ""),
              if(isLoading)
                Center(child: CircularProgressIndicator(),
                ),


            ],
          ),
        ),
      ),
    );
  }
}
