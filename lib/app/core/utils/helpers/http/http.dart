
import 'package:notificaciones_unifront_app/app/core/utils/helpers/http/http_result.dart';
import 'package:notificaciones_unifront_app/app/core/utils/helpers/http/parse_response.dart';
import 'package:notificaciones_unifront_app/app/core/utils/helpers/http/send_request.dart';

enum HttpMethod { get, post, put, patch, delete }

typedef Parser<T> = T Function(dynamic data);

class Http {
  final String baseUrl;

  Http({this.baseUrl = 'http://192.168.0.107/api-notifi/public/api/'});

  Future<HttpResult<T>> request<T>(String path,
      {HttpMethod method = HttpMethod.get,
      Map<String, String> headers = const {},
      Map<String, dynamic> queryParameters = const {},
      dynamic body,
      Parser<T>? parser,
      Duration timeOut = const Duration(seconds: 10)}) async {
    int? statusCode;
    dynamic data;
    try {
      late Uri url;
      if (path.startsWith('http://') || path.startsWith('https://')) {
        url = Uri.parse(path);
      } else {
        url = Uri.parse('$baseUrl$path');
        if (queryParameters.isNotEmpty) {
          url = url.replace(
              queryParameters: {...url.queryParameters, ...queryParameters});
        }
      }

      final response = await sendRequest(
          url: url,
          method: method,
          headers: headers,
          body: body,
          timeOut: timeOut);
      data = parseResponseBody(response.body);
      statusCode = response.statusCode;
      if (statusCode >= 400) {
        throw HttpError(
            exception: null, stackTrace: StackTrace.current, data: data);
      }
      return HttpResult<T>(
          data: parser != null ? parser(data) : data,
          statusCode: statusCode,
          error: null);
    } catch (e, s) {
      if (e is HttpError) {
        return HttpResult<T>(data: null, statusCode: statusCode!, error: e);
      }
      return HttpResult<T>(
          data: null,
          statusCode: -1,
          error: HttpError(exception: e, stackTrace: s, data: data));
    }
  }
}
