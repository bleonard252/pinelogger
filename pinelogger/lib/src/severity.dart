/// The severity of a log message or event.
class Severity {
  final String name;
  /// A lower number means a higher severity.
  /// * 2000 indicates no filtering (so all messages are shown).
  /// * 0 indicates that absolutely nothing is shown.
  final int index;
  const Severity(this.index, this.name) : assert(index > 0), assert(name != ""), assert(index < 2000);
  /// For filters. Show all messages.
  const Severity.all() : this.index = 2000, this.name = "ALL";
  /// For filters. Show no messages.
  const Severity.none() : this.index = 0, this.name = "NONE";
  /// Verbose messages are detailed and are shown at every step of a process.
  /// They're most useful for debugging.
  static const Severity verbose = Severity(10, "verbose");
  /// Debug messages indicate when a fallback behavior is being used, or
  /// anything similar that is not detailed, but is still useful for debugging.
  static const Severity debug = Severity(9, "debug");
  /// Info messages should be used for important status events that are expected,
  /// such as the user logging in (if it is a client), the server starting up,
  /// or connecting to a database.
  static const Severity info = Severity(8, "info");
  /// Warning messages should be used for events that are unexpected, but not
  /// necessarily an error. For example, a user logging in with the wrong
  /// password, or a server failing to connect to a database.
  ///
  /// Warnings are for RECOVERABLE events, and the warning message should indicate
  /// what fallback is being taken.
  static const Severity warning = Severity(7, "warning");
  /// Error messages should be used for events that are unexpected and
  /// unrecoverable, such as a server failing to start up, network errors, or
  /// unaccounted-for exceptions such as unfamilar HTTP status codes.
  /// These are not necessarily fatal but they will restrict the usage of the
  /// application, and the user should be notified.
  static const Severity error = Severity(6, "error");
  static const values = [verbose, debug, info, warning, error];

  /// The name and index are checked for equality. If either one matches, it is
  /// considered an equal severity.
  bool operator ==(Object other) => other is Severity && (other.name.toLowerCase() == name.toLowerCase() || other.index == index);
  /// Compares severity, not index.
  bool operator <(Severity other) => index > other.index;
  /// Compares severity, not index.
  bool operator <=(Severity other) => index >= other.index;
  /// Compares severity, not index.
  bool operator >(Severity other) => index < other.index;
  /// Compares severity, not index.
  bool operator >=(Severity other) => index <= other.index;
}