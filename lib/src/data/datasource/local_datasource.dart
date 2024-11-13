import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
import 'dart:html' as html;

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

  Future<void> saveOnboardingStatus(bool status);

  Future<void> saveInfoAlertStatus(bool status);

  Future get(String key);

  Future<void> clearDB();

  Stream<List<Invoice>> observeInvoiceList();

  Stream<HiveCompanyInfo?> observeCompanyInfo();

  void saveBackup();

  void retrieveBackup();
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

  @override
  void saveBackup() {
    final companyInfo = getCompanyInfo()?.toJson();
    final clientInfo = getClientInfo().toJson();
    final bankInfo = getBankInfo()?.toJson();
    final HiveInvoiceList invoiceList =
        _appBox.get(_keyInvoiceList, defaultValue: HiveInvoiceList([]));

    final invoiceListJson = invoiceList.toJson();

    final json = {
      _keyCompanyInfo: companyInfo,
      _keyClientInfo: clientInfo,
      _keyBankInfo: bankInfo,
      _keyInvoiceList: invoiceListJson
    };

    final jsonString = jsonEncode(json);
    _downloadJsonString(jsonString, "invoice_data.json");
  }

  @override
  void retrieveBackup() async {
    final json = await _uploadJsonFile();
    final companyInfo = (json?[_keyCompanyInfo] != null)
        ? HiveCompanyInfo.fromJson(json?[_keyCompanyInfo])
        : null;
    final clientInfo = (json?[_keyClientInfo] != null)
        ? HiveClientInfo.fromJson(json?[_keyClientInfo])
        : null;
    final serviceInfo = (json?[_keyServiceInfo] != null)
        ? HiveServiceInfo.fromJson(json?[_keyServiceInfo])
        : null;
    final bankInfo = (json?[_keyBankInfo] != null)
        ? HiveBankInfo.fromJson(json?[_keyBankInfo])
        : null;
    final invoiceList = (json?[_keyInvoiceList] != null)
        ? HiveInvoiceList.fromJson(json?[_keyInvoiceList])
        : null;

    if (companyInfo != null) saveCompanyInfo(companyInfo);
    if (clientInfo != null) saveClientInfo(clientInfo);
    if (serviceInfo != null) saveServiceInfo(serviceInfo);
    if (bankInfo != null) saveBankInfo(bankInfo);

    if (invoiceList != null) {
      _saveInvoiceList(
          invoiceList.invoiceList.map((elem) => elem.toInvoice()).toList());
    }
  }

  void _downloadJsonString(String content, String fileName) {
    final bytes = utf8.encode(content);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();

    // Clean up the created object URL to free memory
    html.Url.revokeObjectUrl(url);
  }

  Future<Map<String, dynamic>?> _uploadJsonFile() async {
    // Create a completer to return the result asynchronously
    final Completer<Map<String, dynamic>?> completer = Completer();

    // Create an HTML file input element
    final html.FileUploadInputElement input = html.FileUploadInputElement()
      ..accept = '.json'; // Only allow JSON files

    // Trigger the file selection dialog
    input.click();

    // Listen for the file selection event
    input.onChange.listen((e) async {
      final file = input.files!.first; // Get the first selected file
      final reader = html.FileReader();

      // Listen for the file to be read and loaded
      reader.onLoadEnd.listen((e) {
        try {
          // The file is loaded, we can now read the content
          final jsonString = reader.result as String;

          // Parse the content as JSON
          final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
          completer.complete(jsonData); // Complete with the parsed JSON
        } catch (error) {
          print('Error parsing JSON: $error');
          completer
              .completeError(error); // Complete with an error if parsing fails
        }
      });

      // Read the file as text (the JSON content)
      reader.readAsText(file);
    });

    return completer
        .future; // Return the future, which will complete with the JSON data
  }

  void _saveInvoiceList(List<Invoice> list) =>
      list.forEach((item) => saveInvoice(item));
}
