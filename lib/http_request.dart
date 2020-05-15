library http_request;

import 'dart:convert';

import 'package:dio/dio.dart';

// dio的请求简单封装类
class HttpRequest {

    HttpRequest._(); // 私有化构造函数

    static Future<String> get(String url,
        {Map<String, dynamic> headers, Map<String, dynamic> queryParameters}) async {
        final options = BaseOptions(headers: headers);
        return Dio(options).get(url, queryParameters: queryParameters).then((res) {
            return res.toString();
        });
    }

    static Future<Map<String, dynamic>> getJson(String url,
        {Map<String, dynamic> headers, Map<String, dynamic> queryParameters}) async {
        return get(url, headers: headers, queryParameters: queryParameters).then((res) {
            return json.decode(res);
        });
    }

    static Future<String> post(String url,
        {FormData data, Map<String, dynamic> headers, Map<String, dynamic> queryParameters}) async {
        final options = BaseOptions(headers: headers);
        return Dio(options).post(url, data: data, queryParameters: queryParameters).then((res) {
            return res.toString();
        });
    }

    static Future<Map<String, dynamic>> postJson(String url,
        {FormData data, Map<String, dynamic> headers, Map<String, dynamic> queryParameters}) async {
        return post(url, data: data, headers: headers, queryParameters: queryParameters).then((
            res) {
            return json.decode(res);
        });
    }
}
