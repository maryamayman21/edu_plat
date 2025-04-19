import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:flutter/material.dart';

class CourseHeader extends StatelessWidget {
  const CourseHeader({super.key, required this.courseCode});
  final String courseCode;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: Colors.white,

      flexibleSpace: FlexibleSpaceBar(
          background:   Hero(
            tag: courseCode,
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
                child: Text(courseCode?? 'NULL',
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
    );
  }
}