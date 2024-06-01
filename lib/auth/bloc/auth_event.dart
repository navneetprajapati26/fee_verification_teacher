part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String facultyName;
  final String receiptType;

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.facultyName,
    required this.receiptType,
  });


  @override
  List<Object> get props => [email, password, facultyName, receiptType];
}

class GetUserModel extends AuthEvent {}

class UpdateUserInfo extends AuthEvent {
  final FacultyModel facultyModel;

  const UpdateUserInfo(this.facultyModel);

  @override
  List<Object> get props => [facultyModel];
}

class SignOutRequested extends AuthEvent {}
