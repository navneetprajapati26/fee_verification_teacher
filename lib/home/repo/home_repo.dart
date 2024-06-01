import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constance/table_name_constants.dart';
import '../model/fee_receipt_model.dart';
import '../model/student_model.dart';

class HomeRepository {
  final CollectionReference _allStudentsCollection = FirebaseFirestore.instance.collection(TableNameConstants.students);
  final CollectionReference _feeReceiptsCollection = FirebaseFirestore.instance.collection(TableNameConstants.feeReceipts);

  Future<List<StudentModel>> getAllStudents() async {
    QuerySnapshot querySnapshot = await _allStudentsCollection.get();
    // Map each document to a StudentModel object and return a list
    return querySnapshot.docs
        .map((doc) => StudentModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<StudentModel?> getStudentById(String studentId) async {
    // Get the document from Firestore
    final documentSnapshot =
    await _allStudentsCollection.doc(studentId).get();
    if (documentSnapshot.exists) {
      return StudentModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    }

    // Return null if the document doesn't exist
    return null;
  }

  Future<void> updateStudent(StudentModel studentModel) async {
    if (studentModel.userId == null) {
      throw Exception('Fee receipt ID is null');
    }

    // Update the document in Firestore
    await _allStudentsCollection
        .doc(studentModel.userId)
        .update(studentModel.toMap());
  }




  ///=========================================================================

  Future<List<FeeReceiptModel>> getAllFeeReceipts() async {
    QuerySnapshot querySnapshot = await _feeReceiptsCollection.get();
    return querySnapshot.docs
        .map((doc) => FeeReceiptModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<FeeReceiptModel?> getFeeReceiptById(String feeReceiptId) async {
    // Get the document from Firestore
    final documentSnapshot =
    await _feeReceiptsCollection.doc(feeReceiptId).get();

    // If the document exists, return the FeeReceiptModel object
    if (documentSnapshot.exists) {
      return FeeReceiptModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    }

    // Return null if the document doesn't exist
    return null;
  }

  Future<void> updateFeeReceipt(FeeReceiptModel feeReceiptModel) async {
    if (feeReceiptModel.id == null) {
      throw Exception('Fee receipt ID is null');
    }

    // Update the document in Firestore
    await _feeReceiptsCollection
        .doc(feeReceiptModel.id)
        .update(feeReceiptModel.toMap());
  }


}