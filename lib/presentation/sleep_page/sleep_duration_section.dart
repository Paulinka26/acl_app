import 'package:flutter/material.dart';
import '../../theme/theme_helper.dart';
import 'package:acl_application/core/utils/size_utils.dart';

class SleepDurationSection extends StatefulWidget {
  final int durationHours;
  final int durationMinutes;
  final bool isDataSaved;
  final Function(int, int) onDurationChanged;

  SleepDurationSection({
    required this.durationHours,
    required this.durationMinutes,
    required this.isDataSaved,
    required this.onDurationChanged,
  });

  @override
  _SleepDurationSectionState createState() => _SleepDurationSectionState();
}

class _SleepDurationSectionState extends State<SleepDurationSection> {
  late int durationHours;
  late int durationMinutes;

  @override
  void initState() {
    super.initState();
    durationHours = widget.durationHours;
    durationMinutes = widget.durationMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHourSpinner(),
              _buildMinuteSpinner(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHourSpinner() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: widget.isDataSaved
              ? null
              : () {
            setState(() {
              if (durationHours > 0) durationHours--;
              widget.onDurationChanged(durationHours, durationMinutes);
            });
          },
        ),
        Text(
          "$durationHours Hours",
          style: theme.textTheme.titleMedium,
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: widget.isDataSaved
              ? null
              : () {
            setState(() {
              durationHours++;
              widget.onDurationChanged(durationHours, durationMinutes);
            });
          },
        ),
      ],
    );
  }

  Widget _buildMinuteSpinner() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: widget.isDataSaved
              ? null
              : () {
            setState(() {
              if (durationMinutes > 0) durationMinutes--;
              widget.onDurationChanged(durationHours, durationMinutes);
            });
          },
        ),
        Text(
          "$durationMinutes Minutes",
          style: theme.textTheme.titleMedium,
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: widget.isDataSaved
              ? null
              : () {
            setState(() {
              durationMinutes += 10;
              widget.onDurationChanged(durationHours, durationMinutes);
            });
          },
        ),
      ],
    );
  }
}
