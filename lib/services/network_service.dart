import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flow_sync/constants/api_constants.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/model/section_model.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';

import '../constants/custom_types.dart';
import '../features/dashboard/model/comment_model.dart';
import '../features/dashboard/model/task_model.dart';

class NetworkService {
  final _dio = Dio();

  Future<List<Project>> getAllProjects() async{
    final String requestUrl = "${ApiConstants.baseUrl}${ApiType.getAUsersProject.getUrl()}";
    final response = await _dio.get(requestUrl,options: Options(headers: ApiConstants.authHeader));
    return parseProjects(response.data);
  }

  Future<List<Task>> getAllActiveTasks() async{
    final String requestUrl = "${ApiConstants.baseUrl}${ApiType.getActiveTasks.getUrl()}";
    final response = await _dio.get(requestUrl,options: Options(headers: ApiConstants.authHeader));
    return parseTasks(response.data);
  }

  Future<List<Comment>> getCommentByTaskId({required String taskId}) async{
    final String requestUrl = "${ApiConstants.baseUrl}${ApiType.getAllComments.getUrl()}?task_id=$taskId";
    final response = await _dio.get(requestUrl,options: Options(headers: ApiConstants.authHeader));
    print(response.data);
    return parseComments(response.data);
  }

  Future<List<Label>> getAllPersonalLabels() async{
    final String requestUrl = "${ApiConstants.baseUrl}${ApiType.getAllPersonalLabels.getUrl()}";
    final response = await _dio.get(requestUrl,options: Options(headers: ApiConstants.authHeader));
    return parseLabels(response.data);
  }

  Future<List<Section>> getAllSectionsOfProjectById({required String projectId}) async{
    final String requestUrl = "${ApiConstants.baseUrl}${ApiType.getAllSections.getUrl()}?project_id=$projectId";
    final response = await _dio.get(requestUrl,options: Options(headers: ApiConstants.authHeader));
    return parseSections(response.data);
  }
}

