import 'package:ambush_app/src/domain/usecases/retrieve_backup.dart';
import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/domain/usecases/set_onboarding_status.dart';
import 'package:mobx/mobx.dart';

part 'onboarding_viewmodel.g.dart';

@injectable
class OnboardingViewModel extends _OnboardingViewModelBase
    with _$OnboardingViewModel {
  OnboardingViewModel(super.setOnboardingStatus, super.retrieveBackup);
}

abstract class _OnboardingViewModelBase with Store {
  final ISetOnboardingStatus setOnboardingStatus;
  final IRetrieveBackup retrieveBackup;

  _OnboardingViewModelBase(this.setOnboardingStatus, this.retrieveBackup);

  Future<void> finishOnboarding() async {
    await setOnboardingStatus.set(true);
  }

  Future<bool> executeRetrieveBackup() async => await retrieveBackup.retrieve();
}
