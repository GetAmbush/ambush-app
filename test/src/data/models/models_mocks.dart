import 'package:ambush_app/src/data/models/hive_bank_info.dart';
import 'package:ambush_app/src/data/models/hive_client_info.dart';
import 'package:ambush_app/src/data/models/hive_company_info.dart';
import 'package:ambush_app/src/data/models/hive_service_info.dart';
import 'package:ambush_app/src/domain/models/bank.dart';
import 'package:ambush_app/src/domain/models/bank_info.dart';
import 'package:ambush_app/src/domain/models/client_info.dart';
import 'package:ambush_app/src/domain/models/comp_info.dart';
import 'package:ambush_app/src/domain/models/currency.dart';
import 'package:ambush_app/src/domain/models/invoice.dart';
import 'package:ambush_app/src/domain/models/service_info.dart';

final mockClientInfo = HiveClientInfo('Name', 'Address');
final mockServiceInfo =
    HiveServiceInfo('Description', 0.0, 'Currency', 'Symbol', 'CC', 10.000);
final mockBankInfo = HiveBankInfo(
    'Name', '123', '123', '123', 'Address', null, null, null, null);
final mockCompanyInfo = HiveCompanyInfo(
    'Name',
    HiveCompanyAddress(
        'St', null, 'Neighbourhood', 'City', 'State', 'Country', 'Zip code'),
    'email@email.com',
    'Owner',
    '123');
final mockInvoiceList = [
  Invoice(
      1,
      1,
      1,
      ServiceInfo(
          'Description', 0.0, Currency('Currency', 'CC', 'Symbol'), 10.000),
      CompanyInfo(
          'Name',
          CompanyAddress('Street', null, 'Neighbourhood', 'City', 'State',
              'country', 'zipCode'),
          'email@email.com',
          'ownerName',
          'cnpj'),
      ClientInfo('name', 'address'),
      BankInfo('beneficiaryName',
          Bank('iban', 'swift', 'bankName', 'bankAddress'), null),
      1,
      1)
];
