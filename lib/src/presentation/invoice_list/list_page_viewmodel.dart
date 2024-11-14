import 'package:ambush_app/src/domain/usecases/retrieve_backup.dart';
import 'package:ambush_app/src/domain/usecases/save_backup.dart';
import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/domain/models/invoice.dart';
import 'package:ambush_app/src/domain/usecases/delete_invoice.dart';
import 'package:ambush_app/src/domain/usecases/get_invoice_list.dart';
import 'package:mobx/mobx.dart';

part 'list_page_viewmodel.g.dart';

@injectable
class ListPageViewModel extends _ListPageViewModelBase
    with _$ListPageViewModel {
  ListPageViewModel(
    super._getInvoiceList,
    super._deleteInvoice,
    super._saveBackup,
    super._retrieveBackup,
  );
}

abstract class _ListPageViewModelBase with Store {
  final IGetInvoiceList _getInvoiceList;
  final IDeleteInvoice _deleteInvoice;
  final ISaveBackup _saveBackup;
  final IRetrieveBackup _retrieveBackup;

  _ListPageViewModelBase(this._getInvoiceList, this._deleteInvoice,
      this._saveBackup, this._retrieveBackup) {
    // Get initial value
    refresh();

    // Observe for changes
    _observeChanges();
  }

  bool canShowInfoAlert = false;

  @observable
  ObservableList<Invoice> invoiceList = ObservableList();

  @observable
  String appTitle = '';

  @observable
  bool hideMode = true;

  @action
  void updateList(List<Invoice> list) {
    invoiceList.clear();
    invoiceList
        .addAll(list..sort((a, b) => -a.createdAt.compareTo(b.createdAt)));
  }

  @action
  Future deleteInvoice(Invoice invoice) async {
    await _deleteInvoice.delete(invoice);
  }

  @action
  void toggleHideMode() {
    hideMode = !hideMode;
  }

  Future<void> saveApplicationBackup() async => await _saveBackup.save();

  Future<void> retrieveApplicationBackup() async {
    await _retrieveBackup.retrieve();
    refresh();
  }

  void _observeChanges() {
    _getInvoiceList.observe().listen((event) {
      updateList(event);
    });
  }

  void refresh() => updateList(_getInvoiceList.get());
}
