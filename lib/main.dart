import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth/bloc/auth_bloc.dart';
import 'auth/repo/auth_repo.dart';
import 'auth/screen/auth_screen.dart';
import 'firebase_options.dart';
import 'home/bloc/home_bloc.dart';
import 'home/repo/home_repo.dart';
import 'home/screen/all_fee_receipt.dart';
import 'home/screen/home.dart';
import 'utils/not_veryfyed.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? id = prefs.getString('id');

  String initialRoute = id != null ? HomeScreen.routeName : AuthScreen.routeName;

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc(authRepository: AuthRepository())),
        BlocProvider(
            create: (context) => HomeBloc(homeRepository: HomeRepository(),authRepository: AuthRepository())),
        // Add more BlocProviders as needed
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: initialRoute,
        routes: {
          AuthScreen.routeName: (context) => AuthScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          NotVeryfyed.routeName: (context) => NotVeryfyed(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == AllFeeReceipt.routeName) {
            final args = settings.arguments as AllFeeReceiptArguments;
            return MaterialPageRoute(
              builder: (context) {
                return AllFeeReceipt(feeReceiptIds: args.feeReceiptIds);
              },
            );
          }
          return null; // Add default behavior if needed
        },
      ),
    );
  }
}

class AllFeeReceiptArguments {
  final List<String> feeReceiptIds;

  AllFeeReceiptArguments(this.feeReceiptIds);
}

