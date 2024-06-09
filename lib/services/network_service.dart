import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flow_sync/constants/api_constants.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/comment_model.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';

import '../constants/custom_types.dart';

class NetworkService {
  final _dio = Dio();

/*  void getHttp() async {
    final response = await dio.get('https://dart.dev');
    print(response);
  }*/

/*  Future<List<T>> makeARequest<T>(
      {required ApiType apiType,
      Map<String, dynamic>? requestBody,
      Map<String, dynamic>? requestHeaders,
      String? queryParams}) async {
    late String requestUrl;
    late Response response;

    if (T == List<Project>) {
      requestUrl = "${ApiConstants.baseUrl}${apiType.getUrl()}";
      response = await _dio.get(requestUrl,
          options: Options(
            headers: requestHeaders ?? ApiConstants.authHeader,
          ));
      return data
          .map((item) => Project.fromJson(item as Map<String, dynamic>))
          .toList() as List<T>;
    } else if (T == List<Label>) {
      requestUrl = "${ApiConstants.baseUrl}${apiType.getUrl()}";
      response = await _dio.get(requestUrl,
          options: Options(
            headers: requestHeaders ?? ApiConstants.authHeader,
          ));
      return data
          .map((item) => Label.fromJson(item as Map<String, dynamic>))
          .toList() as List<T>;
    } else if (T == List<Comment>) {
      requestUrl = "${ApiConstants.baseUrl}${apiType.getUrl()}$queryParams";
      response = await _dio.get(requestUrl,
          options: Options(
            headers: requestHeaders ?? ApiConstants.authHeader,
          ));
      final data = response as List<Comment>;

      return data
          .map((item) => Comment.fromJson(item as Map<String, dynamic>))
          .toList() as List<T>;
    } else {
      throw ArgumentError('Type not supported');
    }
  }*/

  Future<List<Project>> getAllProjects() async{
    final String requestUrl = "${ApiConstants.baseUrl}${ApiType.getAUsersProject.getUrl()}";
    final response = await _dio.get(requestUrl,options: Options(headers: ApiConstants.authHeader));
    return parseProjects(response.data);
  }
}

