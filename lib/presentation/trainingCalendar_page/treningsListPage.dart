import 'package:acl_application/core/utils/size_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../theme/theme_helper.dart';

class TrainingsListPage extends StatefulWidget {
  @override
  _TrainingsListPageState createState() => _TrainingsListPageState();
}

class _TrainingsListPageState extends State<TrainingsListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('trainings').orderBy('date', descending: true).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              List<Map<String, dynamic>> trainings = snapshot.data!.docs.map((doc) {
                return {
                  'id': doc.id,
                  'date': doc['date'],
                  'type': doc['type'],
                  'duration': doc['duration'],
                  'completed': doc['completed'],
                };
              }).toList();

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.h),
                itemCount: trainings.length,
                itemBuilder: (context, index) {
                  final training = trainings[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(16.h),
                    decoration: BoxDecoration(
                      color: training['completed']
                          ? theme.colorScheme.primary.withOpacity(0.1)
                          : theme.colorScheme.background,
                      borderRadius: BorderRadius.circular(12.h),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6.h,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date: ${training['date']}",
                                style: theme.textTheme.bodyLarge,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Type: ${training['type']}",
                                style: theme.textTheme.bodyMedium,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Duration: ${training['duration']}",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Checkbox(
                          value: training['completed'],
                          onChanged: (bool? value) {
                            // Zaktualizuj stan treningu w Firestore
                            _updateTrainingStatus(training['id'], value ?? false);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _updateTrainingStatus(String trainingId, bool completed) async {
    await FirebaseFirestore.instance.collection('trainings').doc(trainingId).update({'completed': completed});
    // Odśwież lokalny stan, jeśli to konieczne
    setState(() {}); // Umożliwia ponowne zbudowanie widoku
  }
}
