import 'package:test_task/domain/exceptions/app_exception.dart';

class ApiException extends AppException {
  final String statusCode;

  const ApiException({
    required this.statusCode,
    super.message,
  });
}
