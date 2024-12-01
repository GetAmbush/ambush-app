
import 'package:ambush_app/src/designsystem/constrained_scaffold.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ambush_app/src/core/di/di.dart';
import 'package:ambush_app/src/core/routes/app_route.gr.dart';
import 'package:ambush_app/src/domain/models/invoice.dart';
import 'package:ambush_app/src/presentation/invoice_list/invoice_dialogs.dart';
import 'package:ambush_app/src/presentation/utils/share_invoice.dart';
import 'package:ambush_app/src/presentation/add_invoice/add_invoice_navigation_flow.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'empty_list.dart';
import 'invoice_list_item.dart';
import 'list_page_viewmodel.dart';

@RoutePage()
class InvoiceListPage extends StatelessWidget {
  InvoiceListPage({super.key});

  final ListPageViewModel _viewModel = getIt();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ConstrainedScaffold(
      maxWidth: double.infinity,
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/extended_logo.svg',
          semanticsLabel: 'Ambush logo',
          colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
        ),
        centerTitle: false,
        actions: [
          Observer(builder: (context) {
            var shouldHide = _viewModel.hideMode;

            return IconButton(
              icon: Icon(
                shouldHide ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                _viewModel.toggleHideMode();
              },
            );
          }),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.router.push(const SettingsRoute());
            },
          )
        ],
      ),
      floatingActionButton: Observer(builder: (context) {
        final bool showFab = _viewModel.invoiceList.isNotEmpty;
        return SafeArea(
          bottom: true,
          right: true,
          child: Visibility(
            visible: showFab,
            child: FloatingActionButton.extended(
              label: const Text('New invoice'),
              icon: const Icon(Icons.add),
              onPressed: () {
                _onAddClick(context);
              },
            ),
          ),
        );
      }),
      body: Observer(builder: (context) {
        if (_viewModel.invoiceList.isEmpty) {
          return EmptyList(
            onAddClick: () {
              _onAddClick(context);
            },
          );
        } else {
          return ListBody(
            invoiceList: _viewModel.invoiceList,
            hideMode: _viewModel.hideMode,
            onDelete: (invoice) async {
              await _viewModel.deleteInvoice(invoice);
            },
          );
        }
      }),
    );
  }

  void _onAddClick(BuildContext context) {
    final navigator = context.router;
    final flow = AddInvoiceNavigationFlow(navigator);
    flow.start();
  }
}

class ListBody extends StatelessWidget {
  const ListBody({
    super.key,
    required this.invoiceList,
    required this.hideMode,
    required this.onDelete,
  });

  final List<Invoice> invoiceList;
  final bool hideMode;
  final Function(Invoice) onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.separated(
      itemCount: invoiceList.length + 1,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Your invoices',
              style: textTheme.headlineMedium!.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }

        index -= 1;

        var invoice = invoiceList[index];
        return InvoiceListItem(
          invoice: invoice,
          hideMode: hideMode,
          onCardClick: () async {
            final action = await showDialog<InvoiceActions>(
              context: context,
              builder: (_) => InvoiceOptions(invoice: invoice),
            );

            if (action == InvoiceActions.share) {
              getIt<IShareInvoice>().share(invoice);
            }
            if (action == InvoiceActions.delete) {
              if (!context.mounted) return;
              showDeleteDialog(context, invoice);
            }
          },
        );
      },
    );
  }

  Future showDeleteDialog(BuildContext context, Invoice invoice) async {
    final result = await showDialog(
      context: context,
      builder: (_) => const DeleteDialog(),
    );
    if (result == true) {
      onDelete(invoice);
    }
  }
}
