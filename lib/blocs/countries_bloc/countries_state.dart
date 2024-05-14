part of 'countries_bloc.dart';

@immutable
class CountriesState {
  final dynamic apiState;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;
  final bool isLoading;
  final data;
  final int? selectedCountryId;

  CountriesState({
    this.apiState = '',
    this.isSuccess = false,
    this.isFailure = false,
    this.errorMessage = '',
    this.isLoading = false,
    this.data = '',
    this.selectedCountryId,
  });

  factory CountriesState.empty(
      {int? selectedCountry, required CountriesState currentState}) {
    return currentState.copyWith(
        isSuccess: false,
        isFailure: false,
        errorMessage: "",
        isLoading: false,
        selectedCountryId: selectedCountry);
  }

  factory CountriesState.loading(
      {int? selectedCountry, required CountriesState currentState}) {
    return currentState.copyWith(
        isSuccess: false,
        isFailure: false,
        errorMessage: "",
        isLoading: true,
        selectedCountryId: selectedCountry);
  }

  factory CountriesState.failure(String message,
      {int? selectedCountryId, required CountriesState currentState}) {
    return currentState.copyWith(
        isSuccess: false,
        isFailure: true,
        isLoading: false,
        errorMessage: message,
        selectedCountryId: selectedCountryId);
  }

  factory CountriesState.success(apiState,
      {required int? selectedCountryId,
      data,
      required CountriesState currentState}) {
    return currentState.copyWith(
        isSuccess: true,
        isFailure: false,
        errorMessage: "",
        isLoading: false,
        apiState: apiState,
        data: data,
        selectedCountryId: selectedCountryId);
  }

  CountriesState copyWith({
    dynamic apiState,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
    bool? isLoading,
    var data,
    int? selectedCountryId,
  }) {
    return CountriesState(
      apiState: apiState ?? this.apiState,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      selectedCountryId: selectedCountryId ?? this.selectedCountryId,
    );
  }

  @override
  String toString() {
    return '''HomeState {
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      errorMessage: $errorMessage
    }''';
  }
}
