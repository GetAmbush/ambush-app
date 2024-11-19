import 'package:ambush_app/src/presentation/utils/platform/backup.dart';
import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/domain/usecases/set_onboarding_status.dart';
import 'package:mobx/mobx.dart';

part 'onboarding_viewmodel.g.dart';

@injectable
class OnboardingViewModel extends _OnboardingViewModelBase
    with _$OnboardingViewModel {
  OnboardingViewModel(super.setOnboardingStatus, super._backup);
}

abstract class _OnboardingViewModelBase with Store {
  final ISetOnboardingStatus setOnboardingStatus;
  final IBackup _backup;

  _OnboardingViewModelBase(this.setOnboardingStatus, this._backup);

  Future<void> finishOnboarding() async {
    await setOnboardingStatus.set(true);
  }

  Future<void> executeRestoreBackup() async => await _backup.restore();
}
