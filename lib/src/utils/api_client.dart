import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:news_app/src/config/api_endpoints.dart';
import 'package:news_app/src/models/home_feed/news_model.dart';
import 'package:news_app/src/utils/loading_dialog.dart';
import 'package:news_app/src/utils/logger.dart';
import 'package:news_app/src/widgets/common_dialog.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  static late ApiClient _instance;
  static late Dio dio;
  static const bool doWriteLog = true;

  static ApiClient get instance => _instance;

  factory ApiClient._private(Dio dio, {String baseUrl}) = _ApiClient;

  static Future<void> init(String baseUrl) async {
    var options = BaseOptions(baseUrl: baseUrl, connectTimeout: 30000, receiveTimeout: 60000, headers: {
      "Content-Type": "application/json",
      "Accept": 'application/json',
    });

    dio = Dio(options);
    if (!Foundation.kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        maxWidth: 234,
        requestHeader: true,
        requestBody: true,
      ));
    }
    _instance = ApiClient._private(dio, baseUrl: baseUrl);
  }

  @GET("${APIEndpoints.homeFeed}pageSize=10&page={pageCount}&${APIEndpoints.apiKey}")
  Future<NewsModel> getHomeFeedData({@Path("pageCount") int? pageCount});

  @GET("${APIEndpoints.searchFeed}{query}&pageSize=10&page={pageCount}&${APIEndpoints.apiKey}")
  Future<NewsModel> getSearchFeedData({@Path("query") String? query, @Path("pageCount") int? pageCount});

  @GET("${APIEndpoints.filterFeed}{category}&sortBy={sortBy}&pageSize=10&page={pageCount}&${APIEndpoints.apiKey}")
  Future<NewsModel> getFilterFeedData({@Path("category") String? category, @Path("sortBy") String? sortBy, @Path("pageCount") int? pageCount});
}

Future<T?> callApi<T>(BuildContext context, Future<T> request, Function()? apiCall, {bool showLoader = true, bool showErrorDialog = true}) async {
  try {
    if (showLoader) showLoadingDialog(context: context);
    var response = await request;
    if (showLoader) hideLoadingDialog(context: context);
    return response;
  } on DioError catch (error) {
    if (showLoader) hideLoadingDialog(context: context);
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        break;
      case DioErrorType.response:
        if (showErrorDialog) onHttpError(context, error, apiCall);
        break;
      case DioErrorType.cancel:
      case DioErrorType.other:
        break;
    }
  } catch (error) {
    if (showLoader) hideLoadingDialog(context: context);
  }
  return null;
}

void onHttpError(BuildContext context, DioError error, Function()? request) {
  final json = error.response?.data;
  switch (error.response?.statusCode) {
    case 500: // ServerError
      _apiErrorDialog(context, json['message'], request!);
      break;
    case 400: // BadRequest
      _apiErrorDialog(context, json['message'], request!);
      break;
    case 401: // BadRequest
      _apiErrorDialog(context, json['message'], request!);
      break;
    case 403: // Unauthorized
      _apiErrorDialog(context, json['message'], request!);
      break;
    case 404: // NotFound
      _apiErrorDialog(context, json['message'], request!);
      break;
    case 409: // Conflict
      _apiErrorDialog(context, json['message'], request!);
      break;
    case 423: // Blocked
      _apiErrorDialog(context, json['message'], request!);
      break;
    case 426:
      _apiErrorDialog(context, json['message'], request!);
      break;
    case 402: // Payment required
      _apiErrorDialog(context, json['message'], request!);
      break;
    case 422: // InValidateData
      if (json['errors'] == null) {
        if (json['message'] != null) {
          _apiErrorDialog(context, json['message'], request!);
        }
      } else {
        String errors = "";
        (json['errors'] as Map<String, dynamic>).forEach((k, v) {
          errors += "• $v\n";
        });
        _apiErrorDialog(context, errors, request!);
      }
      break;
    case 429:
      _apiErrorDialog(context, json['message'], request!);
      break;
    case 524: // ServerTimeout
      _apiErrorDialog(context, "Server request time out", request!);
      break;
    case 521: // Web server is down debugPrint
    default:
      _apiErrorDialog(context, 'Something went wrong!', request!);
  }
}

_apiErrorDialog(BuildContext context, String? description, Function()? apiCall) {
  showErrorDialog(
    context: context,
    title: "Oops",
    message: description,
    negativeButtonTap: () {
      Navigator.pop(context);
    },
    negativeButtonText: "Okay",
    positiveButtonTap: () {
      apiCall!();
    },
    positiveButtonText: "Retry",
  );
}
