import 'dart:convert';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/domain/models/card_model/card_model.dart';
import 'package:pass_guard/domain/models/notes_model/notes_model.dart';
import 'package:pass_guard/domain/models/password_model.dart';
import 'package:pass_guard/presentation/screens/auth/biometrics.dart';
import 'package:pass_guard/presentation/screens/initial/initial_screen.dart';
import 'package:pass_guard/presentation/themes/themes.dart';
import 'package:permission_handler/permission_handler.dart'; // Import the permission_handler package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Request permissions
  await _requestPermissions();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(VerifyAccountEvent())),
        BlocProvider(create: (context) => RandomNumberBloc()),
        BlocProvider(create: (context) => CreateAccountBloc()),
        BlocProvider(create: (context) => ThemesBloc()),
        BlocProvider(create: (context) => GeneratePasswordBloc()),
        BlocProvider(create: (context) => GeneralBloc()),
        BlocProvider(create: (context) => PasswordBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => SecurityBloc()),
        BlocProvider(create: (context) => CardBloc()),
        BlocProvider(create: (context) => NotesBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> _requestPermissions() async {
  // Request the necessary permissions
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.microphone,
  ].request();

  // Check the permission statuses
  if (statuses[Permission.camera] != PermissionStatus.granted ||
      statuses[Permission.microphone] != PermissionStatus.granted)

  {
    // Handle the scenario when permissions are not granted
    // You can show an error message or exit the app gracefully
    return;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    main();

    // Register the observer
    WidgetsBinding.instance?.addObserver(this);

    // Listen for app lifecycle changes
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      WidgetsBinding.instance?.addObserver(this);
    });
  }

  @override
  void dispose() {
    // Unregister the observer
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      // App is resumed from the background
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const InitialScreen()),
            (route) => false,
      );
    }
  }

  Future<void> main() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();

    final containsEncryptionKey =
    await secureStorage.containsKey(key: 'key');

    if (!containsEncryptionKey) {
      var key = Hive.generateSecureKey();
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    }

    final key = await secureStorage.read(key: 'key');

    var encryptionKey = base64Url.decode(key!);

    Hive.registerAdapter(PasswordModelAdapter());
    Hive.registerAdapter(CardModelAdapter());
    Hive.registerAdapter(NotesModelAdapter());

    await Hive.openBox<PasswordModel>('encrypt-password-arvi',
        encryptionCipher: HiveAesCipher(encryptionKey));
    await Hive.openBox<CardModel>('encrypt-card-wallet-arvi',
        encryptionCipher: HiveAesCipher(encryptionKey));
    await Hive.openBox<NotesModel>('encrypt-notes-arvi',
        encryptionCipher: HiveAesCipher(encryptionKey));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return BlocBuilder<ThemesBloc, ThemesState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Pass Guard',
          debugShowCheckedModeBanner: false,
          theme: ThemesArvi.appThemeDark,
          darkTheme: ThemesArvi.appTheme,
          themeMode: state.isOscure ? ThemeMode.dark : ThemeMode.light,
          home: Navigator(
            key: navigatorKey,
            onGenerateRoute: (routeSettings) {
              return MaterialPageRoute(
                builder: (context) => const InitialScreen(),
                settings: routeSettings,
              );
            },
          ),
        );
      },
    );
  }
}


