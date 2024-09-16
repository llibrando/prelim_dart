import 'package:librando_prelim_dart_app/models/grade.dart';

class GradeService {
  double calculateAverage(List<double> scores) {
    if (scores.isEmpty) return 0.0;
    double total = scores.reduce((a, b) => a + b);
    return total / scores.length;
  }

  double calculateCourseOutcome(Grade grade) {
    double averageAT = calculateAverage(grade.assessmentTasks);
    double averageTLA = calculateAverage(grade.teachingLearningActivities);
    return (0.70 * averageAT) + (0.30 * averageTLA);
  }

  double calculateTerminalGrade(Grade grade) {
    double courseOutcome = calculateCourseOutcome(grade);
    return (0.70 * courseOutcome) + (0.30 * grade.finalExamScore);
  }
}