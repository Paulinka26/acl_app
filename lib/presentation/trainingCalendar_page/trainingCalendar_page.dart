import 'package:acl_application/core/utils/size_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import '../../theme/custom_button_style.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_buttom_navigation.dart';
import '../../widgets/custom_elevated_button.dart';

class TrainingCalendarPage extends StatefulWidget {
  TrainingCalendarPage({Key? key}) : super(key: key);

  @override
  _TrainingCalendarPageState createState() => _TrainingCalendarPageState();
}

class _TrainingCalendarPageState extends State<TrainingCalendarPage> {
  List<DateTime?> selectedDatesFromCalendar = [];
  String _selectedTrainingType = "Stability";
  String _selectedDuration = "30 Minutes";

  List<String> trainingTypes = [
    "Stability",
    "Mobility",
    "Football",
    "Game",
    "Gym",
    "Stretching"
  ];
  List<String> durations = [
    "15 Minutes",
    "30 Minutes",
    "45 Minutes",
    "1 Hour",
    "1.5 Hours"
  ];

  void _addTraining() async {
    if (selectedDatesFromCalendar.isEmpty) {
      // Jeśli nie wybrano daty, nie dodawaj treningu
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please select a date."),
      ));
      return;
    }

    DateTime selectedDate = selectedDatesFromCalendar.first!;
    String formattedDate = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"; // Format YYYY-MM-DD

    try {
      await FirebaseFirestore.instance.collection('trainings').doc(formattedDate).set({
        'type': _selectedTrainingType,
        'duration': _selectedDuration,
        'completed': false,
        'date': formattedDate,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Training added successfully!"),
      ));

      // Opcjonalnie: Wyzerowanie danych po dodaniu
      setState(() {
        _selectedTrainingType = "Stability";
        _selectedDuration = "30 Minutes";
        selectedDatesFromCalendar.clear();
      });
    } catch (e) {
      print("Error adding training: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to add training."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  _buildCalendarSection(context),
                  SizedBox(height: 28.h),
                  _buildSelectedDateSection(context),
                  SizedBox(height: 20.h),
                  _buildTrainingTypeSection(context),
                  SizedBox(height: 20.h),
                  _buildDurationSection(context),
                  SizedBox(height: 20.h),
                  _buildAddTrainingButton(context),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarSection(BuildContext context) {
    return Container(
      height: 214.h,
      width: 298.h,
      margin: EdgeInsets.symmetric(horizontal: 12.h),
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          calendarType: CalendarDatePicker2Type.single,
          firstDate: DateTime(DateTime.now().year - 5),
          lastDate: DateTime(DateTime.now().year + 5),
          selectedDayHighlightColor: Color(0xFFFF5582),
          firstDayOfWeek: 1,
          weekdayLabelTextStyle: TextStyle(
            color: theme.colorScheme.secondaryContainer,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
          selectedDayTextStyle: TextStyle(
            color: Color(0xFFFCFCFC),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
          dayTextStyle: TextStyle(
            color: theme.colorScheme.secondaryContainer,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
          weekdayLabels: ["SU", "MO", "TU", "WE", "TH", "FR", "SA"],
        ),
        value: selectedDatesFromCalendar,
        onValueChanged: (dates) {
          setState(() {
            selectedDatesFromCalendar = dates;
          });
        },
      ),
    );
  }

  Widget _buildSelectedDateSection(BuildContext context) {
    String selectedDate = selectedDatesFromCalendar.isNotEmpty &&
        selectedDatesFromCalendar.first != null
        ? "${selectedDatesFromCalendar.first!.day}/${selectedDatesFromCalendar.first!.month}/${selectedDatesFromCalendar.first!.year}"
        : "No Date Selected";

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: Text(
        "Selected Date: $selectedDate",
        style: theme.textTheme.bodyLarge,
      ),
    );
  }

  Widget _buildTrainingTypeSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Training Type:",
            style: theme.textTheme.bodyLarge,
          ),
          DropdownButton<String>(
            value: _selectedTrainingType,
            isExpanded: true,
            onChanged: (String? newValue) {
              setState(() {
                _selectedTrainingType = newValue!;
              });
            },
            items: trainingTypes.map((String type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(type),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Duration:",
            style: theme.textTheme.bodyLarge,
          ),
          DropdownButton<String>(
            value: _selectedDuration,
            isExpanded: true,
            onChanged: (String? newValue) {
              setState(() {
                _selectedDuration = newValue!;
              });
            },
            items: durations.map((String duration) {
              return DropdownMenuItem<String>(
                value: duration,
                child: Text(duration),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddTrainingButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: CustomElevatedButton(
        height: 44.h,
        width: 200.h,
        text: "Add Training",
        buttonStyle: CustomButtonStyles.fillPrimary,
        buttonTextStyle: CustomTextStyles.titleSmallBold,
        onPressed: _addTraining,
      ),
    );
  }
}
