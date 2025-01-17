
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profilefield extends StatefulWidget {
  String title;
  String value;
  bool isEditable;
  final Widget? child;

  Profilefield({
    required this.title,
    required this.value,
    required this.isEditable,
    this.child,
  });

  @override
  State<Profilefield> createState() => _ProfilefieldState();
}

class _ProfilefieldState extends State<Profilefield> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.only(top: 4),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: widget.child != null
                ? widget.child! // عرض child إذا كان موجودًا
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _isEditing
                            ? Padding(
                                padding: REdgeInsets.all(6.0),
                                child: TextField(
                                  controller: _controller,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                      ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.all(20.w),
                                child: Text(
                                  _controller.text,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.grey,
                                        fontSize: 15.sp,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                      ),
                      if (widget.isEditable)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isEditing = !_isEditing;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                              _isEditing
                                  ? Icons.check
                                  : Icons.keyboard_arrow_down,
                              size: 30.sp,
                              color: color.primaryColor,
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
