import 'models/snapshot.dart';

abstract class BackupApi {
  BackupApi._();

  Future<List<Snapshot>> listSnapshots(String rootDataset);
}
