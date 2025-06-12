import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionTile extends StatefulWidget {
  const OptionTile({
    super.key,
    required this.qIndex,
    required this.oIndex,
    required this.optionText,
    required this.correctOption,
  });

  final int qIndex;
  final int oIndex;
  final String optionText;
  final bool correctOption;

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.optionText);
  }

  @override
  void didUpdateWidget(OptionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update controller when widget properties change
    if (oldWidget.optionText != widget.optionText) {
      _controller.text = widget.optionText;
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 16.w), // Reduced padding
        child: Icon(Icons.delete, color: Colors.white, size: 20.r), // Smaller icon
      ),
      onDismissed: (direction) {
        context.read<OnlineExamBloc>().add(RemoveOptionEvent(widget.qIndex, widget.oIndex));
      },
      child: ListTile(
        title: SizedBox(
          height: 40.h, // Reduced height
          child: TextField(
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16.sp, // Smaller font size
            ),
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter answer',
              hintStyle: TextStyle(
                fontSize: 14.sp, // Smaller font size
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(20.r), // Smaller border radius
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(20.r), // Smaller border radius
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(20.r), // Smaller border radius
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h), // Reduced padding
            ),
            onSubmitted: (newValue) {
              context.read<OnlineExamBloc>().add(UpdateOptionEvent(widget.qIndex, widget.oIndex, newValue));
            },
          ),
        ),
        trailing: Checkbox(
          side: const BorderSide(color: Colors.white),
          checkColor: Colors.white,
          splashRadius: 15.r, // Smaller splash radius
          activeColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r), // Smaller border radius
          ),
          value: widget.correctOption,
          onChanged: (bool? value) {
            context.read<OnlineExamBloc>().add(SelectCorrectAnswerEvent(widget.qIndex, widget.oIndex));
          },
        ),
      ),
    );
  }
}