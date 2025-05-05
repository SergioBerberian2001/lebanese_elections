import '../../network/api_url.dart';
import '../../network/base_api.dart';
import 'modle/general_response.dart';
import 'modle/voter_response_model.dart';

class VoterRepository {
  Future<VoterModelResponse> getVoters(Map<String, dynamic> body) async {
    final response = await BaseAPI.get(ApiUrl.getVoters, body);
    return VoterModelResponse.fromJson(response.toJson());
  }
  Future<GeneralResponse> approveAndReject(Map<String, dynamic> body) async {
    final response = await BaseAPI.post(ApiUrl.voteAction, body);
    return GeneralResponse.fromJson(response.toJson());
  }
}

