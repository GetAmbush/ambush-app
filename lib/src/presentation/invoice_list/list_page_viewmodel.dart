import 'package:ambush_app/src/domain/usecases/get_backup_data.dart';
import 'package:ambush_app/src/domain/usecases/restore_backup_data.dart';
import 'package:ambush_app/src/presentation/utils/backup.dart';
import 'package:ambush_app/src/presentation/utils/backup_factory.dart';
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
    super._getBackupData,
    super._saveBackupData,
    super._backupFactory,
  );
}

abstract class _ListPageViewModelBase with Store {
  final IGetInvoiceList _getInvoiceList;
  final IDeleteInvoice _deleteInvoice;
  final IGetBackupData _getBackupData;
  final IRestoreBackupData _restoreBackupData;
  final IBackupFactory _backupFactory;
  late IBackup _backup;

  _ListPageViewModelBase(this._getInvoiceList, this._deleteInvoice,
      this._getBackupData, this._restoreBackupData, this._backupFactory) {
    // Get initial value
    updateList(_getInvoiceList.get());

    // Observe for changes
    _observeChanges();
    _backup = _backupFactory.create();
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

  void _observeChanges() {
    _getInvoiceList.observe().listen((event) {
      updateList(event);
    });
  }

  Future<void> createApplicationBackup() async {
    final data = await _getBackupData.get();
    await _backup.create(data);
  }

  Future<void> restoreApplicationBackup() async {
    final data = await _backup.restore();
    if (data != null) await _restoreBackupData.restore(data);
  }
}
