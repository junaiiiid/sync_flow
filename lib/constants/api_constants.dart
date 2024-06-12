class ApiConstants{
  ApiConstants._();

  static const String authToken = 'Bearer bf75eb392ca7f91786f8eac70d3a5798e3ee5fda';

  static const String baseUrl = 'https://api.todoist.com/rest/v2';

  static Map<String,dynamic> get authHeader => {"Authorization":authToken,"Content-Type":"application/json"};
}