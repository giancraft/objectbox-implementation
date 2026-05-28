import 'package:flutter/material.dart';
import 'package:objectbox_atv/views/adventure_list_page.dart';
import 'controllers/adventure_controller.dart';
import 'core/database/objectbox_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inicializa o banco de dados
  final db = await ObjectBoxDB.create();

  // 2. Instancia o Controller injetando o Store do banco
  final controller = AdventurerController(db.store);

  // 3. Roda o App passando o Controller
  runApp(RpgApp(controller: controller));
}

class RpgApp extends StatelessWidget {
  final AdventurerController controller;

  const RpgApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taverna do ObjectBox',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: AdventurerListPage(controller: controller),
    );
  }
}