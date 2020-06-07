
const String BASE_URL = "https://127.0.0.1:8066/sevenproject";
String CLIENT_ID       = "actionMC";
String CLIENT_SECRET   = "Spiderman";

Dio ApiServiceTime() {
  Dio dio = new Dio();
  dio.options.connectTimeout = 3000;
  dio.options.receiveTimeout = 3000;
  dio.options.sendTimeout = 3000;
  return dio;
}
 
String ApiServiceEndpoint(String endpoint) {
  switch (endpoint) {
    case "token":
      return '$BASE_URL/token';
    case "other":
      return '$BASE_URL/other';
    default:
      break;
  }
}

ApiServiceHit(String type, Map<String, String> bodyRequest)async  {
  switch(type){
    case "token":
      var grandType = generateMd5(client_modif(CLIENT_ID, 1));
      var client_credentials = generateMd5(client_modif(CLIENT_SECRET, 2));
      var basic = "$grandType:$client_credentials";
      var basicBase64 = genereteBase64(basic);

      Dio dio = ApiServiceTime();
      dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded;charset=UTF-8';
      dio.options.headers["authorization"] = "Basic $basicBase64";
      return  dio.post(ApiServiceEndpoint("token"), data: bodyRequest);
    
    default:
      final prefs = await SharedPreferences.getInstance(); 
      var tokenlogin = prefs.getString('token');

      Dio dio = ApiServiceTime(); 
      dio.options.headers['content-Type'] = 'application/json'; 
      dio.options.headers['Authorization'] = 'Bearer $tokenlogin'; 
   
      return dio.post(ApiServiceEndpoint("other"), data: bodyRequest);
  }
}

String ApiServiceHandleError(String error) {
  if (error is DioError) {
    DioError dioError = error as DioError;
    switch (dioError.type) {
      case DioErrorType.CANCEL:
        return "Request to Api server was cancelled";
      case DioErrorType.CONNECT_TIMEOUT:
        return "Connection timeout with API server";
      case DioErrorType.DEFAULT:
        return "Connection to API server failed due to internet connection";
      case DioErrorType.RECEIVE_TIMEOUT:
        return "Receive timeout in connection with API server";
      case DioErrorType.RESPONSE:
        return "Received invalid status code: ${dioError.response.statusCode}";
      case DioErrorType.SEND_TIMEOUT:
        return "Send timeout in connection with API server";
    }
  } else {
    return "Unexpected error occured";
  }
}
