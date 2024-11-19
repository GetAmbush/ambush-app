import 'package:ambush_app/src/data/models/hive_backup.dart';
import 'package:ambush_app/src/data/repositories/general_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IGetBackup {
  HiveBackup? get();
}

@Injectable(as: IGetBackup)
class GetBackup implements IGetBackup {
  final IBackupRepository _generalRepository;

  GetBackup(this._generalRepository);

  @override
  HiveBackup? get() => _generalRepository.getBackup();
}
