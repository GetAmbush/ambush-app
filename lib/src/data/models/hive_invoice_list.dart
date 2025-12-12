import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'hive_invoice.dart';

part 'hive_invoice_list.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class HiveInvoiceList extends HiveObject {
  @HiveField(0)
  List<HiveInvoice> invoiceList;

  HiveInvoiceList(this.invoiceList);

  factory HiveInvoiceList.fromJson(Map<String, dynamic> json) =>
      _$HiveInvoiceListFromJson(json);
  Map<String, dynamic> toJson() => _$HiveInvoiceListToJson(this);
}
