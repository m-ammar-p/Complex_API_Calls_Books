import 'dart:convert';

import 'package:book_api/Models/book_response.dart';
import 'package:book_api/Widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  BookResponse? response;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getBooks();
  } // initState

  _getBooks() async {
    setState(() {
      isLoading = true;
    });
    try {
      var url = Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=flutter');
      var response = await http.get(url);
      var responseSTR = response.body;
      var decodedJson = jsonDecode(responseSTR) as Map<String , dynamic>;

      setState(() {
        this.response = BookResponse.fromJson(decodedJson);
      });

    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  } // _getBooks

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 60),
          child: !isLoading
            ? ListView.builder(
              itemCount: response?.items?.length ?? 0,
              itemBuilder: bookItem) :
          Center(child: CircularProgressIndicator(),),
        ),

    );
  } //build


  Widget bookItem(BuildContext context, int index) => BookTile(
    bookTitle: response?.items![index].volumeInfo?.title ?? "",
    authorName: response?.items![index].volumeInfo?.authors?.first ?? "",
    image: response?.items![index].volumeInfo?.imageLinks?.thumbnail ?? "",
  );


} // _Home
