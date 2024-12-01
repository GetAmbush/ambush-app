import 'package:ambush_app/src/domain/usecases/get_backup_data.dart';
import 'package:ambush_app/src/domain/usecases/restore_backup_data.dart';
import 'package:ambush_app/src/presentation/utils/backup/backup_factory.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'backup_viewmodel.g.dart';

@injectable
class BackupViewModel extends _BackupViewModelBase with _$BackupViewModel {
  BackupViewModel(
    super._restoreBackupData,
    super._getBackupData,
    super._backupFactory,
  );
}

abstract class _BackupViewModelBase with Store {
  final IRestoreBackupData _restoreBackupData;
  final IGetBackupData _getBackupData;
  final IBackupFactory _backupFactory;

  _BackupViewModelBase(
    this._restoreBackupData,
    this._getBackupData,
    this._backupFactory,
  );

  Future<void> createApplicationBackup() async {
    final data = await _getBackupData.get();
    var backup = _backupFactory.create();
    await backup.create(data);
  }

  Future<void> restoreApplicationBackup() async {
    var backup = _backupFactory.create();
    final data = await backup.restore();
    if (data != null) await _restoreBackupData.restore(data);
  }
}
