import 'package:fee_verification_teacher/home/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constance/constents.dart';
import '../../utils/dropdown_button.dart';
import '../../utils/not_veryfyed.dart';
import '../bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {

  static final routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _facultyNameController = TextEditingController();
  late final String _facultyType;
  late final String _facultyAssociateWith;
  bool _isLogin = false;

  bool _isPasswordHidden = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _facultyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Register'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStateStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state.status == AuthStateStatus.login  ) {
            if(state.user!.isFacultyVerified == null || state.user!.isFacultyVerified! == false ){
              Navigator.of(context).pushReplacementNamed(NotVeryfyed.routeName);
            }else{
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

            }
          }
          // if (state.status == AuthStateStatus.login && (state.user!.isFacultyVerified != null || state.user!.isFacultyVerified!) ) {
          //   Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          // }
          if (state.status == AuthStateStatus.register) {
            _isLogin = true;
          }
        },
        builder: (context, state) {
          if (state.status == AuthStateStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: _isPasswordHidden,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                  ),
                  if (!_isLogin) ...[
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _facultyNameController,
                      decoration: InputDecoration(
                        labelText: 'Faculty Name',
                      ),
                    ),
                    SizedBox(height: 16.0),

                    CustomDropdownButton(
                      items:ListConstent.facultyType,
                      hint: 'Select fee Type',
                      onChanged: (value) {

                        setState(() {
                          _facultyType = value!;
                        });

                        print('Selected: $_facultyType');


                      },
                    ),
                    SizedBox(height: 16.0),

                    CustomDropdownButton(
                      items:ListConstent.facultyAssociateWith,
                      hint: 'Select faculty Associate With',
                      onChanged: (value) {

                        setState(() {
                          _facultyAssociateWith = value!;
                        });

                        print('Selected: $_facultyType');


                      },
                    ),


                  ],
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_isLogin) {
                        context.read<AuthBloc>().add(
                          SignInRequested(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          ),
                        );
                      } else {
                        context.read<AuthBloc>().add(
                          SignUpRequested(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            facultyName: _facultyNameController.text.trim(),
                            facultyType: _facultyType,
                            facultyAssociateWith: _facultyAssociateWith

                          ),
                        );
                      }
                    },
                    child: Text(_isLogin ? 'Login' : 'Register'),
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin
                          ? 'Don\'t have an account? Register'
                          : 'Already have an account? Login',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}