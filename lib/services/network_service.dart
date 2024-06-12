import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flow_sync/constants/api_constants.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/model/section_model.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'dart:developer' as dev;
import '../constants/custom_types.dart';
import '../features/dashboard/model/comment_model.dart';
import '../features/dashboard/model/task_model.dart';

class NetworkService {
  final _dio = Dio();

  Future<List<Project>> getAllProjects() async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.getAUsersProject.getUrl()}";
    final response = await _dio.get(requestUrl,
        options: Options(headers: ApiConstants.authHeader));
    return parseProjects(response.data);
  }

  Future<List<Task>> getAllActiveTasks() async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.getActiveTasks.getUrl()}";
    final response = await _dio.get(requestUrl,
        options: Options(headers: ApiConstants.authHeader));
    return parseTasks(response.data);
  }

  Future<List<Comment>> getCommentByTaskId({required String taskId}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.getAllComments.getUrl()}?task_id=$taskId";
    final response = await _dio.get(requestUrl,
        options: Options(headers: ApiConstants.authHeader));
    dev.log(response.data);
    return parseComments(response.data);
  }

  Future<List<Label>> getAllPersonalLabels() async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.getAllPersonalLabels.getUrl()}";
    final response = await _dio.get(requestUrl,
        options: Options(headers: ApiConstants.authHeader));
    return parseLabels(response.data);
  }

  Future<List<Section>> getAllSectionsOfProjectById(
      {required String projectId}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.getAllSections.getUrl()}?project_id=$projectId";
    final response = await _dio.get(requestUrl,
        options: Options(headers: ApiConstants.authHeader));
    return parseSections(response.data);
  }

  Future<void> createNewProject({required Project projectModel}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.addANewProject}";
    try {
      final response = await _dio.post(
        requestUrl,
        options: Options(headers: ApiConstants.authHeader),
        data: projectModel.toJson(),
      );

      // Handle different response statuses
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          dev.log('Project created successfully');
          break;
        case 400:
          dev.log('Bad request');
          break;
        case 401:
          dev.log('Unauthorized');
          break;
        case 403:
          dev.log('Forbidden');
          break;
        case 404:
          dev.log('Not found');
          break;
        case 429:
          dev.log('Too many requests');
          break;
        case 500:
        case 502:
        case 503:
        case 504:
          dev.log('Server error');
          break;
        default:
          dev.log('Unexpected error: ${response.statusCode}');
      }
    } on DioError catch (dioError) {
      // Handle Dio errors
      if (dioError.response != null) {
        dev.log('Dio error! Status: ${dioError.response?.statusCode}');
        dev.log('Data: ${dioError.response?.data}');
        dev.log('Headers: ${dioError.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        dev.log('Error sending request!');
        dev.log(dioError.message.toString());
      }
    } catch (e) {
      // Handle other errors
      dev.log('Unexpected error: $e');
    }
  }
}
