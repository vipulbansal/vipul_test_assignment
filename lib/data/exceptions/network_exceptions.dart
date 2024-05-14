class NetworkException implements Exception {
  NetworkException([this._message, this._prefix]);

  final String? _message;
  final String? _prefix;

  @override
  String toString({bool withPrefix = false}) {
    return '${withPrefix ? _prefix : ''}$_message';
  }
}

class CustomErrorException extends NetworkException {
  CustomErrorException([String? message])
      : super(
          message ?? 'Something went wrong! Please try again later.',
          'Error: ',
        );
}

class NoInternetException extends NetworkException {
  NoInternetException([String? message])
      : super(
          message ??
              'No internet connection found. Check your connection and try again.',
          'Error: ',
        );
}

class APIResponseException extends NetworkException {
  APIResponseException([String? message]) : super(message, 'Error: ');
}

class TokenExpiredException extends NetworkException {
  TokenExpiredException([String? message]) : super(message, 'Error: ');
}
