import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/domain/models/invoice.dart';

import '../datasource/local_datasource.dart';

abstract class IInvoiceRepository {
  List<Invoice> getInvoiceList();

  Future<void> saveInvoice(Invoice value);

  Future<void> deleteInvoice(Invoice invoice);

  Future<void> deleteAllInvoices();

  Stream<List<Invoice>> observe();
}

@Singleton(as: IInvoiceRepository)
class InvoiceRepository implements IInvoiceRepository {
  final ILocalDataSource _source;

  InvoiceRepository(this._source);

  @override
  List<Invoice> getInvoiceList() => _source.getInvoiceList();

  @override
  Future<void> saveInvoice(Invoice value) => _source.saveInvoice(value);

  @override
  Stream<List<Invoice>> observe() => _source.observeInvoiceList();

  @override
  Future<void> deleteInvoice(Invoice invoice) => _source.deleteInvoice(invoice);

  @override
  Future<void> deleteAllInvoices() async {
    final invoices = getInvoiceList();
    for (var invoice in invoices) {
      await deleteInvoice(invoice);
    }
  }
}
