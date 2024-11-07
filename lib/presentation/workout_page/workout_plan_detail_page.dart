import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'exercise_detail_widget.dart';
import 'training_plan.dart';

class WorkoutPlanDetailPage extends StatefulWidget {
  final TrainingPlan trainingPlan;

  const WorkoutPlanDetailPage({Key? key, required this.trainingPlan}) : super(key: key);

  @override
  _WorkoutPlanDetailPageState createState() => _WorkoutPlanDetailPageState();
}

class _WorkoutPlanDetailPageState extends State<WorkoutPlanDetailPage> {
  int _currentExerciseIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // Initialize the PageController here
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of the controller to free up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the actual number of exercises in the training plan
    int maxExercises = widget.trainingPlan.exercises.length;

    return Scaffold(
      appBar: AppBar(title: Text(widget.trainingPlan.level)),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: maxExercises,
              onPageChanged: (index) {
                setState(() {
                  _currentExerciseIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final exercise = widget.trainingPlan.exercises[index];
                return ExerciseDetailWidget(exercise: exercise);
              },
            ),
          ),
          SizedBox(height: 16),
          // SmoothPageIndicator for navigation dots
          SmoothPageIndicator(
            controller: _pageController,
            count: maxExercises,
            effect: JumpingDotEffect(
              dotHeight: 12,
              dotWidth: 12,
              jumpScale: 1.5,
              spacing: 8,
              activeDotColor: Color(0xFF3C536C), // Adjust this to fit your app theme
              dotColor: Colors.grey.shade400,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
