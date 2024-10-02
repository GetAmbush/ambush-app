import 'package:ambush_app/src/data/repositories/bank_repository.dart';
import 'package:ambush_app/src/data/repositories/company_repository.dart';
import 'package:ambush_app/src/data/repositories/service_repository.dart';
import 'package:ambush_app/src/domain/models/comp_info.dart';
import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/data/datasource/local_datasource.dart';

abstract class IOnboardingRepository {
  bool shouldShowOnboarding();

  Future<void> setOnboardingStatus(bool status);
}

@Singleton(as: IOnboardingRepository)
class OnboardingRepository implements IOnboardingRepository {
  final ILocalDataSource _source;
  final ICompanyRepository _companyRepository;
  final IBankRepository _bankRepository;
  final IServiceRepository _serviceRepository;

  OnboardingRepository(
    this._source,
    this._companyRepository,
    this._bankRepository,
    this._serviceRepository,
  );

  @override
  bool shouldShowOnboarding() {
    try {
      CompanyInfo? companyInfo = _companyRepository.getCompanyInfo();
      if (companyInfo == null || !companyInfo.isValid()) {
        return true;
      }

      if(_bankRepository.getBankInfo() == null) {
        return true;
      }

      if(_serviceRepository.getServiceInfo() == null) {
        return true;
      }

      return false;
    } catch (e) {
      _source.clearDB();
      return true;
    }
  }

  @override
  Future<void> setOnboardingStatus(bool status) =>
      _source.saveOnboardingStatus(status);
}
