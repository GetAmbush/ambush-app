import 'package:injectable/injectable.dart';
import 'package:ambush_app/src/data/repositories/onboarding_repository.dart';

abstract class IShowOnboarding {
  bool get();
}

@Injectable(as: IShowOnboarding)
class ShowOnboarding implements IShowOnboarding {
  final IOnboardingRepository _repo;

  ShowOnboarding(this._repo);

  @override
  bool get() => _repo.shouldShowOnboarding();
}
