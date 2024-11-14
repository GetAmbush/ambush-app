import 'package:ambush_app/src/data/repositories/backup_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IRetrieveBackup {
  Future<void> retrieve();
}

@Injectable(as: IRetrieveBackup)
class RetrieveBackup implements IRetrieveBackup {
  final IBackupRepository _backupRepository;

  RetrieveBackup(this._backupRepository);

  @override
  Future<void> retrieve() async => await _backupRepository.retrieveBackup();
}
