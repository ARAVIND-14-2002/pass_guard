import 'package:encrypt/encrypt.dart' as encrypted;

class EncryptData {


// Encrypt a password
  static String encryptPassword(String password, String token) {
    final key = encrypted.Key.fromUtf8(token);
    final iv = encrypted.IV.fromLength(16);
    final encrypter = encrypted.Encrypter(encrypted.AES(key));
    final encrypt = encrypter.encrypt(password, iv: iv);
    return encrypt.base64;
  }
}

class DecryptData{

  // Decrypt an encrypted password
  static String decryptPassword(String encryptedPassword, String token) {
    final key = encrypted.Key.fromUtf8(token);
    final iv = encrypted.IV.fromLength(16);
    final encrypter = encrypted.Encrypter(encrypted.AES(key));
    final decryptedPassword = encrypter.decrypt64(encryptedPassword, iv: iv);
    return decryptedPassword;
  }
}
