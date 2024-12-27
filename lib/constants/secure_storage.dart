import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);
final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

const TOKEN = "token";
const EMAIL = "email";
const PASSWORD = "password";
const SEARCH_HISTORY = "search_history";
const REMEMBER_PASSWORD = "remember_password";

// to save token in local storage
setToken(String? token) async {
  await storage.write(key: TOKEN, value: token);
}

// to get token from local storage
getToken() async => await storage.read(key: TOKEN) ?? "";

// Save credentials securely
saveCredentials(String email, String password) async {
  await storage.write(key: EMAIL, value: email);
  await storage.write(key: PASSWORD, value: password);
}

getEmail() async => await storage.read(key: EMAIL) ?? "";

getPassword() async => await storage.read(key: PASSWORD) ?? "";


// Clear saved credentials if "remember password" is unchecked
clearCredentials() async {
  await storage.delete(key: EMAIL);
  await storage.delete(key: PASSWORD);
}

isRememberPassword() async => await storage.read(key: REMEMBER_PASSWORD) == 'true';

setRememberPassword(bool? savedRemember) async {
  await storage.write(key: REMEMBER_PASSWORD, value: savedRemember.toString());
}
