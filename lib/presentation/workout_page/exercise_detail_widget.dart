import 'package:flutter/material.dart';
import 'training_plan.dart';

class ExerciseDetailWidget extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailWidget({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF3C536C), // Background color of the main container
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // New Container for the exercise name and description
          Container(
            width: 350,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFF869FB5), // Background color for the name and description box
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  exercise.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Placeholder for a potential video or image
          Container(
            height: 150,
            color: Colors.grey[300],
            child: Center(
              child: Text(
                "Video Placeholder",
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
          SizedBox(height: 20), // Spacer before the sets and repetitions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCircleContainer("Sets: ${exercise.sets}"),
              _buildCircleContainer("Repetitions: ${exercise.repetitions}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleContainer(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        color: Color(0xFFF55022),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
