import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:package_info/package_info.dart';

class HttpUtils {

  static Dio dio;

  static void init() async {
    Map<String, dynamic> optHeader = {
      'signValue': 'D5DC6DADF7BFE8FE99F546B55A4BAFD01F14369F',
      'Cookie': 'token=',
    };

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    var commonMap = {
      'OSType': 'android',
//      'validate_ts': DateTime
//          .now()
//          .millisecondsSinceEpoch
//          .toString(),
      'validate_ts': "1563619052311",
      'versionCode': "9",
      'versionName': "1.7.0",
    };
    dio = new Dio(BaseOptions(connectTimeout: 30000,
        headers: optHeader,
        contentType: ContentType.parse("application/x-www-form-urlencoded"),
        baseUrl: ''),);
    // 设置代理 便于本地 charles 抓包
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        return "PROXY 192.168.43.65:8888";
      };
    };
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          //公共参数
          var map = (options.data ??= Map());

          map.addAll(commonMap);

          return options;
        },
        onResponse: (Response e) {
          return e;
        },
        onError: (DioError e) {
          return e;
        }
    ));
    dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true)); //开启请求日志
  }

  static Future post(String url, Map<String, dynamic> params) async {
    var response = await dio.post(url, data: params);
    return response.data;
  }


}