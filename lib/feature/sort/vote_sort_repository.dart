import 'package:lebanon_elections/feature/sort/sort_model.dart';

import '../../network/base_api.dart';
import '../../network/api_url.dart';
import '../home/modle/general_response.dart';

class VoteSortRepository {
  Future<CandidateResponse> getCandidates(Map<String, dynamic> body) async {
    final response = await BaseAPI.get(ApiUrl.getCandidates, body);
    return CandidateResponse.fromJson(response.toJson());
  }
  Future<GeneralResponse> candidateAction(Map<String, dynamic> body) async {
    final response = await BaseAPI.post(ApiUrl.candidateAction, body);
    return GeneralResponse.fromJson(response.toJson());
  }
}
