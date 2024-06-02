class FacultyModel {
  String? id;
  String? facultyName;
  String? facultyType;
  String? facultyAssociateWith;
  bool? isFacultyVerified;
  String? email;

  FacultyModel({
    this.id,
    this.facultyName,
    this.facultyType,
    this.facultyAssociateWith,
    this.isFacultyVerified,
    this.email,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'facultyName': this.facultyName,
      'facultyType': this.facultyType,
      'facultyAssociateWith': this.facultyAssociateWith,
      'isFacultyVerified': this.isFacultyVerified,
      'email': this.email,
    };
  }

  factory FacultyModel.fromMap(Map<String, dynamic> map) {
    return FacultyModel(
      id: map['id'] as String? ?? "",
      facultyName: map['facultyName'] as String? ?? "",
      facultyType: map['facultyType'] as String? ?? "",
      facultyAssociateWith: map['facultyAssociateWith'] as String? ?? "",
      isFacultyVerified: map['isFacultyVerified'] as bool? ?? false,
      email: map['email'] as String? ?? "",
    );
  }

  FacultyModel copyWith({
    String? id,
    String? facultyName,
    String? facultyType,
    String? facultyAssociateWith,
    bool? isFacultyVerified,
    String? email,
  }) {
    return FacultyModel(
      id: id ?? this.id,
      facultyName: facultyName ?? this.facultyName,
      facultyType: facultyType ?? this.facultyType,
      facultyAssociateWith: facultyAssociateWith ?? this.facultyAssociateWith,
      isFacultyVerified: isFacultyVerified ?? this.isFacultyVerified,
      email: email ?? this.email,
    );
  }
}