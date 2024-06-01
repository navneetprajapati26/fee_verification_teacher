import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/fee_receipt_model.dart';
import '../model/student_model.dart';
import '../repo/home_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(HomeState.initial()) {
    on<GetAllStudent>(_onGetAllStudent);
    on<GetStudentById>(_onGetStudentById);
    on<UpdateStudent>(_onUpdateStudent);
    on<GetAllFeeReceipts>(_onGetAllFeeReceipts);
    on<GetFeeReceiptById>(_onGetFeeReceiptById);
    on<UpdateFeeReceipt>(_onUpdateFeeReceipt);
  }

  Future<void> _onGetAllStudent(GetAllStudent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final students = await homeRepository.getAllStudents();
      emit(state.copyWith(status: HomeStateStatus.loaded, studentList: students));
    } catch (e) {
      emit(state.copyWith(status: HomeStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onGetStudentById(GetStudentById event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final student = await homeRepository.getStudentById(event.studentId);
      emit(state.copyWith(status: HomeStateStatus.loaded, studentList: student != null ? [student] : []));
    } catch (e) {
      emit(state.copyWith(status: HomeStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateStudent(UpdateStudent event, Emitter<HomeState> emit) async {
    try {
       await homeRepository.updateStudent(event.studentModel);

       add(GetAllStudent());

    } catch (e) {
      emit(state.copyWith(status: HomeStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onGetAllFeeReceipts(GetAllFeeReceipts event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final feeReceipts = await homeRepository.getAllFeeReceipts();
      emit(state.copyWith(status: HomeStateStatus.loaded, feeReceiptList: feeReceipts));
    } catch (e) {
      emit(state.copyWith(status: HomeStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onGetFeeReceiptById(GetFeeReceiptById event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final feeReceipt = await homeRepository.getFeeReceiptById(event.receiptId);
      emit(state.copyWith(status: HomeStateStatus.loaded, feeReceiptList: feeReceipt != null ? [feeReceipt] : []));
    } catch (e) {
      emit(state.copyWith(status: HomeStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateFeeReceipt(UpdateFeeReceipt event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final feeReceipt = await homeRepository.getFeeReceiptById(event.receiptId);
      if (feeReceipt != null) {
        await homeRepository.updateFeeReceipt(feeReceipt);
        emit(state.copyWith(status: HomeStateStatus.loaded));
      } else {
        emit(state.copyWith(status: HomeStateStatus.error, errorMessage: 'Fee receipt not found'));
      }
    } catch (e) {
      emit(state.copyWith(status: HomeStateStatus.error, errorMessage: e.toString()));
    }
  }
}