
abstract class Failures{
  String errorMessage ;
  Failures({required this.errorMessage});
}

class NetworkError extends Failures{
  NetworkError({required super.errorMessage});
}
class ServerError extends Failures{
  ServerError({required super.errorMessage});
}

class CachedError extends Failures{
  CachedError({required super.errorMessage});
}

