import 'package:ambush_app/src/data/models/hive_backup.dart';
import 'package:ambush_app/src/data/repositories/general_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ISaveBackup {
  Future<void> save(HiveBackup backup);
}

@Injectable(as: ISaveBackup)
class SaveBackup implements ISaveBackup {
  final IBackupRepository _generalRepository;

  SaveBackup(this._generalRepository);

  @override
  Future<void> save(HiveBackup backup) =>
      _generalRepository.createBackup(backup);
}
