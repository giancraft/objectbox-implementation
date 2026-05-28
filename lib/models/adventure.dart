import 'package:objectbox/objectbox.dart';

@Entity()
class Adventurer {
  @Id()
  int id;

  String name;
  String characterClass;
  int level;

  Adventurer({
    this.id = 0,
    required this.name,
    required this.characterClass,
    required this.level,
  });
}