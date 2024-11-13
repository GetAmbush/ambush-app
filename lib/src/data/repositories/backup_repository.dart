import 'package:ambush_app/src/data/datasource/local_datasource.dart';
import 'package:injectable/injectable.dart';

abstract class IBackupRepository {
  void saveBackup();
}

@Injectable(as: IBackupRepository)
class BackupRepository implements IBackupRepository {
  final ILocalDataSource _localDataSource;

  BackupRepository(this._localDataSource);

  @override
  void saveBackup() => _localDataSource.saveBackup();
}
