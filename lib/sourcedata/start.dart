import 'package:flutter_app/utils/httpUtils.dart';
import 'package:flutter_app/sourcedata/api.dart';
import 'package:flutter_app/entity/BaseEntity.dart';

class StartDataSource {

  static getLoginBool() async {

  }

  static getCode(Map<String, String> params) async {
    var response = await HttpUtils.post(Api.getAuthCode, params);
    return response;
  }

  static getUserInfo(Map<String, String> params) async {
    return await HttpUtils.post(Api.getAuthCode, params);
  }

  static loginByAuthCode(Map<String, String> params) async {
    return await HttpUtils.post(Api.loginByAuthCode, params);
  }
}