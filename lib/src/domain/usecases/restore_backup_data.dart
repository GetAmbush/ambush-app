import 'package:ambush_app/src/data/repositories/application_backup_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IRestoreBackupData {
  Future<void> restore(String backup);
}

@Injectable(as: IRestoreBackupData)
class RestoreBackupData implements IRestoreBackupData {
  final IApplicationBackupRepository _applicationBackupRepository;

  RestoreBackupData(this._applicationBackupRepository);

  @override
  Future<void> restore(String backup) async =>
      _applicationBackupRepository.restore(backup);
}
