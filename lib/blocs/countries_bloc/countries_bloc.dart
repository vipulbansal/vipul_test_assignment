import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vipul_test_assignment/commons/constants/constants.dart';
import 'package:vipul_test_assignment/data/models/country_model.dart';
import 'package:vipul_test_assignment/repositories/states_repository.dart';

import '../../repositories/countries_repository.dart';
import '../../wrappers/service_locators.dart';

part 'countries_event.dart';

part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  CountriesRepository get _countriesRepository => getIt<CountriesRepository>();

  StatesRepository get _statesRepository => getIt<StatesRepository>();

  CountriesBloc() : super(CountriesState()) {
    on<LoadCountries>((event, emit) async {
      await _mapLoadCountriesToState(event, emit);
    });
    on<CountrySelected>((event, emit) async {
      await _mapCountrySelectedToState(event, emit);
    });
  }

  _mapLoadCountriesToState(
    CountriesEvent countriesEvent,
    Emitter<CountriesState> emit,
  ) async {
    try {
      emit(CountriesState.loading(
        currentState: state,
      ));
      final response = await _countriesRepository.getAllCountries();
      emit(CountriesState.success(CountriesEventApiState.getCountries,
          data: response,
          selectedCountryId: null,
          currentState: state,));
    } catch (error) {
      emit(CountriesState.failure('Could not fetch countries',
          currentState: state));
    }
  }

  _mapCountrySelectedToState(
    CountrySelected countrySelectedEvent,
    Emitter<CountriesState> emit,
  ) async {
    try {
      emit(CountriesState.loading(
        selectedCountry: countrySelectedEvent.countryId,
        currentState: state,
      ));
      final response = await _statesRepository
          .getStatesForSelectedCountry("${Constants.countries}/"
              "${countrySelectedEvent.countryId}${Constants.states}");
      emit(CountriesState.success(CountriesEventApiState.getStates,
          statesData: response,
          selectedCountryId: countrySelectedEvent.countryId,
          currentState: state));
    } catch (error) {
      emit(CountriesState.failure('Could not fetch states',
          currentState: state));
    }
  }
}
