import 'package:ambush_app/src/domain/models/currency.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

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
    return quantity % 1 == 0
        ? quantity.toInt().toString()
        : quantity.toString();
  }

  //ignore: strict_top_level_inference
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
}
