import 'package:ambush_app/src/domain/models/currency.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../presentation/utils/remove_trailing_zeros.dart';

part 'service_info.g.dart';

@JsonSerializable()
class ServiceInfo {
  final String description;
  final double quantity;
  final Currency currency;
  final double price;

  ServiceInfo(this.description, this.quantity, this.currency, this.price);

  double getTotalPrice() => quantity * price;

  String getFormattedTotalPrice() {
    final mask = MoneyMaskedTextController();
    mask.updateValue(getTotalPrice());
    return mask.text;
  }

  String formattedQuantity() {
    return removeTrailingZeros(quantity.toString());
  }

  copyWith({
    String? description,
    double? quantity,
    Currency? currency,
    double? price,
  }) {
    return ServiceInfo(
      description ?? this.description,
      quantity ?? this.quantity,
      currency ?? this.currency,
      price ?? this.price,
    );
  }

  factory ServiceInfo.fromJson(Map<String, dynamic> json) =>
      _$ServiceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceInfoToJson(this);
}
