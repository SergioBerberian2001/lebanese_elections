import 'package:lebanon_elections/feature/results/resulte_model.dart';
import '../../network/api_url.dart';
import '../../network/base_api.dart';

class ResultsProvider {
  Future<ResultsModelResponse> getResults(Map<String, dynamic> body) async {
    final response = await BaseAPI.get(ApiUrl.results, body);
    return ResultsModelResponse.fromJson(response.toJson());
  }

}

