import 'package:lebanon_elections/feature/home/modle/general_response.dart';
import 'package:lebanon_elections/feature/results/resulte_model.dart';
import '../../network/api_url.dart';
import '../../network/base_api.dart';
import '../home/modle/about_and_privicy.dart';
import 'notes_model.dart';

class NotesProvider {
  Future<NotesModelResponse> getNotes(Map<String, dynamic> body) async {
    final response = await BaseAPI.get(ApiUrl.notes, body);
    return NotesModelResponse.fromJson(response.toJson());
  }

  Future<GeneralResponse> addNote(Map<String, dynamic> body) async {
    final response = await BaseAPI.post(ApiUrl.addNotes, body);
    return GeneralResponse.fromJson(response.toJson());
  }

  Future<TermsPrivacyModel> getTermsAndPrivacy(Map<String, dynamic> body) async {
    final response = await BaseAPI.get(ApiUrl.termsAndPrivacy, body);
    return TermsPrivacyModel.fromJson(response.toJson());
  }
}
