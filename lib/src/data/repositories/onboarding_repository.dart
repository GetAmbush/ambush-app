import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/data/datasource/local_datasource.dart';

abstract class IOnboardingRepository {
  bool hasFinishedOnboarding();

  Future<void> setOnboardingStatus(bool status);
}

@Singleton(as: IOnboardingRepository)
class OnboardingRepository implements IOnboardingRepository {
  final ILocalDataSource _source;

  OnboardingRepository(this._source);

  @override
  bool hasFinishedOnboarding() {
    try {
      var onboardingStatus = _source.getOnboardingStatus();
      var companyInfo = _source.getCompanyInfo();
      var address = companyInfo?.address;
      if (address is String) {
        throw Exception("Force migration");
      }
      return onboardingStatus;
    } catch (e) {
      _source.clearDB();
      return false;
    }
  }

  @override
  Future<void> setOnboardingStatus(bool status) =>
      _source.saveOnboardingStatus(status);
}
