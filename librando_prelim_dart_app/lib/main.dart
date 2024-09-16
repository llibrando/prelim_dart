import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'provider/grade_p.dart';
import 'models/grade.dart';
import 'service/grade_s.dart';

void main() {
  final container = ProviderContainer();
  final gradeNotifier = container.read(gradeProvider.notifier);
  GradeCalculatorApp(gradeNotifier).run();
}

class GradeCalculatorApp {
  final GradeNotifier gradeNotifier;

  GradeCalculatorApp(this.gradeNotifier);

  void run() {
    print("Welcome to the Terminal Grade Calculator!");

    // Input for Assessment Tasks
    while (true) {
      print("Enter the score for an Assessment Task (or type 'done' to finish):");
      String? input = stdin.readLineSync();
      if (input?.toLowerCase() == 'done') break;

      // Validate input
      if (input != null && _isNumeric(input)) {
        double score = double.parse(input);
        gradeNotifier.addAssessmentTask(score);
      } else {
        print("Invalid input. Please enter a numeric value.");
      }
    }

    // Input for Teaching Learning Activities
    while (true) {
      print("Enter the score for a Teaching Learning Activity (or type 'done' to finish):");
      String? input = stdin.readLineSync();
      if (input?.toLowerCase() == 'done') break;

      // Validate input
      if (input != null && _isNumeric(input)) {
        double score = double.parse(input);
        gradeNotifier.addTeachingLearningActivity(score);
      } else {
        print("Invalid input. Please enter a numeric value.");
      }
    }

    // Input for Final Exam
    print("Enter the score for the Final Exam:");
    String? finalExamInput = stdin.readLineSync();
    if (finalExamInput != null && _isNumeric(finalExamInput)) {
      double finalExamScore = double.parse(finalExamInput);
      gradeNotifier.setFinalExamScore(finalExamScore);
    } else {
      print("Invalid input. Please enter a numeric value.");
    }

    // Calculate and display results
    double terminalGrade = gradeNotifier.getTerminalGrade();
    print("Your Terminal Grade is: ${terminalGrade.toStringAsFixed(2)}");
  }

  // Helper function to check if the input is numeric
  bool _isNumeric(String str) {
    return double.tryParse(str) != null;
  }
}