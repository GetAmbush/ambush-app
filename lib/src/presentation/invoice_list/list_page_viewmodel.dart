import 'package:ambush_app/src/domain/usecases/get_backup_data.dart';
import 'package:ambush_app/src/domain/usecases/save_backup_data.dart';
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
  final ISaveBackupData _saveBackupData;
  final IBackupFactory _backupFactory;

  _ListPageViewModelBase(this._getInvoiceList, this._deleteInvoice,
      this._getBackupData, this._saveBackupData, this._backupFactory) {
    // Get initial value
    updateList(_getInvoiceList.get());

    // Observe for changes
    _observeChanges();
  }

  bool canShowInfoAlert = false;
  IBackup get _backup => _backupFactory.create();

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
    await _saveBackupData.save(data);
  }
}
