class FacultyModel {
  String? id;
  String? facultyName;
  String? receiptType;
  bool? isFacultyVerified;
  String? email;

  FacultyModel({
    this.id,
    this.facultyName,
    this.receiptType,
    this.isFacultyVerified,
    this.email,
  });

  FacultyModel copyWith({
    String? id,
    String? facultyName,
    String? receiptType,
    bool? isFacultyVerified,
    String? email,
  }) {
    return FacultyModel(
      id: id ?? this.id,
      facultyName: facultyName ?? this.facultyName,
      receiptType: receiptType ?? this.receiptType,
      isFacultyVerified: isFacultyVerified ?? this.isFacultyVerified,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'facultyName': this.facultyName,
      'receiptType': this.receiptType,
      'isFacultyVerified': this.isFacultyVerified,
      'email': this.email,
    };
  }

  factory FacultyModel.fromMap(Map<String, dynamic> map) {
    return FacultyModel(
      id: map['id'] as String? ?? "",
      facultyName: map['facultyName'] as String? ?? "",
      receiptType: map['receiptType'] as String? ?? "",
      isFacultyVerified: map['isFacultyVerified'] as bool? ?? false,
      email: map['email'] as String? ?? "",
    );
  }
}