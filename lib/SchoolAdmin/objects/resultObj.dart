class ResultObj {
  final logo;
  final schoolName;
  final Map signatures;
  final List marks;
  final Map studentInfo;
  final schoolAddress;
  final examDetails;
  final gpa;
  final remarks;
  final String prncipal;
  final String exam_coordinator;
  final String class_teacher;
  final String exam_date;

  ResultObj(
      this.logo,
      this.schoolName,
      this.signatures,
      this.marks,
      this.studentInfo,
      this.schoolAddress,
      this.examDetails,
      this.gpa,
      this.remarks,
      {required this.prncipal,
      required this.exam_coordinator,
      required this.class_teacher,
      required this.exam_date});
}
