import 'package:hive/hive.dart';

import 'hive_invoice.dart';

part 'hive_invoice_list.g.dart';

const _keyInvoiceList = 'invoice_list';

@HiveType(typeId: 6)
class HiveInvoiceList extends HiveObject {
  @HiveField(0)
  List<HiveInvoice> invoiceList;

  HiveInvoiceList(this.invoiceList);

  Map<String, dynamic> toJson() =>
      {_keyInvoiceList: invoiceList.map((value) => value.toJson()).toList()};

  factory HiveInvoiceList.fromJson(Map<String, dynamic> json) =>
      HiveInvoiceList(json[_keyInvoiceList] as List<HiveInvoice>);
}
