import 'package:dio/dio.dart';
import 'package:make_something/utils/logging.dart';
import '../../auth/auth_scope.dart';
import 'package:make_something/utils/constants.dart';

Dio dio = Dio(BaseOptions(baseUrl: "$API_URL/api"))
..interceptors.addAll([AuthInterceptor()]);

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {

    // // create a list of the endpoints where you don't need to pass a token.
    final listOfPaths = <String>[
      '/token'
    ];

    // Check if the requested endpoint match in the
    if (listOfPaths.contains(options.path.toString())) {
      // if the endpoint is matched then skip adding the token.
      return handler.next(options);
    }

    // Load your token here and pass to the header
    String? token = await StreamAuth.getToken();
    options.headers.addAll({'Authorization':  "Bearer $token"});
    return handler.next(options);
  }

  // You can also perform some actions in the response or onError.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}