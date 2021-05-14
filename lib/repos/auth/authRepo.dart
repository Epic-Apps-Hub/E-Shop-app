import 'package:dio/dio.dart';
import 'package:shop_app/constants.dart';

abstract class AuthenticationRepo {
  login(String email, String password);
  signup(String name, String email, String password);
  checkAuth(String jwt);
}

class Authenticate extends AuthenticationRepo {
  @override
  login(String email, String password) async {
    try {
      Response res = await Dio().post("$baseUrl/auth/login",
          data: {"email": email, "password": password});

      return res.data;
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return errorMessage;
    }
  }

  @override
  signup(String name, String email, String password) async {
    try {
      Response res = await Dio().post(
        '$baseUrl/auth/register',
        data: {"name": name, "email": email, "password": password},
      );

      return res.data;
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return errorMessage;
    }
  }

  @override
  checkAuth(String jwt) async {
    try {
      Response res = await Dio().get('$baseUrl/auth/me',
          options: Options(headers: {"Authorization": 'Bearer $jwt'}));
      return res.data;
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return errorMessage;
    }
  }
}

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        if (dioError.response.data['error'] ==
            'duplicate field value entered') {
          message = _handleError(
              dioError.response.statusCode,
              dioError.response.data['error'] +
                  ': Enter Deffirent Email or name');
        } else {
          message = _handleError(
              dioError.response.statusCode, dioError.response.data['error']);
        }
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String message;

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request: $error';
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
