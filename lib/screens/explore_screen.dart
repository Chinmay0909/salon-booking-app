import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/home/header_section.dart';
import '../widgets/explore/specialists_section.dart';
import '../widgets/explore/near_you_section.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderSection(),
              const SizedBox(height: 24),
              const SpecialistsSection(),
              const SizedBox(height: 32),
              const NearYouSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}