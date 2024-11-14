import 'package:ambush_app/src/core/routes/app_route.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ambush_app/src/designsystem/buttons.dart';
import 'package:ambush_app/src/presentation/add_invoice/add_invoice_navigation_flow.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OnboardingSuccessScreen extends StatelessWidget {
  const OnboardingSuccessScreen({super.key});

  void _onAddClick(BuildContext context) {
    final navigator = context.router;
    navigator.replace(InvoiceListRoute());
    final flow = AddInvoiceNavigationFlow(navigator);
    flow.start();
  }

  void _willDoThisLater(BuildContext context) {
    context.router.replaceAll([InvoiceListRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Success!',
                  style: textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                Text(
                  "All set! YOUR company's information has been\nsuccessfully submitted. We're ready to move\nforward with your invoice!",
                  textAlign: TextAlign.start, // Align left for subtitle
                  style: textTheme.bodyLarge?.copyWith(color: Colors.grey[700]),
                ),
              ],
            ),
            SizedBox(height: 32),
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Image.asset(
                  'assets/illustration_success.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 64.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      _willDoThisLater(context);
                    },
                    child: Text(
                      "I'll do it later",
                      style: TextStyle(
                        color: colorTheme.primary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  PrimaryButton(text: "Create Invoice", onPressed: () {
                    _onAddClick(context);
                  }),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
