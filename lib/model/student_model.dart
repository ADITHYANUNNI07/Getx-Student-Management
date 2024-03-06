class StudentModel {
  final String uid;
  final String name;
  final int admissionNo;
  final int rollNo;
  final String className;
  final dynamic phoneNo;
  final String photoUrl;

  StudentModel(
      {required this.uid,
      required this.name,
      required this.admissionNo,
      required this.rollNo,
      required this.className,
      required this.phoneNo,
      required this.photoUrl});
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'studentname': name,
      'admissionNo': admissionNo,
      'rollNo': rollNo,
      'class': className,
      'phonenumber': phoneNo,
      'imagesrc': photoUrl,
    };
  }

  static StudentModel fromMap(Map<String, dynamic> map) {
    return StudentModel(
      uid: map['uid'],
      name: map['studentname'],
      admissionNo: map['admissionNo'],
      rollNo: map['rollNo'],
      className: map['class'],
      phoneNo: map['phonenumber'],
      photoUrl: map['imagesrc'],
    );
  }
}
