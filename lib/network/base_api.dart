import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../constant/app_constants.dart';
import '../helper/storage/local_storage_helper.dart';
import 'api_response_model.dart';
import 'api_url.dart';
import 'app_exception.dart';

class BaseAPI {
  static const int _timeOutValueSeconds = 1000;

  static Future<ApiResponseModel> post(String url, Map<String, dynamic> body,
      {bool? useMainUrl}) async {
    try {
      if (useMainUrl != true) {
        url = '$url';
      }
      body.removeWhere((key, value) => value == null || value == 'null');
      var response = await http
          .post(
        Uri.parse(url),
        headers: await getHeader(),
        body: body,
      )
          .timeout(
        const Duration(seconds: _timeOutValueSeconds),
      );

      log(
        'START',
        name: 'post $url API $body',
      );
      Future.delayed(const Duration(seconds: 1))
          .then((value) => log(response.body));
      log(response.body, name: 'Body');

      return ApiResponseModel.fromJson(json.decode(response.body));
    } on SocketException {
      log('hello_voter'.tr, error: 'GET API ERROR $url');
      throw AppException(
        'hello_voter'.tr,
        'hello_voter'.tr,
        AppConstants.noInternetCode,
      );
    } catch (e) {
      log(e.toString(), error: 'ERROR $url');
      return ApiResponseModel(
        message: 'Error'.tr,
        status: '0',
      );
    }
  }

  static Future<ApiResponseModel> postMultipartRequest(
      String url, Map<String, String> body, XFile? file,
      {XFile? fileCard, bool? useMainUrl}) async {
    try {
      if (useMainUrl != true) {
        url = '${baseUrl}/$url';
      }

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll(await getHeader());
      request.fields.addAll(body);

      if (file != null) {
        String encodedPath = Uri.encodeFull(file.path);
        request.files
            .add(await http.MultipartFile.fromPath('file', encodedPath));
      }

      if (fileCard != null) {
        String encodedCardPath = Uri.encodeFull(fileCard.path);
        request.files.add(
            await http.MultipartFile.fromPath('id_image', encodedCardPath));
      }

      http.StreamedResponse response = await request.send();
      var responseBody = await response.stream.bytesToString();

      log(
        'START',
        name: 'post $url API $body',
      );
      Future.delayed(const Duration(seconds: 1))
          .then((value) => log(responseBody));

      return ApiResponseModel.fromJson(json.decode(responseBody));
    } on SocketException {
      log('hello_voter'.tr, error: 'GET API ERROR $url');
      throw AppException(
        'hello_voter'.tr,
        'hello_voter'.tr,
        AppConstants.noInternetCode,
      );
    } catch (e) {
      log(e.toString(), error: 'POST API ERROR $url');
      return ApiResponseModel(
        message: 'Error'.tr,
        status: '0',
      );
    }
  }

  static Future<ApiResponseModel> get(String url, Map<String, dynamic> body,
      {bool? useMainUrl, bool? isFirst}) async {
    try {
      body.removeWhere((key, value) => value == null || value == 'null');
      final String queryString = Uri(
          queryParameters:
          body.map((key, value) => MapEntry(key, value?.toString())))
          .query;
      String fullUrl = "$url?$queryString";
      log('START', name: 'Get $fullUrl API');
      if (useMainUrl != true) {
        fullUrl = '$fullUrl';
      }
      var response = await http
          .get(
        Uri.parse(fullUrl),
        headers: await getHeader(isFirst: isFirst),
      )
          .timeout(
        const Duration(seconds: _timeOutValueSeconds),
      );

      log(response.body, name: '$fullUrl STATUS CODE ${response.statusCode}');
      if (response.statusCode == 401) {
        // makeLogOut();
      }

      return ApiResponseModel.fromJson(json.decode(response.body));
    } on SocketException {
      log('hello_voter'.tr, error: 'GET API ERROR $url');
      throw AppException(
        'hello_voter'.tr,
        'hello_voter'.tr,
        AppConstants.noInternetCode,
      );
    } catch (e) {
      log(e.toString(), error: 'GET API ERROR $url');
      return ApiResponseModel(message: 'Error'.tr, status: '0', data: {});
    }
  }

  static Future<Map<String, String>> getHeader({bool? isFirst}) async {
    String branchName = '';
    String apiKey =
        'EOSo5V5uPySR3Vy6WUU8dJNh05J4vLeHy7mNHcKUgwJl8KmRpRU8KzmBfUpRMgmAQeLm6sNk9Hx79lEEwHKdh6Pbd7aAQpqXRGTlrm4VjDkff9qh7FN1PVFWnm8QizQz';
    String? token = await LocalStorageHelper.getToken();

    Map<String, String> header = {
      'api-key': apiKey,
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'branch': branchName,
      'Accept-Language': isFirst ?? false ? "ar" : Get.locale?.languageCode ?? 'en',
    };
    return header;
  }
}