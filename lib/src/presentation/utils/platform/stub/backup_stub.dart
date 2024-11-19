import 'package:ambush_app/src/presentation/utils/backup_error.dart';
import 'package:injectable/injectable.dart';

abstract class IBackup {
  Future<void> save();
  Future<void> get();
}

@Injectable(as: IBackup)
class Backup implements IBackup {
  @override
  Future<void> save() =>
      throw BackupError('This feature is not implemented for this platform');

  @override
  Future<void> get() =>
      throw BackupError('This feature is not implemented for this platform');
}
