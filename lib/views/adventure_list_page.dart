import 'package:flutter/material.dart';
import '../controllers/adventure_controller.dart';
import '../models/adventure.dart';

class AdventurerListPage extends StatelessWidget {
  final AdventurerController controller;

  const AdventurerListPage({super.key, required this.controller});

  void _showFormDialog(BuildContext context, {Adventurer? adventurer}) {
    final isEditing = adventurer != null;
    final nameController = TextEditingController(text: isEditing ? adventurer.name : '');
    final classController = TextEditingController(text: isEditing ? adventurer.characterClass : '');
    final levelController = TextEditingController(text: isEditing ? adventurer.level.toString() : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Editar Aventureiro' : 'Novo Aventureiro'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nome')),
                TextField(controller: classController, decoration: const InputDecoration(labelText: 'Classe')),
                TextField(controller: levelController, decoration: const InputDecoration(labelText: 'Nível'), keyboardType: TextInputType.number),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () {
                final level = int.tryParse(levelController.text) ?? 1;
                final newAdventurer = Adventurer(
                  id: isEditing ? adventurer.id : 0,
                  name: nameController.text,
                  characterClass: classController.text,
                  level: level,
                );

                // A View apenas delega a ação ao Controller
                controller.saveAdventurer(newAdventurer);
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _showDetailsDialog(BuildContext context, Adventurer adventurer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(adventurer.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${adventurer.id}'),
              Text('Classe: ${adventurer.characterClass}', style: const TextStyle(fontSize: 16)),
              Text('Nível Atual: ${adventurer.level}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fechar')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grupo de Aventureiros')),
      // ListenableBuilder observa o Controller e refaz o build quando notifyListeners() é chamado
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          if (controller.adventurers.isEmpty) {
            return const Center(child: Text('Nenhum aventureiro recrutado ainda.'));
          }

          return ListView.builder(
            itemCount: controller.adventurers.length,
            itemBuilder: (context, index) {
              final adv = controller.adventurers[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(child: Text(adv.level.toString())),
                  title: Text(adv.name),
                  subtitle: Text(adv.characterClass),
                  onTap: () => _showDetailsDialog(context, adv),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showFormDialog(context, adventurer: adv),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        // Delega a deleção ao Controller
                        onPressed: () => controller.deleteAdventurer(adv.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}