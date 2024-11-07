class TrainingPlan {
  final String description;
  final String level;
  final List<Exercise> exercises;

  TrainingPlan({
    required this.description,
    required this.level,
    required this.exercises,
  });
}

class Exercise {
  final String name;
  final String description;
  final int repetitions;
  final int sets;

  Exercise({
    required this.name,
    required this.description,
    required this.repetitions,
    required this.sets,
  });
}
