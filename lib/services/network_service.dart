import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flow_sync/constants/api_constants.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/model/section_model.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/global_widgets/app_popups.dart';
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
    return parseComments(response.data);
  }

  Future<List<Comment>> getCommentByProjectId(
      {required String projectId}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.getAllComments.getUrl()}?project_id=$projectId";
    final response = await _dio.get(requestUrl,
        options: Options(headers: ApiConstants.authHeader));
    return parseComments(response.data);
  }

  Future<List<Label>> getAllPersonalLabels() async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.getAllPersonalLabels.getUrl()}";
    final response = await _dio.get(requestUrl,
        options: Options(headers: ApiConstants.authHeader));
    return parseLabels(response.data);
  }

  Future<List<Section>> getAllSections() async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.getAllSections.getUrl()}";
    final response = await _dio.get(requestUrl,
        options: Options(headers: ApiConstants.authHeader));
    return parseSections(response.data);
  }

  Future<List<Section>> getAllSectionsOfProjectById(
      {required String projectId}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.getAllSections.getUrl()}?project_id=$projectId";
    final response = await _dio.get(requestUrl,
        options: Options(headers: ApiConstants.authHeader));
    return parseSections(response.data);
  }

  Future<Project?> createNewProject({required Project projectModel}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.addANewProject.getUrl()}";
    try {
      final response = await _dio.post(requestUrl,
          options: Options(headers: ApiConstants.authHeader),
          data: {
            "color": projectModel.color,
            "name": projectModel.name,
            "view_style": projectModel.viewStyle,
          });

      // Handle different response statuses
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          AppPopups.showSnackBar(
              type: SnackBarTypes.success,
              content: "Project created successfully.");
          dev.log('Project created successfully');
          return Project.fromJson(response.data);
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
          AppPopups.showSnackBar(
              type: SnackBarTypes.error, content: "There was an Error.");
      }
    } on DioError catch (dioError) {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "There was an Error.");
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

  Future<void> createNewSection({required Section sectionModel}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.createANewSection.getUrl()}";
    try {
      final response = await _dio.post(requestUrl,
          options: Options(headers: ApiConstants.authHeader),
          data: Section.fromJson(sectionModel.toJson()));

      // Handle different response statuses
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          AppPopups.showSnackBar(
              type: SnackBarTypes.success,
              content: "Section created successfully.");
          dev.log('Section created successfully');
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
          AppPopups.showSnackBar(
              type: SnackBarTypes.error, content: "There was an Error.");
      }
    } on DioError catch (dioError) {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "There was an Error.");
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

  Future<void> deleteProjectById({required String projectId}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.deleteAProject.getUrl()}/$projectId";
    try {
      final response = await _dio.delete(
        requestUrl,
        options: Options(headers: ApiConstants.authHeader),
      );

      // Handle different response statuses
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          AppPopups.showSnackBar(
              type: SnackBarTypes.success,
              content: "Project deleted successfully.");
          dev.log('Project deleted successfully');
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
          AppPopups.showSnackBar(
              type: SnackBarTypes.error, content: "There was an Error.");
      }
    } on DioError catch (dioError) {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "There was an Error.");
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

  Future<void> updateAProjectById(
      {required String projectId,
      required Map<String, dynamic> requestBody}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.updateProject.getUrl()}/$projectId";
    try {
      final response = await _dio.post(
        requestUrl,
        options: Options(headers: ApiConstants.authHeader),
        data: requestBody,
      );

      // Handle different response statuses
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          AppPopups.showSnackBar(
              type: SnackBarTypes.success,
              content: "Project updated successfully.");
          dev.log('Project updated successfully');
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
          AppPopups.showSnackBar(
              type: SnackBarTypes.error, content: "There was an Error.");
      }
    } on DioError catch (dioError) {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "There was an Error.");
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

  Future<void> updateALabelById(
      {required String labelId,
      required Map<String, dynamic> requestBody}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.updateAPersonalLabel.getUrl()}/$labelId";
    try {
      final response = await _dio.post(
        requestUrl,
        options: Options(headers: ApiConstants.authHeader),
        data: requestBody,
      );

      // Handle different response statuses
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          AppPopups.showSnackBar(
              type: SnackBarTypes.success,
              content: "Label updated successfully.");
          dev.log('Lable updated successfully');
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
          AppPopups.showSnackBar(
              type: SnackBarTypes.error, content: "There was an Error.");
      }
    } on DioError catch (dioError) {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "There was an Error.");
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

  Future<void> createALabel({required Map<String, dynamic> requestBody}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.createNewPersonalLabel.getUrl()}";
    try {
      final response = await _dio.post(
        requestUrl,
        options: Options(headers: ApiConstants.authHeader),
        data: requestBody,
      );

      // Handle different response statuses
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          AppPopups.showSnackBar(
              type: SnackBarTypes.success,
              content: "Label created successfully.");
          dev.log('Label created successfully');
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
          AppPopups.showSnackBar(
              type: SnackBarTypes.error, content: "There was an Error.");
      }
    } on DioError catch (dioError) {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "There was an Error.");
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

  Future<void> deleteLabelById({required String labelId}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.deleteAPersonalLabel.getUrl()}/$labelId";
    try {
      final response = await _dio.delete(
        requestUrl,
        options: Options(headers: ApiConstants.authHeader),
      );

      // Handle different response statuses
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          AppPopups.showSnackBar(
              type: SnackBarTypes.success,
              content: "Label deleted successfully.");
          dev.log('Label deleted successfully');
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
          AppPopups.showSnackBar(
              type: SnackBarTypes.error, content: "There was an Error.");
      }
    } on DioError catch (dioError) {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "There was an Error.");
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

  Future<void> updateACommentById(
      {required String commentId,
      required Map<String, dynamic> requestBody}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.updateAComment.getUrl()}/$commentId";
    try {
      final response = await _dio.post(
        requestUrl,
        options: Options(headers: ApiConstants.authHeader),
        data: requestBody,
      );

      // Handle different response statuses
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          AppPopups.showSnackBar(
              type: SnackBarTypes.success,
              content: "Comment edited successfully.");
          dev.log('Comment edited successfully');
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
          AppPopups.showSnackBar(
              type: SnackBarTypes.error, content: "There was an Error.");
      }
    } on DioError catch (dioError) {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "There was an Error.");
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

  Future<void> deleteACommentById({required String commentId}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.deleteAProject.getUrl()}/$commentId";
    try {
      final response = await _dio.delete(
        requestUrl,
        options: Options(headers: ApiConstants.authHeader),
      );

      // Handle different response statuses
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          AppPopups.showSnackBar(
              type: SnackBarTypes.success,
              content: "Comment deleted successfully.");
          dev.log('Comment deleted successfully');
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
          AppPopups.showSnackBar(
              type: SnackBarTypes.error, content: "There was an Error.");
      }
    } on DioError catch (dioError) {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "There was an Error.");
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

  Future<void> createAComment(
      {required Map<String, dynamic> requestBody}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.createANewComment.getUrl()}";
    try {
      final response = await _dio.post(
        requestUrl,
        options: Options(headers: ApiConstants.authHeader),
        data: requestBody,
      );

      // Handle different response statuses
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          AppPopups.showSnackBar(
              type: SnackBarTypes.success,
              content: "Comment added successfully.");
          dev.log('Comment added successfully');
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
          AppPopups.showSnackBar(
              type: SnackBarTypes.error, content: "There was an Error.");
      }
    } on DioError catch (dioError) {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "There was an Error.");
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

  Future<Task?> createATask(
      {required Map<String, dynamic> requestBody}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.createANewTask.getUrl()}";
    try {
      final response = await _dio.post(
        requestUrl,
        options: Options(headers: ApiConstants.authHeader),
        data: requestBody,
      );

      // Handle different response statuses
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          AppPopups.showSnackBar(
              type: SnackBarTypes.success,
              content: "Task created successfully.");
          dev.log('Task created successfully');
          return Task.fromJson(response.data);
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
          AppPopups.showSnackBar(
              type: SnackBarTypes.error, content: "There was an Error.");
      }
    } on DioError catch (dioError) {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "There was an Error.");
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

  Future<Task?> updateATaskById(
      {required String taskId,required Map<String, dynamic> requestBody}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.createANewTask.getUrl()}/$taskId";
    try {
      final response = await _dio.post(
        requestUrl,
        options: Options(headers: ApiConstants.authHeader),
        data: requestBody,
      );

      // Handle different response statuses
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          AppPopups.showSnackBar(
              type: SnackBarTypes.success,
              content: "Task updated successfully.");
          dev.log('Task updated successfully');
          return Task.fromJson(response.data);
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
          AppPopups.showSnackBar(
              type: SnackBarTypes.error, content: "There was an Error.");
      }
    } on DioError catch (dioError) {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "There was an Error.");
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

  Future<void> deleteATaskById({required String taskId}) async {
    final String requestUrl =
        "${ApiConstants.baseUrl}${ApiType.deleteATask.getUrl()}/$taskId";
    try {
      final response = await _dio.delete(
        requestUrl,
        options: Options(headers: ApiConstants.authHeader),
      );

      // Handle different response statuses
      switch (response.statusCode) {
        case 200:
        case 201:
        case 204:
          AppPopups.showSnackBar(
              type: SnackBarTypes.success,
              content: "Task deleted successfully.");
          dev.log('Task deleted successfully');
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
          AppPopups.showSnackBar(
              type: SnackBarTypes.error, content: "There was an Error.");
      }
    } on DioError catch (dioError) {
      AppPopups.showSnackBar(
          type: SnackBarTypes.error, content: "There was an Error.");
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
