class MedicalReport {
  final String id;
  final String doctorId;
  final String patientId;
  final String appointmentId;
  final String sessionRemark;
  final Map<String, dynamic> reports;
  final String reportLinks;
  final String revisitAdvice;
  final DateTime createdDate;
  final Doctor1 doctor;

  MedicalReport({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.appointmentId,
    required this.sessionRemark,
    required this.reports,
    required this.reportLinks,
    required this.revisitAdvice,
    required this.createdDate,
    required this.doctor,
  });

  factory MedicalReport.fromJson(Map<String, dynamic> json) {
    return MedicalReport(
      id: json['_id'],
      doctorId: json['doctorId'],
      patientId: json['patientId'],
      appointmentId: json['appointmentId'],
      sessionRemark: json['sessionRemark'],
      reports: json['reports'],
      reportLinks: json['reportLinks'],
      revisitAdvice: json['revisitAdvice'],
      createdDate: DateTime.parse(json['createdDate']),
      doctor: Doctor1.fromJson(json['doctor']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      '_id': id,
      'doctorId': doctorId,
      'patientId': patientId,
      'appointmentId': appointmentId,
      'sessionRemark': sessionRemark,
      'reports': reports,
      'reportLinks': reportLinks,
      'revisitAdvice': revisitAdvice,
      'createdDate': createdDate.toUtc().toIso8601String(),
      'doctor': doctor.toJson(),
    };
    return data;
  }
}

class Doctor1 {
  final String id;
  final String doctorName;
  final String doctorEmail;
  final String doctorMobileNo;
  final String doctorPassword;
  final String doctorQualification;
  final String doctorSpecialization;
  final DateTime createdDate;

  Doctor1({
    required this.id,
    required this.doctorName,
    required this.doctorEmail,
    required this.doctorMobileNo,
    required this.doctorPassword,
    required this.doctorQualification,
    required this.doctorSpecialization,
    required this.createdDate,
  });

  factory Doctor1.fromJson(Map<String, dynamic> json) {
    return Doctor1(
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      '_id': id,
      'doctorName': doctorName,
      'doctorEmail': doctorEmail,
      'doctorMobileNo': doctorMobileNo,
      'doctorPassword': doctorPassword,
      'doctorQualification': doctorQualification,
      'doctorSpecialization': doctorSpecialization,
      'createdDate': createdDate.toUtc().toIso8601String(),
    };
    return data;
  }
}
