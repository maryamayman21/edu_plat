class GpaModel {
  final double gpa;


  GpaModel({ required this.gpa});

  factory GpaModel.fromJson(Map<String, dynamic> json) {
    return GpaModel(
      gpa: json['gpa']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gpa': gpa,
    };
  }
}