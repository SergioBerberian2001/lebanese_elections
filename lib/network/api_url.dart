String mainUrl = "";
String baseUrl = "";
class ApiUrl {
  static const String _baseUrl = 'https://lebanon-elections.com/api/';

  // 🔥 Auth
  static String login = '${_baseUrl}login';
  static String logout = '${_baseUrl}logout';

  // 🔥 Voters
  static String getVoters = '${_baseUrl}vote/get';
  static String voteAction = '${_baseUrl}vote/action';

  // 🔥 Candidates
  static String getCandidates = '${_baseUrl}candidate/get';
  static String candidateAction = '${_baseUrl}candidate/action';

  // 🔥 Results
  static String results = '${_baseUrl}results';

  // 🔥 Notes
  static String notes = '${_baseUrl}note/get';
  static String addNotes = '${_baseUrl}note/add';

  // 🔥 Terms & Privacy
  static String termsAndPrivacy = '${_baseUrl}terms-privacy';
}


