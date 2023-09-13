

abstract class Failure {}

// General failures
class ServerFailure extends Failure {
  final String error;
  final String message;
  final int code;

  ServerFailure({
    required this.error,
    required this.code,
    required this.message,
  });
}

class CacheFailure extends Failure {}

String mapFailureToError(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return (failure as ServerFailure).error.toString();
    case CacheFailure:
      return "ConstantsManger.cacheFailureMessage";
    default:
      return 'Unexpected error';
  }
}

int mapFailureToCode(Failure failure) => (failure as ServerFailure).code;

String mapFailureToMessage(Failure failure) =>
    (failure as ServerFailure).message;
