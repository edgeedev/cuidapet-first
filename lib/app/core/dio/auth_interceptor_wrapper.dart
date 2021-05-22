import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class AuthInterceptorWrapper extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (DotEnv.env['profile'] == 'dev') {
      print('########### Request Log ###########');
      print('REQUEST[${options.method}] => PATH: ${options.path}');
      return super.onRequest(options, handler);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (DotEnv.env['profile'] == 'dev') {
      print('########### Response Log ###########');
      print('data ${response.data}');
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('########### On Error ###########');
    print('error: ${err.response.data}');
    // Verificar se deu erro 403 ou 401 fazer o refreshn do token
    return super.onError(err, handler);
  }
}
