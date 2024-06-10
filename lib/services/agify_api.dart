import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/age_prediction.dart';
import '../models/api_exceptions.dart';

class AgifyApi {
  final String baseUrl = 'https://api.agify.io';
  final http.Client client;

  AgifyApi([http.Client? client]) : client = client ?? http.Client();

  Future<AgePrediction> getAgeByName(String name) async {
    final url = '$baseUrl?name=$name';
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return AgePrediction.fromJson(jsonDecode(response.body));
    }
    else {
      switch (response.statusCode) {
        case 401:
          throw UnauthorizedException('Invalid API key');
        case 402:
          throw PaymentRequiredException('Subscription is not active');
        case 422:
          throw UnprocessableContentException('Missing or invalid name parameter');
        case 429:
          throw TooManyRequestsException('Request limit reached');
        default:
          throw ApiException('Failed to load age data', response.statusCode);
      }
    }
  }
}
