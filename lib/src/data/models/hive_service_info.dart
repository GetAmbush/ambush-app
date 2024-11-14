import 'package:ambush_app/src/domain/models/ambush_info.dart';
import 'package:hive/hive.dart';
import 'package:ambush_app/src/domain/models/service_info.dart';

part 'hive_service_info.g.dart';

const _keyDescription = 'description';
const _keyQuantity = 'quantity';
const _keyCurrencyName = 'currency_name';
const _keyCurrencySymbol = 'currency_symbol';
const _keyCurrencyCc = 'currency_cc';
const _keyPrice = 'price';

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

  Map<String, dynamic> toJson() => {
        _keyDescription: description,
        _keyQuantity: quantity,
        _keyCurrencyName: currencyName,
        _keyCurrencySymbol: currencySymbol,
        _keyCurrencyCc: currencyCC,
        _keyPrice: price
      };

  factory HiveServiceInfo.fromJson(Map<String, dynamic> json) =>
      HiveServiceInfo(
          json[_keyDescription].toString(),
          json[_keyQuantity] as double,
          json[_keyCurrencyName].toString(),
          json[_keyCurrencySymbol].toString(),
          json[_keyCurrencyCc].toString(),
          json[_keyPrice] as double);
}
