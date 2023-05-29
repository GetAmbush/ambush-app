import 'package:injectable/injectable.dart';
import 'package:invoice_app/src/core/data/models/hive_service_info.dart';
import 'package:invoice_app/src/core/domain/data_models/service_info.dart';

import '../datasources/local_datasource.dart';

abstract class IServiceRepository {
  ServiceInfo? getServiceInfo();
  Future<void> saveServiceInfo(ServiceInfo serviceInfo);
}

@Singleton(as: IServiceRepository)
class ServiceRepository implements IServiceRepository {
  final ILocalDataSource _source;

  ServiceRepository(this._source);

  @override
  ServiceInfo? getServiceInfo() {
    var hiveServiceInfo = _source.getServiceInfo();
    return hiveServiceInfo?.toServiceInfo();
  }

  @override
  Future<void> saveServiceInfo(ServiceInfo serviceInfo) {
    var hiveModel = HiveServiceInfo.fromServiceInfo(serviceInfo);
    return _source.saveServiceInfo(hiveModel);
  }

}