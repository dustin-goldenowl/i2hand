import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:i2hand/src/local/entities/new_products_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'database_app.g.dart';

//Run this comment to generate new schema:
//flutter pub run build_runner build --delete-conflicting-outputs
@DriftDatabase(tables: [
  NewProductsEntity
])
class DatabaseApp extends _$DatabaseApp {
  DatabaseApp() : super(_openConnection());

  @override
  int get schemaVersion => 1;
  Future<void> deleteAll() async {}
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // The database saves into the support directory, doesn't expose to user
    // Review carefully before modifying it
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(p.join(dbFolder.path, 'safebump.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
