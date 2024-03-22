class UserModel {
  String id;
  String patientName;
  String patientEmail;
  String patientMobileNo;
  String patientPassword;
  String weight;
  dynamic disability;
  dynamic geneticDisorder;
  String bloodGroup;
  dynamic otherDisease;
  DateTime createdDate;

  UserModel({
    required this.id,
    required this.patientName,
    required this.patientEmail,
    required this.patientMobileNo,
    required this.patientPassword,
    required this.weight,
    required this.disability,
    required this.geneticDisorder,
    required this.bloodGroup,
    required this.otherDisease,
    required this.createdDate,
  });

  UserModel copyWith({
    String? id,
    String? patientName,
    String? patientEmail,
    String? patientMobileNo,
    String? patientPassword,
    String? weight,
    dynamic disability,
    dynamic geneticDisorder,
    String? bloodGroup,
    dynamic otherDisease,
    DateTime? createdDate,
  }) =>
      UserModel(
        id: id ?? this.id,
        patientName: patientName ?? this.patientName,
        patientEmail: patientEmail ?? this.patientEmail,
        patientMobileNo: patientMobileNo ?? this.patientMobileNo,
        patientPassword: patientPassword ?? this.patientPassword,
        weight: weight ?? this.weight,
        disability: disability ?? this.disability,
        geneticDisorder: geneticDisorder ?? this.geneticDisorder,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        otherDisease: otherDisease ?? this.otherDisease,
        createdDate: createdDate ?? this.createdDate,
      );
}
