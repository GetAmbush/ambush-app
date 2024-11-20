import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/designsystem/more_options_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ambush_app/src/domain/models/invoice.dart';

class InvoiceListItem extends StatelessWidget {
  const InvoiceListItem({
    super.key,
    required this.invoice,
    required this.hideMode,
    required this.onCardClick,
  });

  static const String _dateFormat = 'MM/dd/yy';

  final Invoice invoice;
  final bool hideMode;
  final VoidCallback onCardClick;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);

    return Card(
      elevation: 1,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onCardClick,
        child: Container(
          padding: const EdgeInsetsDirectional.all(16),
          alignment: Alignment.centerLeft,
          child: _buildHorizontalInvoiceList(context),
        ),
      ),
    );
  }

  Widget _buildHorizontalInvoiceList(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final invoicePrice =
        hideMode ? "**,**" : invoice.service.getFormattedTotalPrice();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: marginBetweenFields),
        Text(
          'Invoice ${invoice.id}',
          style: textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: marginBetweenFields),
        Expanded(
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Issued: ${formatDate(invoice.issueDate)}',
                style: textTheme.bodyMedium,
              ),
              const SizedBox(width: marginBetweenFields),
              Text(
                'Due: ${formatDate(invoice.dueDate)}',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(width: marginBetweenFields),
        Text(
          '${invoice.service.currency.symbol} $invoicePrice',
          style: textTheme.bodyMedium!.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        MoreOptionsButton(),
      ],
    );
  }

  Widget _buildVerticalInvoiceList(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final invoicePrice =
        hideMode ? "**,**" : invoice.service.getFormattedTotalPrice();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Invoice ${invoice.id}',
              style: textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.arrow_right),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Issued: ${formatDate(invoice.issueDate)}',
          style: textTheme.bodyMedium,
        ),
        Text(
          'Due: ${formatDate(invoice.dueDate)}',
          style: textTheme.bodyMedium,
        ),
        Text(
          '${invoice.service.currency.symbol} $invoicePrice',
          style: textTheme.bodyMedium!.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String formatDate(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat(_dateFormat).format(date);
  }
}
