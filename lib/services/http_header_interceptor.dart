
import 'dart:async';
import 'package:chopper/chopper.dart';

/// HTTP Header Interceptor
/// Adding headers to http requests
class HttpHeaderInterceptor implements RequestInterceptor {
    
  static const String AUTH_HEADER = "Authorization";
  static const String BASIC = "Basic ";
  static const String API_KEY = "<API KEY>";

  @override
  FutureOr<Request> onRequest(Request request) async {

    Request newRequest = request.copyWith(headers: {AUTH_HEADER: BASIC + API_KEY});
    
    return newRequest;
  }
  
}