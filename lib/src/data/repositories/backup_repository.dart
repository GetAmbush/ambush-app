import 'package:ambush_app/src/data/datasource/local_datasource.dart';
import 'package:injectable/injectable.dart';

abstract class IBackupRepository {
  Future<bool> saveBackup();
  Future<bool> retrieveBackup();
}

@Injectable(as: IBackupRepository)
class BackupRepository implements IBackupRepository {
  final ILocalDataSource _localDataSource;

  BackupRepository(this._localDataSource);

  @override
  Future<bool> saveBackup() async => await _localDataSource.saveBackup();

  @override
  Future<bool> retrieveBackup() async =>
      await _localDataSource.retrieveBackup();
}
