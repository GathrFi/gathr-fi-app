/// Utility class to wrap result data.
sealed class Result<T> {
  const Result();

  /// Create a successful [Result], completed with the specified [value].
  factory Result.ok(T value) = Ok._;

  /// Create an error [Result], completed with the specified [error].
  factory Result.error(Exception error) = Error._;
}

/// Subclass of Result for values.
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  /// Return value in result.
  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// Subclass of Result for errors.
final class Error<T> extends Result<T> {
  const Error._(this.error);

  /// Return error in result.
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}

/// App level exception, provide a clear message without technical terms.
final class AppException implements Exception {
  const AppException([this.message = 'Something went wrong']);
  final String message;

  @override
  String toString() => message;
}
