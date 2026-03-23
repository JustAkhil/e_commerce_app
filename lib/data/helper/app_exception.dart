class AppExceptions implements Exception {
  String title;
  String msg;

  AppExceptions({required this.title, required this.msg});

  @override
  String toString() => '$title: $msg}';
}

class NoInternetException extends AppExceptions {
  NoInternetException({required String msg})
    : super(title: "No Internet", msg: msg);
}

class BadRequestException extends AppExceptions {
  BadRequestException({required String msg})
    : super(title: "Bad Request", msg: msg);
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException({required String msg})
    : super(title: "Unauthorized", msg: msg);
}

class InvalidInputException extends AppExceptions {
  InvalidInputException({required String msg})
    : super(title: "Invalid Input", msg: msg);
}
class FetchDataException extends AppExceptions {
  FetchDataException({required String msg})
    : super(title: "Error During Communication", msg: msg);
}
class ServerException extends AppExceptions {
  ServerException({required String msg})
    : super(title: "Internal Server Error", msg: msg);
}