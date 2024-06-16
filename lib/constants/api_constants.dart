class ApiConstants{
  ApiConstants._();

  static const String authToken = 'Bearer 5d35587b3e29b8c68b9d7c6d29cd92f90822f8b1';

  static const String baseUrl = 'https://api.todoist.com/rest/v2';

  static Map<String,dynamic> get authHeader => {"Authorization":authToken,"Content-Type":"application/json"};
}