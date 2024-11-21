import 'package:flutter_test/flutter_test.dart';

import 'models_mocks.dart';

void main() {
  group('ServiceInfo', () {
    test(
        'Given quantity 2.0 and price 50.0, when getTotalPrice is called, then it should return 100.0',
        () {
      final serviceInfo = testServiceInfo.copyWith(
        quantity: 2.0,
        price: 50.0,
      );
      expect(serviceInfo.getTotalPrice(), 100.0);
    });

    test(
        'Given quantity 2.0 and price 50.0, when getFormattedTotalPrice is called, then it should return \$100.00',
        () {
      final serviceInfo = testServiceInfo.copyWith(
        quantity: 2.0,
        price: 50.0,
      );
      expect(serviceInfo.getFormattedTotalPrice(), '100,00');
    });

    test(
        'Given quantity 1.1230000, when formattedQuantity is called, then it should return 1.123 without trailing zeros',
        () {
      final serviceInfo = testServiceInfo.copyWith(quantity: 1.1230000);
      expect(serviceInfo.formattedQuantity(), '1.123');
    });

    test(
        'Given quantity 1.1234567, when formattedQuantity is called, then it should return 1.1234567 without trailing zeros',
        () {
      final serviceInfo = testServiceInfo.copyWith(quantity: 1.1234567);
      expect(serviceInfo.formattedQuantity(), '1.1234567');
    });

    test(
        'Given quantity 1.0000000, when formattedQuantity is called, then it should return 1 without trailing zeros',
        () {
      final serviceInfo = testServiceInfo.copyWith(quantity: 1.0000000);
      expect(serviceInfo.formattedQuantity(), '1');
    });

    test(
        'Given quantity 0.1230000, when formattedQuantity is called, then it should return 0.123 without trailing zeros',
        () {
      final serviceInfo = testServiceInfo.copyWith(quantity: 0.1230000);
      expect(serviceInfo.formattedQuantity(), '0.123');
    });

    test(
        'Given quantity 0.0000000, when formattedQuantity is called, then it should return 0 without trailing zeros',
        () {
      final serviceInfo = testServiceInfo.copyWith(quantity: 0.0000000);
      expect(serviceInfo.formattedQuantity(), '0');
    });

    test(
        'Given quantity 0.0 and price 50.0, when getTotalPrice and getFormattedTotalPrice and formattedQuantity are called, then they should return 0.0, \$0.00 and 0 respectively',
        () {
      final serviceInfo = testServiceInfo.copyWith(
        quantity: 0.0,
        price: 50.0,
      );
      expect(serviceInfo.getTotalPrice(), 0.0);
      expect(serviceInfo.getFormattedTotalPrice(), '0,00');
      expect(serviceInfo.formattedQuantity(), '0');
    });

    test(
        'Given quantity 2.0 and price 0.0, when getTotalPrice and getFormattedTotalPrice are called, then they should return 0.0 and \$0.00 respectively',
        () {
      final serviceInfo = testServiceInfo.copyWith(
        quantity: 2.0,
        price: 0.0,
      );

      expect(serviceInfo.getTotalPrice(), 0.0);
      expect(serviceInfo.getFormattedTotalPrice(), '0,00');
    });
  });
}
