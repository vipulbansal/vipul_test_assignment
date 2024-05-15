
import 'package:get_it/get_it.dart';
import 'package:vipul_test_assignment/repositories/countries_repository.dart';
import 'package:vipul_test_assignment/repositories/states_repository.dart';

final getIt = GetIt.instance;

void registerLocatorsBag() {
  getIt.registerSingleton<CountriesRepository>(CountriesRepository());
  getIt.registerSingleton<StatesRepository>(StatesRepository());
}
