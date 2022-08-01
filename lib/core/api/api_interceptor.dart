// ignore_for_file: avoid_print

import 'package:cloudwalktest/core/api/i_api_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class HttpClient extends IHttpClient implements InterceptorContract {
  late InterceptedClient _client;

  HttpClient() {
    _client = InterceptedClient.build(interceptors: [this]);
  }

  @override
  Future<Response> get(String? endpoint, {Map<String, dynamic>? headers}) async {
    final response = await _client.get(endpoint!.toUri(), headers: {
      'Content-Type': 'application/json',
    });
    return response;
  }

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers['Content-Type'] = 'application/json';
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('Response ${data.url}');
    print('Response ${data.statusCode}');
    print('Response ${data.headers}');
    print('Response ${data.body}');

    return data;
  }
}
