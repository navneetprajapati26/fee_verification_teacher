part of 'auth_bloc.dart';


// States

enum AuthStateStatus {
  initial,
  loading,
  loaded,
  register,
  login,
  logout,
  error,
  connectivityError,
}

class AuthState extends Equatable {
  final AuthStateStatus status;
  final FacultyModel? user;
  final String? errorMessage;


  const AuthState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  factory AuthState.initial() {
    return AuthState(
        status: AuthStateStatus.initial, user: null, errorMessage: "");
  }



  @override
  List<Object?> get props => [status, user, errorMessage];

  AuthState copyWith({
    AuthStateStatus? status,
    FacultyModel? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
