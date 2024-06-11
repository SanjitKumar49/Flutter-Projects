import 'package:http/http.dart' as http;

import '../DataClass/Album.dart';
import 'dart:convert';


Future<Album> fetchAlbum() async {
  final response = await http
    //  Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));
  .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}

