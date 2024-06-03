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
  final FacultyModel? facultyModel;
  final List<StudentModel>? studentList;
  final List<StudentModel>? filteredStudentList;
  final List<FeeReceiptModel>? feeReceiptList;
  final String? errorMessage;

  const HomeState({
    required this.status,
    this.facultyModel,
    this.studentList,
    this.filteredStudentList,
    this.feeReceiptList,
    this.errorMessage,
  });


  factory HomeState.initial() {
    return HomeState(
      status: HomeStateStatus.initial,
      facultyModel: null,
      studentList: [],
      feeReceiptList: [],
      filteredStudentList: [],
      errorMessage: "",
    );
  }



  @override
  List<Object?> get props =>
      [status, facultyModel,studentList, filteredStudentList,feeReceiptList, errorMessage,];

  HomeState copyWith({
    HomeStateStatus? status,
    FacultyModel? facultyModel,
    List<StudentModel>? studentList,
    List<StudentModel>? filteredStudentList,
    List<FeeReceiptModel>? feeReceiptList,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      facultyModel: facultyModel ?? this.facultyModel,
      studentList: studentList ?? this.studentList,
      filteredStudentList: filteredStudentList ?? this.filteredStudentList,
      feeReceiptList: feeReceiptList ?? this.feeReceiptList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

