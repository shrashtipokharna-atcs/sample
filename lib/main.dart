import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/bloc/login_bloc.dart';
import 'package:test_app/bloc/register_bloc.dart';
import 'package:test_app/screens/AppStateNotifier.dart';
import 'package:test_app/screens/AppTheme.dart';
import 'package:test_app/screens/login_screen.dart';
import 'package:test_app/screens/theme_demo.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context){ 
//     return MultiProvider(
//       providers: [
//         Provider<LoginBloc>(create: (context) => LoginBloc(),),
//         Provider<RegisterBloc>(create: (context) => RegisterBloc(),),
//       ],
//       child: MaterialApp(
//         title: 'Complete Authentication',
//         theme: ThemeData(
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         debugShowCheckedModeBanner: false,
//         home: LoginScreen(),
//       ),
//     );
//   }
// }

void main() {
  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(),
      child: HomeApp(),
    ),
  );
}
 
class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, appState, child) {
        return MaterialApp(
          title: 'Flutter Theming Tutorials',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme, // ThemeData(primarySwatch: Colors.blue),
          darkTheme:
              AppTheme.darkTheme, // ThemeData(primarySwatch: Colors.blue),
          home: ThemeDemo(),
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}