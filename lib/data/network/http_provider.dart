import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';

import '../../commons/constants/constants.dart';
import '../../services/loading_spinner_service.dart';
import '../exceptions/network_exceptions.dart';
import '../models/api_error.dart';

class HttpProvider {
  final LoadingSpinnerService _loadingSpinnerService = LoadingSpinnerService();
  static final HttpProvider _instance = HttpProvider._internal();

  factory HttpProvider() => _instance;

  Client get _httpClient => IOClient();

  Uri _getApiUri(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return Uri(
      host: Constants.apiBaseUrl,
      path: '${Constants.apiPath}$path',
      scheme: Constants.apiScheme,
      queryParameters: queryParameters != null && queryParameters.isNotEmpty
          ? queryParameters
          : null,
    );
  }

  Future<dynamic> _interceptedResponse(
    Response response, {
    bool triggerLoader = true,
  }) async {
    dynamic parsed;

    try {
      parsed = json.decode(utf8.decode(response.bodyBytes));

      debugPrint('''[RESPONSE] ::: ' +
        'request : ${response.request.toString()} :: ' +
        'code : ${response.statusCode.toString()} :: ' +
        'body : ${response.body.toString()}''');
    } catch (e) {
      parsed = '';
    }

    _loadingSpinnerService.pop(silent: !triggerLoader);
    switch (response.statusCode) {
      case 200:
      case 201:
        return parsed;
      case 417:
      default:
        final ApiError error =
            ApiError.fromJson(parsed as Map<String, dynamic>);
        throw APIResponseException(error.message);
    }
  }

  Future<dynamic> get(
    String url, {
    Map<String, String> parameters = const <String, String>{},
    Map<String, String> headers = const <String, String>{},
    bool triggerLoader = true,
  }) async {
    _loadingSpinnerService.push(silent: !triggerLoader);
    Response response;
    Uri uri = _getApiUri(
      url,
      queryParameters: parameters,
    );

    try {
      response = await _httpClient.get(
        uri,
        headers: headers,
      );
    } on SocketException {
      _loadingSpinnerService.pop(silent: !triggerLoader);
      throw NoInternetException('No Internet connection');
    } catch (e) {
      _loadingSpinnerService.pop(silent: !triggerLoader);
      rethrow;
    }

    return _interceptedResponse(
      response,
      triggerLoader: triggerLoader,
    );
  }

  Future<dynamic> post(
    String url, {
    required Object body,
    Map<String, String> headers = const <String, String>{},
    Map<String, String> parameters = const <String, String>{},
    bool triggerLoader = true,
  }) async {
    Response response;
    _loadingSpinnerService.push(silent: !triggerLoader);
    Uri uri = _getApiUri(
      url,
      queryParameters: parameters,
    );

    try {
      response = await _httpClient.post(
        uri,
        body: body,
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        }..addAll(headers),
      );
    } on SocketException {
      _loadingSpinnerService.pop(silent: !triggerLoader);
      throw NoInternetException('No Internet connection');
    } catch (e) {
      _loadingSpinnerService.pop(silent: !triggerLoader);
      rethrow;
    }

    return _interceptedResponse(
      response,
      triggerLoader: triggerLoader,
    );
  }

  Future<dynamic> postMultipart(
    String url, {
    required Map<String, String> body,
    required Map<String, File?>? files,
    Map<String, String> headers = const <String, String>{},
    Map<String, String> parameters = const <String, String>{},
    bool triggerLoader = true,
  }) async {
    Response response;
    _loadingSpinnerService.push(silent: !triggerLoader);
    Uri uri = _getApiUri(
      url,
      queryParameters: parameters,
    );

    try {
      MultipartRequest multipartRequest = MultipartRequest("POST", uri);
      multipartRequest.fields.addAll(body);
      if (files != null && files.isNotEmpty) {
        for (var element in files.entries) {
          String key = element.key;
          File? file = element.value;
          if (file != null && key.isNotEmpty) {
            multipartRequest.files
                .add(await MultipartFile.fromPath(key, file.path));
          }
        }
      }
      multipartRequest.headers.addAll(headers);
      StreamedResponse res = await _httpClient.send(multipartRequest);
      response = await Response.fromStream(res);
    } on SocketException {
      _loadingSpinnerService.pop(silent: !triggerLoader);
      throw NoInternetException('No Internet connection');
    } catch (e) {
      _loadingSpinnerService.pop(silent: !triggerLoader);
      rethrow;
    }

    return _interceptedResponse(
      response,
      triggerLoader: triggerLoader,
    );
  }

  Future<dynamic> put(
    String url, {
    required Object body,
    Map<String, String> headers = const <String, String>{},
    Map<String, String> parameters = const <String, String>{},
    bool triggerLoader = true,
  }) async {
    Response response;
    _loadingSpinnerService.push(silent: !triggerLoader);
    Uri uri = _getApiUri(
      url,
      queryParameters: parameters,
    );

    try {
      response = await _httpClient.put(
        uri,
        body: body,
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        }..addAll(headers),
      );
    } on SocketException {
      _loadingSpinnerService.pop(silent: !triggerLoader);
      throw NoInternetException('No Internet connection');
    } catch (e) {
      _loadingSpinnerService.pop(silent: !triggerLoader);
      rethrow;
    }

    return _interceptedResponse(
      response,
      triggerLoader: triggerLoader,
    );
  }

  Future<dynamic> delete(
    String url, {
    Object body = const <Object>{},
    Map<String, String> headers = const <String, String>{},
    bool triggerLoader = true,
  }) async {
    Response response;
    Uri uri = _getApiUri(
      url,
    );

    try {
      response = await _httpClient.delete(
        uri,
        body: body,
        headers: headers,
      );
    } on SocketException {
      _loadingSpinnerService.pop(silent: !triggerLoader);
      throw NoInternetException('No Internet connection');
    } catch (e) {
      _loadingSpinnerService.pop(silent: !triggerLoader);
      rethrow;
    }

    return _interceptedResponse(
      response,
      triggerLoader: triggerLoader,
    );
  }

  HttpProvider._internal();
}
