class SchoolInfo {
  final String enrollment;
  final String name;
  final String id;
  final String userName;
  final String date;
  final String logo;

  SchoolInfo(
      {required this.enrollment,
      required this.name,
      required this.id,
      required this.userName,
      required this.date,
      required this.logo});
}

class StaffInfo {
  final schoolName;

  final String name;
  final String id;

  final String date;
  final String logo;

  StaffInfo(
      {required this.schoolName,
      required this.name,
      required this.id,
      required this.date,
      required this.logo});
}
