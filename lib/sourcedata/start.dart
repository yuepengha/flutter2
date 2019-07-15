import 'package:flutter_app/utils/httpUtils.dart';
import 'package:flutter_app/sourcedata/api.dart';

class StartDataSource {

  static getLoginBool() async {

  }

  static getCode(Map<String, String> params) async {
    return await HttpUtils.post(Api.getAuthCode, params);
  }
}