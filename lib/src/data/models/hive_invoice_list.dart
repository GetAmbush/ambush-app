import 'package:hive/hive.dart';

import 'hive_invoice.dart';

part 'hive_invoice_list.g.dart';

@HiveType(typeId: 6)
class HiveInvoiceList extends HiveObject {
  @HiveField(0)
  List<HiveInvoice> invoiceList;

  HiveInvoiceList(this.invoiceList);
}
