import 'package:ambush_app/src/data/repositories/backup_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ISaveBackup {
  Future<void> save();
}

@Injectable(as: ISaveBackup)
class SaveBackup extends ISaveBackup {
  final IBackupRepository _backupRepository;

  SaveBackup(this._backupRepository);

  @override
  Future<void> save() async => await _backupRepository.saveBackup();
}
