import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/custom_question_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class McqOptionsList extends StatefulWidget {
  final List<String> optionTexts;
  final Function(int) onRemoveOption;
  final bool isWritten;
  const McqOptionsList({
    super.key,
    required this.optionTexts,
    required this.onRemoveOption, required this.isWritten,
  });

  @override
  State<McqOptionsList> createState() => _OptionsListState();
}

class _OptionsListState extends State<McqOptionsList> {
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
            hintText: widget.isWritten ? 'Enter question' : 'Enter answer',
            validator: (input) => input?.trim().isEmpty ?? true ? 'Enter valid option' : null,
            labelText: widget.isWritten ? 'Question ${index + 1}': 'Option ${index + 1}',
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
            ],
          ),
        );
      },
    );
  }
}