import 'package:injectable/injectable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ambush_app/src/data/models/hive_client_info.dart';
import 'package:ambush_app/src/data/models/hive_company_info.dart';
import 'package:ambush_app/src/data/models/hive_bank_info.dart';
import 'package:ambush_app/src/data/models/hive_invoice.dart';
import 'package:ambush_app/src/data/models/hive_invoice_list.dart';
import 'package:ambush_app/src/data/models/hive_service_info.dart';
import 'package:ambush_app/src/domain/models/invoice.dart';

import '../../domain/models/ambush_info.dart';

const _appBoxName = 'AppBox';
const _keyDbVersion = 'dbVersion';
const _keyCompanyInfo = 'companyInfo';
const _keyBankInfo = 'bankInfo';
const _keyServiceInfo = 'serviceInfo';
const _keyClientInfo = 'clientInfo';
const _keyInvoiceList = 'invoiceList';
const _keyOnboardingStatus = 'onboardingStatus';
const _keyInfoAlertStatus = 'infoAlertStatus';

abstract class ILocalDataSource {
  Future initLocalDataSource();

  int getDbVersion();

  Future setDbVersion(int version);

  HiveCompanyInfo? getCompanyInfo();

  HiveBankInfo? getBankInfo();

  HiveServiceInfo? getServiceInfo();

  HiveClientInfo getClientInfo();

  List<Invoice> getInvoiceList();

  bool getOnboardingStatus();

  bool getInfoAlertStatus();

  Future<void> deleteInvoice(Invoice invoice);

  Future<void> saveClientInfo(HiveClientInfo value);

  Future<void> saveCompanyInfo(HiveCompanyInfo value);

  Future<void> saveBankInfo(HiveBankInfo value);

  Future<void> saveServiceInfo(HiveServiceInfo value);

  Future<void> saveInvoice(Invoice invoice);

  Future<void> clearInvoiceList();

  Future<void> saveOnboardingStatus(bool status);

  Future<void> saveInfoAlertStatus(bool status);

  Future get(String key);

  Future<void> clearDB();

  Stream<List<Invoice>> observeInvoiceList();

  Stream<HiveCompanyInfo?> observeCompanyInfo();
}

@Singleton(as: ILocalDataSource)
class LocalDataSource implements ILocalDataSource {
  late Box _appBox;

  @override
  Future initLocalDataSource() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HiveCompanyInfoAdapter());
    Hive.registerAdapter(HiveBankInfoAdapter());
    Hive.registerAdapter(HiveServiceInfoAdapter());
    Hive.registerAdapter(HiveClientInfoAdapter());
    Hive.registerAdapter(HiveInvoiceAdapter());
    Hive.registerAdapter(HiveInvoiceListAdapter());
    Hive.registerAdapter(HiveCompanyAddressAdapter());

    _appBox = await _getAppBox();
  }

  Future<Box> _getAppBox() async => await Hive.openBox(_appBoxName);

  @override
  HiveCompanyInfo? getCompanyInfo() => _appBox.get(_keyCompanyInfo);

  @override
  HiveBankInfo? getBankInfo() => _appBox.get(_keyBankInfo);

  @override
  HiveServiceInfo? getServiceInfo() => _appBox.get(_keyServiceInfo);

  @override
  HiveClientInfo getClientInfo() => HiveClientInfo(ambushName, ambushAddress);

  @override
  bool getInfoAlertStatus() =>
      _appBox.get(_keyInfoAlertStatus, defaultValue: false);

  @override
  List<Invoice> getInvoiceList() {
    HiveInvoiceList hiveInvoiceList =
        _appBox.get(_keyInvoiceList, defaultValue: HiveInvoiceList([]));

    return hiveInvoiceList.invoiceList.map((e) => e.toInvoice()).toList();
  }

  @override
  Future<void> saveCompanyInfo(HiveCompanyInfo value) =>
      _appBox.put(_keyCompanyInfo, value);

  @override
  Future<void> saveBankInfo(HiveBankInfo value) =>
      _appBox.put(_keyBankInfo, value);

  @override
  Future<void> saveServiceInfo(HiveServiceInfo value) =>
      _appBox.put(_keyServiceInfo, value);

  @override
  Future<void> saveClientInfo(HiveClientInfo value) =>
      _appBox.put(_keyClientInfo, value);

  @override
  Future<void> saveInvoice(Invoice invoice) async {
    var hiveList = getInvoiceList();
    hiveList.add(invoice);

    return _appBox.put(
      _keyInvoiceList,
      HiveInvoiceList(
        hiveList.map((e) => HiveInvoice.fromInvoice(e)).toList(),
      ),
    );
  }

  @override
  Future deleteInvoice(Invoice invoice) async {
    var list = getInvoiceList();
    list.removeWhere((element) => element.id == invoice.id);

    return _appBox.put(
      _keyInvoiceList,
      HiveInvoiceList(
        list.map((e) => HiveInvoice.fromInvoice(e)).toList(),
      ),
    );
  }

  @override
  Future<void> clearInvoiceList() =>
      _appBox.put(_keyInvoiceList, HiveInvoiceList([]));

  @override
  Stream<List<Invoice>> observeInvoiceList() {
    //TODO: how to emit value on each subscribe? stream.startWith ??
    return _appBox.watch(key: _keyInvoiceList).map((event) {
      HiveInvoiceList listObj = event.value;
      return listObj.invoiceList.map((e) => e.toInvoice()).toList();
    });
  }

  @override
  Stream<HiveCompanyInfo?> observeCompanyInfo() {
    return _appBox.watch(key: _keyCompanyInfo).map((event) {
      return event.value;
    });
  }

  @override
  bool getOnboardingStatus() => _appBox.get(_keyOnboardingStatus) ?? false;

  @override
  Future<void> saveOnboardingStatus(bool status) =>
      _appBox.put(_keyOnboardingStatus, status);

  @override
  Future<void> saveInfoAlertStatus(bool status) =>
      _appBox.put(_keyInfoAlertStatus, status);

  @override
  Future<void> clearDB() => _appBox.clear();

  @override
  Future get(String key) => _appBox.get(key);

  @override
  int getDbVersion() {
    if (_appBox.containsKey(_keyDbVersion)) {
      return _appBox.get(_keyDbVersion);
    } else {
      return 1;
    }
  }

  @override
  Future setDbVersion(int version) async {
    await _appBox.put(_keyDbVersion, version);
  }
}
