import 'package:flutter/material.dart';
import 'package:grad_app/cubit/profilecubit.dart';
import 'package:grad_app/models/profilestate.dart';
import 'package:grad_app/widgets/textfield.dart';
import 'package:intl/intl.dart';

class BirthdayPicker extends StatelessWidget {
  final ProfileState state;
  final ProfileCubit cubit;

  const BirthdayPicker({super.key, required this.state, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (context, child) => Theme(
            data: ThemeData.light().copyWith(colorScheme: const ColorScheme.light(primary: Colors.teal)),
            child: child!,
          ),
        );
        if (picked != null) cubit.updateDob(picked);
      },
      child: AbsorbPointer(
        child: CustomTextField(
          label: "Birthday",
          value: state.dob == null ? '' : DateFormat('yyyy-MM-dd').format(state.dob!),
          icon: Icons.calendar_today,
          onChanged: (_) {},
        ),
      ),
    );
  }
}