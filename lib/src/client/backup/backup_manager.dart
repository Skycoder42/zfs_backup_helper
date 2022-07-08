class BackupManager {
  Future<List<dynamic>> determineBackupTasks(Stream<String> snapshots) async {
    final snapshotMapping = <String, List<String>>{};
    await for (final snapshot in snapshots) {
      final splitName = snapshot.split('@');
      if (splitName.length != 2) {
        // TODO log error
        continue;
      }

      final datasetName = splitName[0];
      final snapshotName = splitName[1];

      snapshotMapping.update(
        datasetName,
        (value) => value..add(snapshotName),
        ifAbsent: () => [snapshotName],
      );
    }

    throw UnimplementedError();
  }
}
