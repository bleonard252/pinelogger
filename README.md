# Pinelogger
Pretty similar to something else but it works in less mysterious ways.

## Installation
Run a command and not have to copy versions:
```sh
# substitute dart for flutter below if you want
dart pub add pinelogger
# optional:
dart pub add pinelogger_flutter # adds debug/release, fancy loggers, and BuildContext helpers
```

Or, if you prefer, add this under `dependencies:` in pubspec.yaml:
```yaml
  pinelogger: ^1.0.0
  # optional:
  pinelogger_flutter: ^1.0.0
```

If you're using `pinelogger_flutter`, you also want to do this in `main`:
```dart
final logger = Pinelogger("app", severity: Severity.warn, printer: flutterLogger);
runApp(PineloggerContext(logger: logger, child: MyApp()));
  // Notice the PineloggerContext!
```

## Usage
Use from `context` in a widget (with `pinelogger_flutter`):
```dart
Widget build(BuildContext context) {
  context.logDebug("Building this widget!");
  return Container(); // well, use some content here of course
}
/*
This will output:
[client.WidgetName] Building this widget!
*/
```

A non-Flutter example use case:
```dart
Future<bool> login(String username, String password) async {
  final logger = this.logger.child("login");
  late final Response response;
  logger.debug("Starting login.");
  try {
    response = tryLoginRequest(username, password);
    token = response.json()['access_token'];
  } catch(e) {
    logger.error("An error occurred while attempting to log in.", error: e);
    return false;
  }
  logger.debug("Connecting to the server.");
  try {
    connect();
  } catch(e) {
    logger.error("Could not connect to the server.", error: e);
    return false;
  }
  logger.info("Logged in successfully.");
  return true;
}
```

Support for multiple printers at once (use them in the `printer` field), and debug/release only printers:
```dart
MultiPrinter([DebugOnlyPrinter(flutterPrinter), consolePrinter])
```

Five log levels are defined by default, and only "info" and more severe are printed by default:
* verbose
* debug
* info
* warning
* error

## Extensibility
To implement new log levels (severities):
```dart
extension SocketSeverity on Severity {
  static const socket = Severity("Socket message", 40);
}
extension SocketSeverityPinelogger on Pinelogger {
  socket(dynamic message, {PineloggerExtraData extraData, Object? error, StackTrace? stackTrace}) => log(message, severity: Severity.socket, error: error, stackTrace: stackTrace, extraData: extraData);
}
```

To implement a printer:
```dart
void customPrinter(PinelogMessage message) {
  // whatever you want to do here
  print(message.message.toString());
}
Pinelogger("name", printer: customPrinter);

// OR, if you want to accept parameters:

class PrefixPrinter {
  /// Prefixes everything with this.
  final String prefix;
  PrefixPrinter(this.prefix);
  /// Note the use of `call`. This makes it look so much prettier.
  /// You can definitely get away with `.print`,
  /// and use it like
  /// `Pinelogger("name", printer: PrefixPrinter().print)`
  void call(PinelogMessage message) {
    print(prefix+message);
  }
}
```