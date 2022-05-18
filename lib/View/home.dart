import 'dart:convert';
import 'package:book_api/Models/book_response.dart';
import 'package:book_api/View/book_details.dart';
import 'package:book_api/Widgets/app_button.dart';
import 'package:book_api/Widgets/app_text_field.dart';
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
  TextEditingController searchEditingControlller = TextEditingController();

  String get searchKeyword => searchEditingControlller.text;

  _getBooks() async {
    setState(() {
      isLoading = true;
    });
    try {
      var url = Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=${searchKeyword}');
      var response = await http.get(url);
      var responseSTR = response.body;
      var decodedJson = jsonDecode(responseSTR) as Map<String, dynamic>;

      setState(() {
        this.response = BookResponse.fromJson(decodedJson);
      });
    } catch (e) {
      print(e);
      setState(() {
        this.response = null;
      });
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
        padding: EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: AppTextFields(
                  controller: searchEditingControlller,
                )),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: onSearchBtnPress,
                  child: AppButton(
                    btnText: 'Search',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            if (!isLoading)
              Expanded(
                child: ListView.builder(
                    itemCount: response?.items?.length ?? 0,
                    itemBuilder: bookItem),
              ),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  } //build

  Widget bookItem(BuildContext context, int index) => BookTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BookDetails(book: (response?.items![index])!)),
          );
        },
        bookTitle: response?.items![index].volumeInfo?.title ?? "",
        authorName: response?.items![index].volumeInfo?.authors?.first ?? "",
        image: response?.items![index].volumeInfo?.imageLinks?.thumbnail ?? "",
      );

  void onSearchBtnPress() => _getBooks(); // onSearchBtnPress
} // _Home
