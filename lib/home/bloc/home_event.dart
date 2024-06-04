part of 'home_bloc.dart';


abstract class HomeEvent extends Equatable  {

  @override
  List<Object> get props => [];

}

class GetAllStudent extends HomeEvent {}
class GetStudentById extends HomeEvent {
  final String studentId;

  GetStudentById({
    required this.studentId,
  });

}
class UpdateStudent extends HomeEvent {
  final StudentModel studentModel;

   UpdateStudent({
    required this.studentModel,
  });
}


class GetAllFeeReceipts extends HomeEvent {}
class GetFeeReceiptByIds extends HomeEvent {
  final List<String> receiptId;

  GetFeeReceiptByIds({
    required this.receiptId,
  });

}
class UpdateFeeReceipt extends HomeEvent {

  final List<String> receiptId;

  final FeeReceiptModel feeReceiptModel;

   UpdateFeeReceipt({
    required this.receiptId,
    required this.feeReceiptModel,
  });
}

class DoFilterByBranch extends HomeEvent {
  final String branch;

   DoFilterByBranch({
    required this.branch,
  });
}
class DoFilterByYear extends HomeEvent {
  final String year;

  DoFilterByYear({
    required this.year,
  });
}
class DoFilterByQuery  extends HomeEvent {
  final String query;

  DoFilterByQuery({
    required this.query,
  });
}

