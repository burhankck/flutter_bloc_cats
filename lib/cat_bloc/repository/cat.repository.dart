import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:bloc_cats/cat_bloc/model/cat.dart';

abstract class CatsRepository {
  Future<List<Cat>?> getCats();
}

class SampleCatsRepository implements CatsRepository {
  final baseUrl = Uri.parse("https://hwasampleapi.firebaseio.com/http.json");
  @override
  Future<List<Cat>?> getCats() async {
    // ignore: unused_local_variable
    final response = await http.get(baseUrl);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = jsonDecode(response.body) as List;
        return jsonBody.map((e) => Cat.fromJson(e)).toList();
      default:
    }
    throw NetworkError(response.body);
  }
}

class NetworkError implements Exception {
  final String errors;

  NetworkError(this.errors);
}
