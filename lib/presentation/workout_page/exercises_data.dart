import 'training_plan.dart';

List<TrainingPlan> getTrainingPlans() {
  return [
    TrainingPlan(
      description: "Strength training for stabilizing knee and hip muscles.",
      level: "Beginner",
      exercises: [
        Exercise(name: "Dynamic march with high knees", description: "Warm-up exercise", repetitions: 10, sets: 3),
        Exercise(name: "Bodyweight squats", description: "Strengthens lower body", repetitions: 12, sets: 3),
        Exercise(name: "Push-ups", description: "Strengthens upper body", repetitions: 10, sets: 3),
      ],
    ),
    TrainingPlan(
      description: "Intermediate exercises for muscle building.",
      level: "Intermediate",
      exercises: [
        Exercise(name: "Dumbbell bench press", description: "Strengthens chest", repetitions: 10, sets: 3),
        Exercise(name: "Lunges", description: "Strengthens legs", repetitions: 12, sets: 3),
        Exercise(name: "Pull-ups", description: "Strengthens back", repetitions: 8, sets: 3),
      ],
    ),
    TrainingPlan(
      description: "Advanced muscle strengthening and plyometric exercises.",
      level: "Advanced",
      exercises: [
        Exercise(name: "Jump rope", description: "Improves coordination", repetitions: 0, sets: 5),
        Exercise(name: "Barbell deadlifts", description: "Full-body strength exercise", repetitions: 10, sets: 3),
        Exercise(name: "Box jumps", description: "Explosive leg strength", repetitions: 10, sets: 3),
      ],
    ),
  ];
}
