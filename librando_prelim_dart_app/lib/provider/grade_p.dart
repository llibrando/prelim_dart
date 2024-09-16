import 'package:librando_prelim_dart_app/models/grade.dart';
import 'package:librando_prelim_dart_app/service/grade_s.dart';
import 'package:riverpod/riverpod.dart';
final gradeServiceProvider = Provider((ref) => GradeService());

final gradeProvider = StateNotifierProvider<GradeNotifier, Grade>((ref) {
  return GradeNotifier(ref.read(gradeServiceProvider));
});

class GradeNotifier extends StateNotifier<Grade> {
  GradeNotifier(this._gradeService)
      : super(Grade(assessmentTasks: [], teachingLearningActivities: [], finalExamScore: 0));

  final GradeService _gradeService;

  set assessmentTaskScores(List<double> assessmentTaskScores) {}

  void addAssessmentTask(double score) {
    state = Grade(
      assessmentTasks: [...state.assessmentTasks, score],
      teachingLearningActivities: state.teachingLearningActivities,
      finalExamScore: state.finalExamScore,
    );
  }

  void addTeachingLearningActivity(double score) {
    state = Grade(
      assessmentTasks: state.assessmentTasks,
      teachingLearningActivities: [...state.teachingLearningActivities, score],
      finalExamScore: state.finalExamScore,
    );
  }

  void setFinalExamScore(double score) {
    state = Grade(
      assessmentTasks: state.assessmentTasks,
      teachingLearningActivities: state.teachingLearningActivities,
      finalExamScore: score,
    );
  }

  double getTerminalGrade() {
    return _gradeService.calculateTerminalGrade(state);
  }

  void setTeachingLearningActivityScores(List<double> teachingLearningActivityScores) {}
}