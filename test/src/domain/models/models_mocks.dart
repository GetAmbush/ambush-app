import 'package:ambush_app/src/domain/models/bank.dart';
import 'package:ambush_app/src/domain/models/bank_info.dart';
import 'package:ambush_app/src/domain/models/client_info.dart';
import 'package:ambush_app/src/domain/models/comp_info.dart';
import 'package:ambush_app/src/domain/models/currency.dart';
import 'package:ambush_app/src/domain/models/invoice.dart';
import 'package:ambush_app/src/domain/models/service_info.dart';

final Currency testCurrency = Currency(
  'Dollar',
  'USD',
  '\$',
);

final ServiceInfo testServiceInfo = ServiceInfo(
  'Test Service',
  1.0,
  testCurrency,
  1000.0,
);

final CompanyInfo testCompanyInfo = CompanyInfo(
  'Test Company',
  testCompanyAddress,
  'test@email.com',
  'Test Owner',
  '123456789',
);

final CompanyAddress testCompanyAddress = CompanyAddress(
  'Test street 123',
  'Test ap 1',
  'Test neighbourhood',
  'Test city',
  'Test state',
  'Test country',
  '12345678',
);

final ClientInfo testClientInfo = ClientInfo(
  'Test Client',
  'Test Address',
);

final Bank testBank = Bank(
  'iban',
  'swift',
  'Test Bank',
  'Test Bank address',
);

final BankInfo testBankInfo = BankInfo(
  'Beneficiary name',
  testBank,
  testBank,
);

final Invoice testInvoice = Invoice(
  1,
  1633640400,
  1636228800,
  testServiceInfo,
  testCompanyInfo,
  testClientInfo,
  testBankInfo,
  1633640400,
  1633640400,
);
