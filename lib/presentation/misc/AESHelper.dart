import 'package:encrypt/encrypt.dart';

class Aeshelper {
  Encrypter? encrypter;
  IV? keyIV;

  Aeshelper({required String ivKey, required String aesKey}) {
    encrypter = Encrypter(AES(Key.fromUtf8(aesKey)));
    keyIV = IV.fromBase64(ivKey);
  }

  Encrypted? encryptText(String plainText) {
    return encrypter?.encrypt(plainText, iv: keyIV);
  }

  String? decryptText(String encryptedText) {
    try {
      final encrypted = Encrypted.fromBase64(encryptedText);

      return encrypter?.decrypt(encrypted, iv: keyIV);
    } catch (e) {
      return 'Decryption failed: $e';
    }
  }
}
