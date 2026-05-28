import 'package:flutter/material.dart';
import 'package:objectbox_atv/controllers/adventure_controller.dart';
import 'package:objectbox_atv/models/adventure.dart';

class FakeAdventurerController extends ChangeNotifier implements AdventurerController {
  @override
  List<Adventurer> adventurers = [];

  @override
  void loadAdventurers() {
    // Não precisa fazer nada no teste
  }

  @override
  void saveAdventurer(Adventurer adventurer) {
    // Apenas adiciona na lista temporária da memória
    adventurers.add(adventurer);
    notifyListeners();
  }

  @override
  void deleteAdventurer(int id) {
    adventurers.removeWhere((a) => a.id == id);
    notifyListeners();
  }
}