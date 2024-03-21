class Doctor {
  String id;
  String doctorName;
  String doctorEmail;
  String doctorMobileNo;
  String doctorPassword;
  String doctorQualification;
  String doctorSpecialization;
  DateTime createdDate;

  Doctor({
    required this.id,
    required this.doctorName,
    required this.doctorEmail,
    required this.doctorMobileNo,
    required this.doctorPassword,
    required this.doctorQualification,
    required this.doctorSpecialization,
    required this.createdDate,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'],
      doctorName: json['doctorName'],
      doctorEmail: json['doctorEmail'],
      doctorMobileNo: json['doctorMobileNo'],
      doctorPassword: json['doctorPassword'],
      doctorQualification: json['doctorQualification'],
      doctorSpecialization: json['doctorSpecialization'],
      createdDate: DateTime.parse(json['createdDate']),
    );
  }
}
