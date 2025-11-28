import 'package:flutter/material.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/specialization_selection.dart';

import 'doctor_selection.dart';

class AppointmentScreen extends StatefulWidget {
  static const String routeName = "AppointmentScreen";
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int _currentStep = 0;

  String _selectedSpecialty = "";
  String _selectedSpecialtyIcon = "";
  String _selectedTitle = "";

  void _nextStep({String? specialty, String? title, String? icon}) {
    _selectedSpecialty = specialty ?? _selectedSpecialty;
    _selectedTitle = title ?? _selectedTitle;
    _selectedSpecialtyIcon = icon ?? _selectedSpecialtyIcon;

    if (_currentStep < 1) setState(() => _currentStep++);
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentStep,
        children: [
          SpecializationSelection(
            selectedSpecialty: _selectedSpecialty,
            onSelectSpecialization: _nextStep,
            onBack: _previousStep,
          ),
          DoctorSelection(
            selectedSpecialty: _selectedTitle,
            selectedIcon: _selectedSpecialtyIcon,
            selectedSpecialtyId: _selectedSpecialty,
            onBack: _previousStep,
          ),
        ],
      ),
    );
  }
}
