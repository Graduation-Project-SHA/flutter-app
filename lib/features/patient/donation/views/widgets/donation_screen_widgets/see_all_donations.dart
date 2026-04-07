import 'package:flutter/material.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/custom_appbar.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/donation_screen_widgets/List_of_donation.dart';

class SeeAllDonations extends StatelessWidget {
  const SeeAllDonations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'كل التبرعات'),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 25, vertical: 10),
          child: ListOfDonation(),
        )),
    );
  }
}