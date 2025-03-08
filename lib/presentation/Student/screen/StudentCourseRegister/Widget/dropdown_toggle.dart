import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/Cubit/dropdown_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/Cubit/dropdown_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/Color/color.dart';

class DropdownToggle extends StatelessWidget {
  final String id; // Unique identifier for the dropdown

  const DropdownToggle({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<DropdownCubit>().toggleDropdown(id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15, top: 15),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 2.0, // Spread radius
              blurRadius: 3.0, // Blur radius
              offset:
                  const Offset(1, 6), // Shadow position (horizontal, vertical)
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: color.primaryColor, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              id, // Title or label for this dropdown
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: color.primaryColor,
                  fontSize: 22,
                  letterSpacing: 2,
                  fontFamily: 'Roboto-Mono'),
            ),
            BlocBuilder<DropdownCubit, DropdownState>(
                builder: (context, state) {

                return Icon(
                  state.isExpanded[id] == true
                      ? Icons.expand_less
                      : Icons.expand_more,
                  color: color.primaryColor,
                );

            }),
          ],
        ),
      ),
    );
  }
}
