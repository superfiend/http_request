library http_request;

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:gbk2utf8/gbk2utf8.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

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

    static Future<bool> download(String url, String savePath,
        {Map<String, dynamic> headers, Map<String, dynamic> queryParameters}) async {
        final options = BaseOptions(headers: headers);
        return Dio(options).download(url, savePath, queryParameters: queryParameters).then((_) {
            return true;
        }).catchError((error) {
            print('发生错误, error: $error');
            return false;
        });
    }

    /// 下载到手机设备
    static Future<bool> downloadToMobile(String url, String savePath,
        {Map<String, dynamic> headers, Map<String, dynamic> queryParameters}) async {
        return download(url,
            '/storage/emulated/0${savePath.startsWith('/') ? savePath : '/$savePath'}',
            headers: headers,
            queryParameters: queryParameters);
    }

    static Future<Uint8List> getBodyBytes(String url, { Map<String, dynamic> headers }) async {
        return http.get(url, headers: headers).then((res) {
            return res.bodyBytes;
        });
    }

    static Future<Uint8List> postBodyBytes(String url,
        {FormData data, Map<String, dynamic> headers }) async {
        return http.post(url, headers: headers, body: data).then((res) {
            return res.bodyBytes;
        });
    }

    /// 从gbk的网页, 返回utf-8的内容
    static Future<String> getFromGbkHtml(String url, { Map<String, dynamic> headers }) async {
        return getBodyBytes(url, headers: headers).then((bodyBytes) {
            return gbk.decode(bodyBytes);
        });
    }

    /// 从gbk的网页, 返回utf-8的内容
    static Future<String> postFromGbkHtml(String url,
        {FormData data, Map<String, dynamic> headers }) async {
        return getBodyBytes(url, headers: headers).then((bodyBytes) {
            return gbk.decode(bodyBytes);
        });
    }

    /// 返回html文档对象
    static Future<Document> getDocument(String url,
        {Map<String, dynamic> headers, Map<String, dynamic> queryParameters}) async {
        return get(url, headers: headers, queryParameters: queryParameters).then((html) {
            return parse(html);
        });
    }

    /// 返回html文档对象
    static Future<Document> postDocument(String url,
        {FormData data, Map<String, dynamic> headers, Map<String, dynamic> queryParameters}) async {
        return post(url, data: data, headers: headers, queryParameters: queryParameters).then((
            html) {
            return parse(html);
        });
    }

    /// 返回html文档对象
    static Future<Document> getDocumentFromGbkHtml(String url,
        {Map<String, dynamic> headers}) async {
        return getFromGbkHtml(url, headers: headers).then((html) {
            return parse(html);
        });
    }

    /// 返回html文档对象
    static Future<Document> postDocumentFromGbkHtml(String url,
        {FormData data, Map<String, dynamic> headers }) async {
        return postFromGbkHtml(url, headers: headers, data: data).then((html) {
            return parse(html);
        });
    }
}
