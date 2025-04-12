import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/profilecubit.dart';
import 'package:grad_app/models/usermodel.dart';
import 'package:grad_app/widgets/customsafearea.dart';
import 'package:grad_app/widgets/textfield.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  final String accountType;
  const EditProfileScreen({Key? key, required this.accountType}) : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}
  
class _EditProfileScreenState extends State<EditProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  Future<void> _selectDate(BuildContext context, ProfileCubit cubit) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: cubit.state.dob,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.teal, onPrimary: Colors.white, onSurface: Colors.teal, surface: Colors.white),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.teal)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) cubit.updateDob(picked);
  }
  Future<void> _selectTime(BuildContext context, ProfileCubit cubit) async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) cubit.updateSessionTime(picked.format(context));
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
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          top: -7,
                          left: -7,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () => cubit.pickProfileImage(),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.teal,
                              backgroundImage: state.profileImage != null ? FileImage(state.profileImage!) : null,
                              child: state.profileImage == null ? const Icon(Icons.camera_alt, size: 40, color: Colors.black) : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: "Full Name",
                    value: state.name,
                    icon: Icons.person,
                    onChanged: (v) => cubit.updateName(v),
                    scrollController: _scrollController,
                  ),
                  CustomTextField(
                    label: "Gender",
                    value: state.gender,
                    icon: Icons.wc,
                    onChanged: (v) => cubit.updateGender(v),
                    readOnly: true,
                    scrollController: _scrollController,
                  ),
                  CustomTextField(
                    label: "Email",
                    value: state.email,
                    icon: Icons.email,
                    onChanged: (v) => cubit.updateEmail(v),
                    scrollController: _scrollController,
                  ),
                  CustomTextField(
                    label: "Birthday",
                    value: DateFormat('yyyy-MM-dd').format(state.dob),
                    icon: Icons.calendar_today,
                    onChanged: (_) {},
                    readOnly: true,
                    onTap: () => _selectDate(context, cubit),
                    isPatient: isPatient,
                    dateOfBirth: state.dob,
                    scrollController: _scrollController,
                  ),
                  if (isPatient) ...[
                    CustomTextField(
                      label: "Marital Status",
                      value: state.maritalStatus,
                      icon: Icons.favorite,
                      onChanged: (v) => cubit.updateMaritalStatus(v),
                      scrollController: _scrollController,
                    ),
                    CustomTextField(
                      label: "Medical Conditions",
                      value: state.medicalConditions,
                      icon: Icons.healing,
                      onChanged: (v) => cubit.updateMedicalConditions(v),
                      scrollController: _scrollController,
                    ),
                    CustomTextField(
                      label: "Education Level",
                      value: state.educationLevel,
                      icon: Icons.school,
                      onChanged: (v) => cubit.updateEducation(v),
                      scrollController: _scrollController,
                    ),
                  ],
                  if (isDoctor) ...[
                    CustomTextField(
                      label: "About Me",
                      value: state.aboutMe,
                      icon: Icons.description,
                      onChanged: (v) => cubit.updateAbout(v),
                      maxLines: 4,
                      scrollController: _scrollController,
                    ),
                    CustomTextField(
                      label: "Session Time",
                      value: state.sessionTime,
                      icon: Icons.access_time,
                      onChanged: (_) {},
                      readOnly: true,
                      onTap: () => _selectTime(context, cubit),
                      scrollController: _scrollController,
                    ),
                    CustomTextField(
                      label: "Price",
                      value: state.price,
                      icon: Icons.attach_money,
                      onChanged: (v) => cubit.updatePrice(v),
                      scrollController: _scrollController,
                    ),
                    CustomTextField(
                      label: "Location",
                      value: state.location,
                      icon: Icons.location_on,
                      onChanged: (v) => cubit.updateLocation(v),
                      scrollController: _scrollController,
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Save', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
