import 'package:ambush_app/src/core/utils/migration_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/core/di/di.dart';
import 'package:ambush_app/src/core/routes/app_route.gr.dart';
import 'package:ambush_app/src/domain/usecases/finished_onboarding.dart';

import 'src/app.dart';
import 'src/data/datasource/local_datasource.dart';

Future<void> main() async {
  configureDependencies(Environment.prod);
  await getIt.get<ILocalDataSource>().initLocalDataSource();
  await getIt.get<MigrationUtils>().checkAndMigrateDbIfNeeded();

  runApp(App());
}

@RoutePage()
class MainPage extends StatelessWidget {
  MainPage({super.key});
  final IFinishedOnboarding _hasFinishedOnboarding = getIt();

  @override
  Widget build(BuildContext context) {
    route(context);
    return Container();
  }

  void route(BuildContext context) {
    if (_hasFinishedOnboarding.get()) {
      context.router.replace(InvoiceListRoute());
    } else {
      context.router.replace(OnBoardingRoute());
    }
  }
}
