import 'package:auto_route/auto_route.dart';

import 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: MainRoute.page,
      path: '/',
    ),
    AutoRoute(page: InvoiceListRoute.page),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: BasicInfoRoute.page),
    AutoRoute(page: BankInfoRoute.page),
    AutoRoute(page: ServiceInfoRoute.page),
    AutoRoute(page: ClientInfoRoute.page),
    AutoRoute(page: AddInvoiceRoute.page),
    AutoRoute(page: BackupRoute.page),
  ];
}
