import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solicitud_toner/provider/sector_data_provider.dart';
import 'package:solicitud_toner/provider/solicitud_toner_provider.dart';
import 'package:solicitud_toner/provider/toner_data_provider.dart';
import 'package:window_manager/window_manager.dart';

import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Size size = await DesktopWindow.getWindowSize();
  // await DesktopWindow.setWindowSize(Size(500, 500));
  // await DesktopWindow.setFullScreen(false);

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(500, 500),
    center: true,
    backgroundColor: Colors.transparent,
    // skipTaskbar: true,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.setMaximizable(false);
    await windowManager.setMinimizable(false);
    await windowManager.setResizable(false);
    await windowManager.setTitle("Solicitar Toner");
    await windowManager.setIcon("lib/assets/icono.ico");
    await windowManager.focus();
  });

  await Hive.initFlutter();
  await Hive.openBox("settings");

  runApp(const StateApp());
}

class StateApp extends StatelessWidget {
  const StateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SectorDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TonerDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SolicitudTonerProvider(),
        )
      ],
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => HomeScreen(),
        'settings': (context) => SettingsScreen(),
      },
    );
  }
}
