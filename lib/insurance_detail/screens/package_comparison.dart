import 'package:flutter/material.dart';
import '../models/comparison_data.dart';
import '../widgets/comparison/comparison_header.dart';
import '../widgets/comparison/comparison_table.dart';
import '../widgets/comparison/comparison_bottom_cta.dart';
import '../widgets/bottom_sheets/package_selector.dart';
import 'insured_info.dart';

class PackageComparisonScreen extends StatefulWidget {
  const PackageComparisonScreen({super.key});

  @override
  State<PackageComparisonScreen> createState() =>
      _PackageComparisonScreenState();
}

class _PackageComparisonScreenState extends State<PackageComparisonScreen> {
  ComparisonPackage leftPackage = ComparisonData.packages.first;
  ComparisonPackage rightPackage = ComparisonData.packages.last;
  bool isLeftSelected = false;

  ComparisonPackage get selectedPackage =>
      isLeftSelected ? leftPackage : rightPackage;

  void _showChoosePackageSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => PackageSelectorBottomSheet(
        packages: ComparisonData.packages,
        leftPackage: leftPackage,
        rightPackage: rightPackage,
        isLeftSelected: isLeftSelected,
        onPackageSelected: (pkg) {
          setState(() {
            if (isLeftSelected) {
              leftPackage = pkg;
            } else {
              rightPackage = pkg;
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/bg_detaill.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chi tiết quyền lợi các gói',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ComparisonHeader(
            leftPackage: leftPackage,
            rightPackage: rightPackage,
            isLeftSelected: isLeftSelected,
            onChoosePackage: _showChoosePackageSheet,
            onSideSelected: (isLeft) {
              setState(() {
                isLeftSelected = isLeft;
              });
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: ComparisonTable(
                leftPackage: leftPackage,
                rightPackage: rightPackage,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ComparisonBottomCTA(
        selectedPackage: selectedPackage,
        onBuyNow: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => InsuredInfoScreen(
                selectedPackage: selectedPackage,
              ),
            ),
          );
        },
      ),
    );
  }
}
