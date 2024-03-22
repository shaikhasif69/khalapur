class MedicalReport {
  String id;
  String doctorId;
  String patientId;
  String appointmentId;
  String sessionRemark;
  Reports reports;
  String reportLinks;
  String revisitAdvice;
  DateTime createdDate;

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
  });
}

class Reports {
  Reports();
}
