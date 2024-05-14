part of 'countries_bloc.dart';

enum CountriesEventApiState { getCountries, getStates }

@immutable
abstract class CountriesEvent {}

class LoadCountries extends CountriesEvent {}

class CountrySelected extends CountriesEvent {
  final int countryId;

  CountrySelected(this.countryId);
}
