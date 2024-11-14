import 'package:ambush_app/src/data/repositories/backup_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ISaveBackup {
  Future<bool> save();
}

@Injectable(as: ISaveBackup)
class SaveBackup extends ISaveBackup {
  final IBackupRepository _backupRepository;

  SaveBackup(this._backupRepository);

  @override
  Future<bool> save() async => await _backupRepository.saveBackup();
}
