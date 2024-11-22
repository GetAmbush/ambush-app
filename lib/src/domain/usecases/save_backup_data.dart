import 'package:ambush_app/src/data/repositories/application_backup_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IRestoreBackupData {
  Future<void> save(String backup);
}

@Injectable(as: IRestoreBackupData)
class SaveBackupData implements IRestoreBackupData {
  final IApplicationBackupRepository _applicationBackupRepository;

  SaveBackupData(this._applicationBackupRepository);

  @override
  Future<void> save(String backup) async =>
      _applicationBackupRepository.restore(backup);
}
