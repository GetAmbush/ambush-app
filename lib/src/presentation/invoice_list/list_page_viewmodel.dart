import 'package:ambush_app/src/presentation/utils/platform/backup.dart';
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
    super._backup,
  );
}

abstract class _ListPageViewModelBase with Store {
  final IGetInvoiceList _getInvoiceList;
  final IDeleteInvoice _deleteInvoice;
  final IBackup _backup;

  _ListPageViewModelBase(
      this._getInvoiceList, this._deleteInvoice, this._backup) {
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

  Future<void> createApplicationBackup() async => await _backup.create();

  Future<void> restoreApplicationBackup() async => await _backup.restore();

  void _observeChanges() {
    _getInvoiceList.observe().listen((event) {
      updateList(event);
    });
  }

  void refresh() => updateList(_getInvoiceList.get());
}
