import 'package:dio/dio.dart';


Map<String, dynamic> optHeader = {
  'accept-language': 'zh-cn',
  'content-type': 'application/json'
};

var dio = new Dio(BaseOptions(connectTimeout: 30000,

    headers: optHeader,
    baseUrl: ''));

class HttpUtils {
  static Future post(String url, Map<String, dynamic> params) async {
    dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true)); //开启请求日志
    var response = await dio.post(url, data: params);
    return response.data;
  }
}