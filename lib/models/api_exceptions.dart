class ApiException implements Exception {
  final String message;
  final int? code;

  ApiException(this.message, [this.code]);

  @override
  String toString() {
    if (code != null) {
      return 'ApiException: $message (code: $code)';
    }
    else {
      return 'ApiException: $message';
    }
  }
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message, 401);
}

class PaymentRequiredException extends ApiException {
  PaymentRequiredException(String message) : super(message, 402);
}

class UnprocessableContentException extends ApiException {
  UnprocessableContentException(String message) : super(message, 422);
}

class TooManyRequestsException extends ApiException {
  TooManyRequestsException(String message) : super(message, 429);
}