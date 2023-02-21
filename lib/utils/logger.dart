import 'dart:developer' as dev;

import 'package:dio/dio.dart';

class AppLog {
  factory AppLog() => _instance;

  AppLog._();

  static final _instance = AppLog._();

  static void log(
    dynamic error, [
    StackTrace? stackTrace,
  ]) {
    if (error is DioError) {
      dev.log(
        error.parameters,
        name: 'Network',
        error: error,
      );
    } else if (error is String) {
      dev.log(error);
    } else {
      dev.log(
        'Error: ',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static verbose(
    dynamic data, {
    int indents = 0,
    String? label,
    String? title,
  }) {
    if (title != null) {
      final dashes = String.fromCharCodes(
        List.filled(indents + 40, 0x2D),
      );
      log('\n$title $dashes');
    }
    final nbspShort = String.fromCharCodes(
      List.filled(indents + 2, 0x00A0),
    );

    if (data is Map) {
      if (indents == 0) {
        log('$nbspShort{ ');
      } else {
        log('$nbspShort${label ?? ''} { ');
      }
      for (final entry in data.entries) {
        verbose(
          entry.value,
          label: entry.key,
          indents: indents + 2,
        );
      }
      log('$nbspShort}');
    } else if (data is List) {
      log('$nbspShort$label [ ');
      for (final item in data) {
        verbose(item, indents: indents + 4);
      }
      log('$nbspShort]');
    } else {
      log('$nbspShort$label: ${data.runtimeType} ‣ $data');
    }
  }

  static void dioResponse(Response response) {
    log(
      '********'
      '\n${response.requestOptions.method} ${response.requestOptions.baseUrl}${response.requestOptions.path}'
      '\nrealUri: ${response.realUri}'
      '\nparamaters: ${response.requestOptions.queryParameters}'
      '\ndata: ${response.requestOptions.data}'
      '\nstatusCode : ${response.statusCode}'
      '\nstatusMessage : ${response.statusMessage}'
      '\n********',
    );
  }
}

extension DioErrorUtils on DioError {
  String get parameters {
    var output = message ?? '';
    if (response?.statusMessage != null) {
      output += ' - ${response?.statusMessage}';
    }
    output += '\nData: ${response?.data.toString().firstLines}';
    output += ' \nMethod : ${requestOptions.method} ${response?.realUri}';
    final nbsp = String.fromCharCodes(List.filled(4, 0x00A0));
    if (requestOptions.method != 'get') {
      output += '\nParameters:\n$nbsp${requestOptions.data}';
    }
    return output;
  }
}

extension _StringUtils on String {
  String get firstLines {
    final amount = length > 350 ? 350 : length;
    return substring(0, amount);
  }
}
