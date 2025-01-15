import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Aeshelper {
  final Encrypter encrypter =
      Encrypter(AES(Key.fromUtf8('${dotenv.env['ENCRYPTION_KEY']}')));

  final keyIV = IV.fromBase64('${dotenv.env['IV_KEY']}');

  Encrypted encryptText(String plainText) {
    return encrypter.encrypt(plainText, iv: keyIV);
  }

  String decryptText(String encryptedText) {
    try {
      final encrypted = Encrypted.fromBase64(encryptedText);

      return encrypter.decrypt(encrypted, iv: keyIV);
    } catch (e) {
      return 'Decryption failed: $e';
    }
  }
}
