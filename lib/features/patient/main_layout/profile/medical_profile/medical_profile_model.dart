class MedicalProfileModel {
  final String bloodType;
  final int height;
  final int weight;
  final String allergies;
  final String chronicDiseases;
  final String currentMedications;
  final String emergencyContact;
  final String emergencyPhone;

  MedicalProfileModel({
    required this.bloodType,
    required this.height,
    required this.weight,
    required this.allergies,
    required this.chronicDiseases,
    required this.currentMedications,
    required this.emergencyContact,
    required this.emergencyPhone,
  });

  Map<String, dynamic> toJson() => {
    "bloodType": bloodType,
    "height": height,
    "weight": weight,
    "allergies": allergies,
    "chronicDiseases": chronicDiseases,
    "currentMedications": currentMedications,
    "emergencyContact": emergencyContact,
    "emergencyPhone": emergencyPhone,
  };
}