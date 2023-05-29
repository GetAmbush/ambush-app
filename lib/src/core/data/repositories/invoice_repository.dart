import 'package:injectable/injectable.dart';
import 'package:invoice_app/src/core/domain/data_models/invoice.dart';

import '../datasources/local_datasource.dart';

abstract class IInvoiceRepository {
  List<Invoice> getInvoiceList();

  Future<void> saveInvoice(Invoice value);

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
}