import 'dart:convert';

import 'package:http/http.dart';
import 'package:notificaciones_unifront_app/app/core/utils/helpers/http/http.dart';

Future<Response> sendRequest(
    {required Uri url,
    required HttpMethod method,
    required Map<String, String> headers,
    required dynamic body,
    required Duration timeOut}) {
  var finalHeader = {...headers};
  if (method != HttpMethod.get) {
      finalHeader['Content-Type'] = 'application/x-www-form-urlencoded';
      body = body;
  }
  final client = Client();
  switch (method) {
    case HttpMethod.get:
      return client.get(url, headers: finalHeader).timeout(timeOut);
    case HttpMethod.post:
      return client
          .post(url,
              headers: finalHeader,
              encoding: Encoding.getByName('utf-8'),
              body: body)
          .timeout(timeOut);
    case HttpMethod.put:
      return client
          .put(url,
              headers: finalHeader,
              encoding: Encoding.getByName('utf-8'),
              body: body)
          .timeout(timeOut);
    case HttpMethod.patch:
      return client
          .patch(url,
              headers: finalHeader,
              encoding: Encoding.getByName('utf-8'),
              body: body)
          .timeout(timeOut);
    case HttpMethod.delete:
      return client
          .delete(url,
              headers: finalHeader,
              encoding: Encoding.getByName('utf-8'),
              body: body)
          .timeout(timeOut);
  }
}
