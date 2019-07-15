import 'package:dio/dio.dart';
import 'package:package_info/package_info.dart';

class HttpUtils {

  static Dio dio;

  static void init() async {
    Map<String, dynamic> optHeader = {
      'accept-language': 'zh-cn',
      'content-type': 'application/json',
      'signValue': '111',
    };
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var commonMap = {
      'OSType': 'android',
      'validate_ts': DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),
      'versionCode': packageInfo.version,
      'versionName': packageInfo.appName,
    };
    dio = new Dio(BaseOptions(connectTimeout: 30000,
        headers: optHeader,
        baseUrl: 'http://dev.yw.yimilan.com/'),);
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          print("onRequest");
          //公共参数
          var map = (options.data ??= Map());

          map.addAll(commonMap);
          return options;
        },
        onResponse: (Response e) {
          print("onResponse");
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