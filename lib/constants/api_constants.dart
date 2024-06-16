class ApiConstants{
  ApiConstants._();

  static const String authToken = 'Bearer 309a1577a632a092129e7ba3d2e497525371981e';

  static const String baseUrl = 'https://api.todoist.com/rest/v2';

  static Map<String,dynamic> get authHeader => {"Authorization":authToken,"Content-Type":"application/json"};
}