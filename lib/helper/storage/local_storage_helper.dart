import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lebanon_elections/helper/storage/storage_key.dart';

import '../../feature/login/model/login_response.dart';


class LocalStorageHelper {
  static var secureStorage = const FlutterSecureStorage();

  static Future<void> saveLoginData(
      {required String username,
      required String password,
      required String token,
      required User userData}) async {
    await secureStorage.write(key: StorageKeys.userNameKey, value: username);
    await secureStorage.write(key: StorageKeys.passwordKey, value: password);
    await secureStorage.write(key: StorageKeys.token, value: token);
    await secureStorage.write(
        key: StorageKeys.userData, value: jsonEncode(userData.toJson()));
  }

  static Future<void> saveApiDomain(String apiDomain) async {
    await secureStorage.write(key: StorageKeys.baseUrl, value: apiDomain);
  }

  static Future<bool> isFirstDownload() async {
    String? firstDownload =
        await secureStorage.read(key: StorageKeys.firstDownloadKey);
    if (firstDownload == null) {
      await secureStorage.write(
          key: StorageKeys.firstDownloadKey, value: 'false');
      return true;
    }
    return false;
  }

  static Future<String?> getApiDomain() async {
    return await secureStorage.read(key: StorageKeys.baseUrl);
  }

  static Future<User?> getUserData() async {
    return User.fromJson(jsonDecode(
        await secureStorage.read(key: StorageKeys.userData) ?? '{}'));
  }

  static Future<void> saveRememberMe({required bool isRememberMe}) async {
    await secureStorage.write(
        key: StorageKeys.isRememberMe, value: isRememberMe ? '1' : '0');
  }

  static Future<String?> getToken() async {
    return await secureStorage.read(key: StorageKeys.token);
  }

  static Future<String?> getUserName() async {
    return await secureStorage.read(key: StorageKeys.userNameKey);
  }

  static Future<String?> getPassword() async {
    return await secureStorage.read(key: StorageKeys.passwordKey);
  }

  static Future<void> clearSelectedLocation() async {
    await secureStorage.delete(key: StorageKeys.selectedLocation);
  }
  static Future<void> clearCredentials() async {
    await secureStorage.delete(key: StorageKeys.token);
    await secureStorage.delete(key: StorageKeys.userNameKey);
    await secureStorage.delete(key: StorageKeys.passwordKey);
    await secureStorage.delete(key: StorageKeys.userData);
    await secureStorage.delete(key: StorageKeys.isRememberMe);
  }

  static Future<void> clearConnectivity() async {
    await secureStorage.delete(key: StorageKeys.branchJsonKey);
    await secureStorage.delete(key: StorageKeys.schoolJsonKey);
  }

  static Future<bool> isRememberMe() async {
    return await secureStorage.read(key: StorageKeys.isRememberMe) == '1';
  }

  static Future<bool> isLoggedIn() async {
    String token = await secureStorage.read(key: StorageKeys.token) ?? "";
    String userName = await secureStorage.read(key: StorageKeys.userNameKey) ?? "";

     return token.isNotEmpty && userName.isNotEmpty;
  }

  // static void saveDictionary(DictionaryModel? dictionaryModel) async {
  //   await secureStorage.write(
  //       key: StorageKeys.dictionaryKey,
  //       value: json.encode(dictionaryModel?.toJson()));
  // }
  //
  // static Future<DictionaryModel?> getDictionary() async {
  //   return DictionaryModel.fromJson(jsonDecode(
  //       await secureStorage.read(key: StorageKeys.dictionaryKey) ?? '{}'));
  // }

  static Future<void> saveLangCode(String langCode) async {
    await secureStorage.write(key: StorageKeys.langCodeKey, value: langCode);


  }

  static Future<String> getLangCode() async {
    return await secureStorage.read(key: StorageKeys.langCodeKey) ?? 'ar';
  }


  static void saveSelectedEnvironment(String? selectedEnvironment) {
    secureStorage.write(key: StorageKeys.selectedEnvironment, value: selectedEnvironment);
  }

  static Future<String?> getSelectedEnvironment() async {
    return await secureStorage.read(key: StorageKeys.selectedEnvironment);
  }
}
