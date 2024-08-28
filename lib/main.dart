import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/theme.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'init_dependencie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependecies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkThemeMode,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
