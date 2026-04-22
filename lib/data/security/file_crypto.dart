import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;

class FileCrypto {
  FileCrypto(this._deviceSeed);
  final String _deviceSeed;

  Future<File> encryptInPlace(File inputFile) async {
    final bytes = await inputFile.readAsBytes();
    final key = _deriveKey();
    final iv = enc.IV.fromLength(16);
    final cryptor = enc.Encrypter(enc.AES(key));
    final encrypted = cryptor.encryptBytes(bytes, iv: iv);
    await inputFile.writeAsBytes(encrypted.bytes, flush: true);
    return inputFile;
  }

  Future<File> decryptToTemp(File encryptedFile) async {
    final bytes = await encryptedFile.readAsBytes();
    final key = _deriveKey();
    final iv = enc.IV.fromLength(16);
    final cryptor = enc.Encrypter(enc.AES(key));
    final decrypted = cryptor.decryptBytes(enc.Encrypted(bytes), iv: iv);
    final output = File('${encryptedFile.path}.tmp.dec.m4a');
    await output.writeAsBytes(decrypted, flush: true);
    return output;
  }

  enc.Key _deriveKey() {
    final digest = sha256.convert(utf8.encode(_deviceSeed)).bytes;
    return enc.Key(Uint8List.fromList(digest));
  }
}
