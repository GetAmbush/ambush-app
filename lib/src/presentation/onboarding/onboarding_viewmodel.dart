import 'package:ambush_app/src/domain/usecases/restore_backup_data.dart';
import 'package:ambush_app/src/presentation/utils/backup/backup_contract.dart';
import 'package:ambush_app/src/presentation/utils/backup/backup_factory.dart';
import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/domain/usecases/set_onboarding_status.dart';
import 'package:mobx/mobx.dart';

part 'onboarding_viewmodel.g.dart';

@injectable
class OnboardingViewModel extends _OnboardingViewModelBase
    with _$OnboardingViewModel {
  OnboardingViewModel(super.setOnboardingStatus, super._restoreBackupData,
      super._backupFactory);
}

abstract class _OnboardingViewModelBase with Store {
  final ISetOnboardingStatus setOnboardingStatus;
  final IRestoreBackupData _restoreBackupData;
  final IBackupFactory _backupFactory;
  late final IBackup _backup;

  _OnboardingViewModelBase(
      this.setOnboardingStatus, this._restoreBackupData, this._backupFactory) {
    _backup = _backupFactory.create();
  }

  Future<void> finishOnboarding() async {
    await setOnboardingStatus.set(true);
  }

  Future<void> restoreApplicationBackup() async {
    final data = await _backup.restore();
    if (data != null) await _restoreBackupData.restore(data);
  }
}
