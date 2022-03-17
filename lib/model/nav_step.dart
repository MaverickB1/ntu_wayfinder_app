class NavStep {
  NavStep(
      {required this.stepId,
      required this.imageUrl,
      required this.instruction});

  final int stepId;
  String imageUrl;
  final String instruction;

  factory NavStep.fromJson(Map<String, dynamic> jsonData) {
    return NavStep(
      stepId: jsonData['stepId'] as int,
      imageUrl: jsonData['imageUrl'] as String,
      instruction: jsonData['instruction'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'stepId': stepId,
        'imageUrl': imageUrl,
        'instruction': instruction,
      };
}
