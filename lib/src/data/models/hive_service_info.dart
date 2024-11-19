import 'package:ambush_app/src/domain/models/ambush_info.dart';
import 'package:hive/hive.dart';
import 'package:ambush_app/src/domain/models/service_info.dart';

part 'hive_service_info.g.dart';

@HiveType(typeId: 3)
class HiveServiceInfo extends HiveObject {
  @HiveField(0)
  String description;

  @HiveField(1)
  double quantity;

  @HiveField(2)
  String currencyName;

  @HiveField(3)
  String currencySymbol;

  @HiveField(4)
  String currencyCC;

  @HiveField(5)
  double price;

  HiveServiceInfo(
    this.description,
    this.quantity,
    this.currencyName,
    this.currencySymbol,
    this.currencyCC,
    this.price,
  );

  ServiceInfo toServiceInfo() => ServiceInfo(
        description,
        quantity,
        defaultCurrency,
        price,
      );

  static HiveServiceInfo fromServiceInfo(ServiceInfo serviceInfo) =>
      HiveServiceInfo(
        serviceInfo.description,
        serviceInfo.quantity,
        serviceInfo.currency.name,
        serviceInfo.currency.symbol,
        serviceInfo.currency.cc,
        serviceInfo.price,
      );
}
