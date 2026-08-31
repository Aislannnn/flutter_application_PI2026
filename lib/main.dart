import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/constants.dart';
import 'core/theme.dart';
import 'features/auth/presentation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  buildAppOverlayStyle(bool escuro) {
    return escuro
        ? SystemUiOverlayStyle.light.copyWith(
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.light,
          )
        : SystemUiOverlayStyle.dark.copyWith(
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modoEscuro,
      builder: (context, escuro, _) {
        return ValueListenableBuilder<double>(
          valueListenable: escalaFonte,
          builder: (context, escala, _) {
            return ValueListenableBuilder<String>(
              valueListenable: tipoFonte,
              builder: (context, fonte, _) {
                return AnnotatedRegion<SystemUiOverlayStyle>(
                  value: buildAppOverlayStyle(escuro),
                  child: MaterialApp(
                    title: 'Mente Viva',
                    debugShowCheckedModeBanner: false,
                    theme: buildAppTheme(escuro: escuro, tipoFonte: fonte),
                    builder: (context, child) {
                      return MediaQuery(
                        data: MediaQuery.of(
                          context,
                        ).copyWith(textScaler: TextScaler.linear(escala)),
                        child: child!,
                      );
                    },
                    home: const LoadingScreen(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
