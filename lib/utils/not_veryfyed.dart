
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/bloc/auth_bloc.dart';

class NotVeryfyed extends StatelessWidget {

  static final routeName = '/NotVeryfyed';


  const NotVeryfyed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("you can not do aything here you are not a verified user"),
            SizedBox(height: 20,),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequested());
              },
            ),


          ],
        ),
      ),
    );
  }
}
