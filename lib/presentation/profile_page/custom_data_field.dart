import 'package:acl_application/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import '../../theme/theme_helper.dart';

class CustomDataField extends StatelessWidget {
  final String label;
  final String value;
  final Function onIncrement;
  final Function onDecrement;

  const CustomDataField({
    Key? key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 8),
      height: 40.h,
      decoration: BoxDecoration(
        color: appTheme.blueGray50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => onDecrement(),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => onIncrement(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
