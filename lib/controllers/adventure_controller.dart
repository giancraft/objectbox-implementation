import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import '../models/adventure.dart';

class AdventurerController extends ChangeNotifier {
  final Box<Adventurer> _box;

  List<Adventurer> adventurers = [];

  AdventurerController(Store store) : _box = store.box<Adventurer>() {
    loadAdventurers();
  }

  // READ
  void loadAdventurers() {
    adventurers = _box.getAll();
    notifyListeners();
  }

  // CREATE / UPDATE
  void saveAdventurer(Adventurer adventurer) {
    _box.put(adventurer);
    loadAdventurers();
  }

  // DELETE
  void deleteAdventurer(int id) {
    _box.remove(id);
    loadAdventurers();
  }
}