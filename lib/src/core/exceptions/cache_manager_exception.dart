abstract class AutoCacheManagerException implements Exception {
  final String message;
  final StackTrace stackTrace;
  final String errorCode;

  AutoCacheManagerException({
    required this.message,
    StackTrace? stackTrace,
    required this.errorCode,
  }) : stackTrace = stackTrace ?? StackTrace.current;
}
