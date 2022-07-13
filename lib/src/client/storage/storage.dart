import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:rxdart/rxdart.dart';

import '../models/managed_snapshot.dart';

class Storage {
  final Directory _backupRoot;

  Storage(this._backupRoot);

  Stream<ManagedSnapshot> listSnapshots(String dataset) =>
      _datasetDirectory(dataset)
          .list()
          .whereType<File>()
          .where((file) => path.extension(file.path) == '.backup')
          .map((file) => path.basenameWithoutExtension(file.path))
          .map(ManagedSnapshot.parse);

  Directory _datasetDirectory(String dataset) =>
      Directory.fromUri(_backupRoot.uri.resolve(dataset));
}
