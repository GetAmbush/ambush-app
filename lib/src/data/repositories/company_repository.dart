import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/data/models/hive_company_info.dart';
import 'package:ambush_app/src/domain/models/comp_info.dart';

import '../datasource/local_datasource.dart';

abstract class ICompanyRepository {
  CompanyInfo? getCompanyInfo();

  Future<void> saveCompanyInfo(CompanyInfo value);

  Stream<HiveCompanyInfo?> observeCompanyInfo();
}

@Singleton(as: ICompanyRepository)
class CompanyRepository implements ICompanyRepository {
  final ILocalDataSource _source;

  CompanyRepository(this._source);

  @override
  CompanyInfo? getCompanyInfo() => _source.getCompanyInfo()?.toDomainModel();

  @override
  Future<void> saveCompanyInfo(CompanyInfo value) =>
      _source.saveCompanyInfo(HiveCompanyInfo.fromDomainModel(value));

  @override
  Stream<HiveCompanyInfo?> observeCompanyInfo() => _source.observeCompanyInfo();
}
