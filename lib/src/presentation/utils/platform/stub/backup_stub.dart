import 'package:ambush_app/src/presentation/utils/backup_error.dart';
import 'package:injectable/injectable.dart';

abstract class IBackup {
  Future<void> create();
  Future<void> restore();
}

@Injectable(as: IBackup)
class Backup implements IBackup {
  @override
  Future<void> create() =>
      throw BackupError('This feature is not implemented for this platform');

  @override
  Future<void> restore() =>
      throw BackupError('This feature is not implemented for this platform');
}
