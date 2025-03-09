import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';
import 'package:warung_bioskop/presentation/providers/router/router_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await fetchKeyRemoteConfigAndSave();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: saffron,
          onSurface: backgroundColor,
          //background: backgroundColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.poppins(color: ghostWhite),
          bodyLarge: GoogleFonts.poppins(color: ghostWhite),
          labelLarge: GoogleFonts.poppins(color: ghostWhite),
        ),
      ),
      routeInformationParser: ref.watch(routerProvider).routeInformationParser,
      routeInformationProvider:
          ref.watch(routerProvider).routeInformationProvider,
      routerDelegate: ref.watch(routerProvider).routerDelegate,
    );
  }
}

Future<void> fetchKeyRemoteConfigAndSave() async {
  try {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 5),
      minimumFetchInterval: const Duration(minutes: 5),
    ));

    await remoteConfig.fetchAndActivate();

    await Hive.initFlutter();

    Uint8List key = padKeyTo32Bytes(shortKey);

    Uint8List secret = base64Decode(base64Encode(key));

    var encryptedBox =
        await Hive.openBox(keyBox, encryptionCipher: HiveAesCipher(secret));

    encryptedBox.put(tmdbToken, remoteConfig.getString(tmdbToken));
    encryptedBox.put(encryptionKey, remoteConfig.getString(encryptionKey));
    encryptedBox.put(ivKey, remoteConfig.getString(ivKey));
  } catch (e) {
    debugPrint("❌ Failed to fetch Remote Config: $e");
  }
}

Uint8List padKeyTo32Bytes(String key) {
  List<int> keyBytes = utf8.encode(key);
  return Uint8List.fromList(keyBytes.sublist(0, 32));
}
