import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/detail_icon_text.dart';
import 'package:edu_platt/presentation/Student/screen/group_chat/groupList/GroupMember.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseHeader extends StatefulWidget {
  const CourseHeader({super.key, required this.courseCode});
  final String courseCode;

  @override
  State<CourseHeader> createState() => _CourseHeaderState();
}

class _CourseHeaderState extends State<CourseHeader>with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  bool _showNotificationDot = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChatPressed() {
    if (_showNotificationDot) {
      setState(() {
        _showNotificationDot = false;
      });
      _controller.stop();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GroupMember(courseCode: widget.courseCode),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: Colors.white,

      flexibleSpace: FlexibleSpaceBar(
          background:   Hero(
            tag: widget.courseCode,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppAssets.courseBackground,
                    ),
                    fit: BoxFit.fill),

                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Center(
                child: Text(widget.courseCode?? 'NULL',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        letterSpacing: 1,
                        fontFamily: 'Roboto-Mono',
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          )
      ),
      leading: Padding(
        padding: const EdgeInsets.only( left: 16.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back , color: Colors.black,)),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: _onChatPressed,
                  icon: const Icon(Icons.chat, color: color.primaryColor),
                ),
              ),
              // if (_showNotificationDot)
              //   Positioned(
              //     top: 1,
              //     child:  Container(
              //         width: 15.w,
              //         height: 20.h,
              //         decoration: const BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: Colors.red,
              //         ),
              //       ),
              //     ),

            ],
          ),
        ),
      ],
    );
  }
}