import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ObjectBoxDB {
  late final Store store;

  ObjectBoxDB._create(this.store);

  static Future<ObjectBoxDB> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "rpg-db"));
    return ObjectBoxDB._create(store);
  }
}