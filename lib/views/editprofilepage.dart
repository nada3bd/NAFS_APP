import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/profilecubit.dart';
import 'package:grad_app/models/profilestate.dart';
import 'package:grad_app/widgets/actionbutton.dart';
import 'package:grad_app/widgets/customsafearea.dart';
import 'package:grad_app/widgets/profileimageheader.dart';
import 'package:grad_app/widgets/textfield.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  final String accountType;
  const EditProfileScreen({super.key, required this.accountType});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final ScrollController scrollController = ScrollController();

  Future<void> _selectDate(BuildContext context, ProfileCubit cubit) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: cubit.state.dob,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.teal,
              onPrimary: Colors.white,
              onSurface: Colors.teal,
              surface: Colors.white,
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.teal),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) cubit.updateDob(picked);
  }

  Future<void> _selectTime(BuildContext context, ProfileCubit cubit) async {
    final Duration? picked = await showDurationPicker(
      context: context,
      initialTime: const Duration(hours: 0, minutes: 0),
    );

    if (picked != null) {
      final durationString = _formatDuration(picked);
      cubit.updateSessionTime(durationString);
    }
  }

  String _formatDuration(Duration duration) {
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);
    if (hours > 0 && minutes > 0) return '$hours hour(s) $minutes min';
    if (hours > 0) return '$hours hour(s)';
    return '$minutes min';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomSafeArea(color: Colors.teal),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final cubit = context.read<ProfileCubit>();
            final isPatient = widget.accountType == 'patient';
            final isDoctor = widget.accountType == 'doctor';
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ProfileImageHeader(
                    cubit: cubit,
                    state: state,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: "Full Name",
                    value: state.name,
                    icon: Icons.person,
                    onChanged: (v) => cubit.updateName(v),
                    scrollController: scrollController,
                  ),
                  CustomTextField(
                    label: "Gender",
                    value: state.gender,
                    icon: Icons.wc,
                    onChanged: (v) => cubit.updateGender(v),
                    readOnly: true,
                    scrollController: scrollController,
                  ),
                  CustomTextField(
                    label: "Email",
                    value: state.email,
                    icon: Icons.email,
                    onChanged: (v) => cubit.updateEmail(v),
                    scrollController: scrollController,
                  ),
                  CustomTextField(
                    label: "Birthday",
                    value: DateFormat('yyyy-MM-dd').format(state.dob),
                    icon: Icons.calendar_today,
                    onChanged: (_) {},
                    readOnly: true,
                    onTap: () => _selectDate(context, cubit),
                    isPatient: isPatient,
                    dateofbirth: state.dob,
                    scrollController: scrollController,
                  ),
                  if (isPatient) ...[
                    CustomTextField(
                      label: "Marital Status",
                      value: state.maritalStatus,
                      icon: Icons.favorite,
                      onChanged: (v) => cubit.updateMaritalStatus(v),
                      scrollController: scrollController,
                    ),
                    CustomTextField(
                      label: "Medical Conditions",
                      value: state.medicalConditions,
                      icon: Icons.healing,
                      onChanged: (v) => cubit.updateMedicalConditions(v),
                      scrollController: scrollController,
                    ),
                    CustomTextField(
                      label: "Education Level",
                      value: state.educationLevel,
                      icon: Icons.school,
                      onChanged: (v) => cubit.updateEducation(v),
                      scrollController: scrollController,
                    ),
                  ],
                  if (isDoctor) ...[
                    CustomTextField(
                      label: "About Me",
                      value: state.aboutMe,
                      icon: Icons.description,
                      onChanged: (v) => cubit.updateAbout(v),
                      scrollController: scrollController,
                    ),
                    CustomTextField(
                      label: "Session Time",
                      value: state.sessionTime,
                      icon: Icons.timer,
                      onChanged: (_) {},
                      onTap: () => _selectTime(context, cubit),
                      scrollController: scrollController,
                      readOnly: true,
                    ),
                    CustomTextField(
                      label: "Price",
                      value: state.price,
                      icon: Icons.attach_money,
                      onChanged: (v) => cubit.updatePrice(v),
                      scrollController: scrollController,
                    ),
                    CustomTextField(
                      label: "Location",
                      value: state.location,
                      icon: Icons.location_on,
                      onChanged: (v) => cubit.updateLocation(v),
                      scrollController: scrollController,
                    ),
                  ],
                  const SizedBox(height: 24),
                  ActionButton( value: 'Save',),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

