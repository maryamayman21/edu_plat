import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/custom_question_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionsList extends StatefulWidget {
  final List<String> optionTexts;
  final Function(int) onRemoveOption;
  final Function(int, bool?) onChanged; // Updated to include index
  final int? correctAnswerIndex; // Track the index of the correct answer

  const OptionsList({
    super.key,
    required this.optionTexts,
    required this.onRemoveOption,
    required this.onChanged,
    this.correctAnswerIndex,
  });

  @override
  State<OptionsList> createState() => _OptionsListState();
}

class _OptionsListState extends State<OptionsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.optionTexts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: CustomQuestionField(
            isCourseCode: false,
            hintText: 'Enter answer',
            validator: (input) => input?.trim().isEmpty ?? true ? 'Enter valid option' : null,
            labelText: 'Option ${index + 1}',
            value: widget.optionTexts[index],
            onChanged: (value) => widget.optionTexts[index] = value,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.remove, color: Colors.red, size: 24.r),
                onPressed: () => widget.onRemoveOption(index),
              ),
              Checkbox(
                side: const BorderSide(color: Colors.blue),
                checkColor: Colors.white,
                splashRadius: 15.r,
                activeColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                value: widget.correctAnswerIndex == index, // Check if this option is the correct one
                onChanged: (value) {
                  // Notify the parent widget about the change
                  widget.onChanged(index, value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}