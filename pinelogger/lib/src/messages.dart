import 'package:pinelogger/src/class.dart';

import 'severity.dart';

class PinelogMessage {
  final Pinelogger logger;
  final dynamic message;
  final Severity severity;
  final DateTime timestamp;
  final PinelogExtraData? extraData;
  final StackTrace? stackTrace;
  final Object? error;
  Object? get object => error;

  PinelogMessage(this.logger, {
    required this.message,
    required this.severity,
    required this.timestamp,
    this.extraData,
    this.stackTrace,
    this.error,
  });

  PinelogMessage.fromJson(this.logger, Map<String, dynamic> json) :
    message = json['message'],
    severity = Severity.values[json['severity']],
    timestamp = json['timestamp'],
    extraData = json['extraData'],
    stackTrace = json['stackTrace'],
    error = json['error'];

  Map<String, dynamic> toJson() => {
    'message': message,
    'severity': severity.index,
    'timestamp': timestamp,
    'extraData': extraData,
    'stackTrace': stackTrace,
    'error': error,
  };
}
/// Implement or extend this class to create something that holds extra data, which
/// may be useful to you when showing logs.
/// It isn't used for the console printer.
abstract class PinelogExtraData {}