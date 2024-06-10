import '../models/age_prediction.dart';
import '../services/agify_api.dart';

class AgifyRepository {
  final AgifyApi _agifyApi = AgifyApi();

  Future<AgePrediction> getAgeByName(String name) {
    return _agifyApi.getAgeByName(name);
  }
}
