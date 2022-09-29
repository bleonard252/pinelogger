import 'messages.dart';
import 'class.dart';

/// Prints to the console in a simple yet readable format.
///
/// Example output:
/// ```text
/// 02:00:00.000 [Pinelogger.Nested/INFO] This is a log message
/// ```
void consolePrinter(PinelogMessage message) {
  String timestamp() {
    return '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}:${message.timestamp.second.toString().padLeft(2, '0')}.${message.timestamp.millisecond.toString().padLeft(3, '0')}';
  }
  // ignore: avoid_print
  return print("${timestamp()} [${message.logger.name}/${message.severity.name}] ${message.message.toString()}");
}

class MultiPrinter {
  final List<PinelogPrinter> printers;

  MultiPrinter(this.printers);

  /// The [call] method allows you to "call" the [MultiPrinter] as if it were a function.
  /// This way, the following works:
  /// ```
  /// PineLogger logger = PineLogger('MyLogger', printer: MultiPrinter([printer1, printer2]));
  /// ```
  void call(PinelogMessage message) {
    for (final printer in printers) {
      printer(message);
    }
  }
}