import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String authToken, String userId) async {
    final url =
        'https://flutter-update-3d404.firebaseio.com/userFavourites/$userId/$id.json?auth=$authToken';

    isFavorite = !isFavorite;
    notifyListeners();

    final response = await http.put(url,
        body: json.encode(
          isFavorite,
        ));
    print(response.statusCode);
    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw HttpException('Product cant be deleted');
    }
  }
}
