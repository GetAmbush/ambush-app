import 'package:auto_route/auto_route.dart';
import 'package:ambush_app/src/core/routes/app_route.gr.dart';
import 'package:ambush_app/src/presentation/settings/base_settings_page.dart';
import 'package:ambush_app/src/presentation/settings/info_navigation_flow.dart';

class OnBoardingNavigationFlow implements InfoNavigationFlow {
  final StackRouter _router;

  OnBoardingNavigationFlow(this._router);

  final _pageConfig = BasicInfoPageConfig(
    ctaText: 'Next',
  );

  @override
  void onBackPress() {
    _router.maybePop();
  }

  @override
  void onFinishFlow() {
    _router.popUntilRoot();
  }

  @override
  void onNextPress() {
    final currentRoute = _router.current.name;
    switch (currentRoute) {
      case BasicInfoRoute.name:
        _router.push(
          AddressRoute(
            flow: this,
            screenConfig: _pageConfig,
          ),
        );
        break;
      case AddressRoute.name:
        _router.push(
          BankInfoRoute(
            flow: this,
            screenConfig: _pageConfig,
          ),
        );
        break;
      case BankInfoRoute.name:
        _router.push(
          ServiceInfoRoute(
            flow: this,
            screenConfig: _pageConfig,
          ),
        );
        break;
      case ServiceInfoRoute.name:
        _router.replaceAll([InvoiceListRoute()]);
        break;
    }
  }

  @override
  void start() {
    _router.replace(
      BasicInfoRoute(
        flow: this,
        screenConfig: _pageConfig,
      ),
    );
  }
}
