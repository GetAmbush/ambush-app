import 'package:ambush_app/src/data/datasource/local_datasource.dart';
import 'package:ambush_app/src/data/models/hive_backup.dart';
import 'package:injectable/injectable.dart';

abstract class IBackupRepository {
  HiveBackup? getBackup();
  Future<void> createBackup(HiveBackup backup);
}

@Injectable(as: IBackupRepository)
class BackupRepository implements IBackupRepository {
  final ILocalDataSource _localDataSource;

  BackupRepository(this._localDataSource);

  @override
  HiveBackup? getBackup() => _localDataSource.recoverBackup();

  @override
  Future<void> createBackup(HiveBackup backup) =>
      _localDataSource.createBackup(backup);
}
