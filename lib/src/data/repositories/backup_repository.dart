import 'package:ambush_app/src/data/datasource/local_datasource.dart';
import 'package:injectable/injectable.dart';

abstract class IBackupRepository {
  Future<void> saveBackup();
  Future<void> retrieveBackup();
}

@Injectable(as: IBackupRepository)
class BackupRepository implements IBackupRepository {
  final ILocalDataSource _localDataSource;

  BackupRepository(this._localDataSource);

  @override
  Future<void> saveBackup() async => await _localDataSource.saveBackup();

  @override
  Future<void> retrieveBackup() async =>
      await _localDataSource.retrieveBackup();
}
