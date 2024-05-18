import 'dart:convert';

import 'package:http/http.dart' as http;

import 'book.dart';

class BooksApi {
  static Future<List<Book>> getBooks(String query) async {
    final url = Uri.parse('http://localhost:5050/drug.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List books = json.decode(response.body);

      return books.map((json) => Book.fromJson(json)).where((book) {
        final titleLower = book.title.toLowerCase();

        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
