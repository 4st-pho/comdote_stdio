import 'package:firebase_auth/firebase_auth.dart';
import 'package:native_notify/native_notify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:stdio_week_6/constants/my_color.dart';
import 'package:stdio_week_6/firebase_options.dart';
import 'package:stdio_week_6/pages/login_page.dart';
import 'package:stdio_week_6/pages/main_page.dart';
import 'package:stdio_week_6/services/firebase_auth/firebase_auth_methods.dart';
import 'package:stdio_week_6/services/network/network_service.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: true,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark),
  );
  WidgetsFlutterBinding.ensureInitialized();
  NativeNotify.initialize(1002, 'ozFPB6GbNVyCQ7kY3NoSbr', null, null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NetWorkService>(
          create: (_) => NetWorkService(),
        ),
        StreamProvider(
          create: (context) => FirebaseAuthMethods().authState,
          initialData: null,
        ),
        StreamProvider(
          create: (context) => context.read<NetWorkService>().stream,
          initialData: NetworkStatus.online,
        ),
      ],
      child: MaterialApp(
        title: 'Comdote',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: MyColor.background),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    return Scaffold(body: user == null ? const LoginPage() : const MainPage());
  }
}
