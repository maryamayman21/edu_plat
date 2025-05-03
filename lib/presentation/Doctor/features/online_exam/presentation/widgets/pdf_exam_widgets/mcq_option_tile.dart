//import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/pdf_exam_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class McqOptionTile extends StatefulWidget {
  const McqOptionTile({
    super.key,
    required this.qIndex,
    required this.oIndex,
    required this.optionText,
  });

  final int qIndex;
  final int oIndex;
  final String optionText;

  @override
  State<McqOptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<McqOptionTile> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.optionText);
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
        context.read<PDFExamBloc>().add(RemoveOptionEvent(widget.qIndex, widget.oIndex));
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
            onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              context.read<PDFExamBloc>().add(UpdateOptionEvent(widget.qIndex, widget.oIndex, _controller.text));
            },
          ),
        ),

      ),
    );
  }
}