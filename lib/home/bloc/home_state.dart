part of 'home_bloc.dart';


enum HomeStateStatus {
  initial,
  loading,
  loaded,
  error,
  connectivityError,
}

class HomeState extends Equatable {
  final HomeStateStatus status;
  final List<StudentModel>? studentList;
  final List<FeeReceiptModel>? feeReceiptList;
  final String? errorMessage;

  const HomeState({
    required this.status,
    this.studentList,
    this.feeReceiptList,
    this.errorMessage,
  });


  factory HomeState.initial() {
    return HomeState(
      status: HomeStateStatus.initial,
      studentList: [],
      feeReceiptList: [],
      errorMessage: "",
    );
  }

  HomeState copyWith({
    HomeStateStatus? status,
    List<StudentModel>? studentList,
    List<FeeReceiptModel>? feeReceiptList,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      studentList: studentList ?? this.studentList,
      feeReceiptList: feeReceiptList ?? this.feeReceiptList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, studentList, feeReceiptList, errorMessage,];
}

