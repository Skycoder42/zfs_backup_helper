import 'dart:io';

import 'package:path/path.dart' as path;

class Storage {
  final Directory _backupRoot;

  Storage(this._backupRoot);

  Stream<String> listSnapshots(String dataset) => _datasetDirectory(dataset)
      .list()
      .where((entity) => entity is File)
      .cast<File>()
      .where((file) => path.extension(file.path) == '.backup')
      .map((file) => path.basenameWithoutExtension(file.path));

  Directory _datasetDirectory(String dataset) =>
      Directory.fromUri(_backupRoot.uri.resolve(dataset));
}
