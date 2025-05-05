class AppException implements Exception {
  final String? _message;
  final String? _des;
  final int? _code;

  AppException([this._message, this._des, this._code]);

  @override
  String toString() {
    return _message ?? "";
  }

  get prefix => _des;

  get message => _message;

  get code => _code;
}

class FetchDataException extends AppException {
  FetchDataException([message, code])
      : super(message, "Error During Communication: ", code);
}

class BadRequestException extends AppException {
  BadRequestException([message, code])
      : super(message, "Invalid Request: ", code);
}

class NoDataException extends AppException {
  NoDataException([message, code]) : super(message, "No Content: ", code);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message, code])
      : super(message, "Unauthorised: ", code);
}

class InvalidInputException extends AppException {
  InvalidInputException([message, code])
      : super(message, "Invalid Input: ", code);
}

class InvalidUrlException extends AppException {
  InvalidUrlException([message, code]) : super(message, "Invalid URL: ", code);
}

class ErrorParsingException extends AppException {
  ErrorParsingException([message, code])
      : super(message, "Error Parsing", code);
}

class TimeOutException extends AppException {
  TimeOutException([message, code]) : super(message, "TimeOut", code);
}