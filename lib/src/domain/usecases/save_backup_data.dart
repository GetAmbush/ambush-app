import 'package:ambush_app/src/data/repositories/application_backup_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ISaveBackupData {
  Future<void> save(String backup);
}

@Injectable(as: ISaveBackupData)
class SaveBackupData implements ISaveBackupData {
  final IApplicationBackupRepository _applicationBackupRepository;

  SaveBackupData(this._applicationBackupRepository);

  @override
  Future<void> save(String backup) async =>
      _applicationBackupRepository.save(backup);
}
