import 'package:flutter/material.dart';
import 'widgets/detail/header.dart';
import 'widgets/detail/info_card.dart';
import 'widgets/detail/action_buttons.dart';
import 'widgets/detail/bottom_cta.dart';

class InsuranceDetailScreen extends StatelessWidget {
  const InsuranceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HeaderSection(),
            SizedBox(height: 16),
            ActionButtonsRow(),
            SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const BottomCTAButton(),
    );
  }
}
