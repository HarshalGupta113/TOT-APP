import 'dart:convert';

import 'package:flutter/material.dart';

import '../db/database_helper.dart';
import '../models/dog.dart';
import 'package:http/http.dart' as http;

class DogProvider extends ChangeNotifier {
  List<Dog> _dogs = [];
  List<Dog> _savedDogs = [];

  String _errorMessage = '';

  List<Dog> get dogs => _dogs;
  List<Dog> get savedDogs => _savedDogs;
  String get errorMessage => _errorMessage;

  DogProvider() {
    fetchDogs();
    loadSavedDogs();
  }

  Future<void> fetchDogs() async {
    const url = 'https://freetestapi.com/api/v1/dogs';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        _dogs = data.map((dog) => Dog.fromJson(dog)).toList();
        _errorMessage = '';
      } else {
        _errorMessage =
            'Failed to fetch data. Status Code: ${response.statusCode}';
      }
    } catch (error) {
      _errorMessage = "Failed to load data. Please check your internet.";
    }

    notifyListeners();
  }

  Future<void> saveDog(Dog dog) async {
    await DatabaseHelper.instance.insertDog(dog);
    await loadSavedDogs();
  }

  Future<void> removeDog(int id) async {
    await DatabaseHelper.instance.deleteDog(id);
    await loadSavedDogs();
  }

  Future<void> loadSavedDogs() async {
    _savedDogs = await DatabaseHelper.instance.getSavedDogs();
    notifyListeners();
  }
}
