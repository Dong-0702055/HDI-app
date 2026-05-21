import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_hdi/insurance_detail/screens/confirm_info.dart';
import '../models/comparison_data.dart';
import 'insured_info_form.dart';
import '../../../shared/widgets/hdi_app_bar.dart';
import '../../../shared/widgets/step_indicator.dart';
import '../../../shared/widgets/bottom_action_bar.dart';

class InsuredInfoScreen extends StatelessWidget {
  final ComparisonPackage selectedPackage;

  const InsuredInfoScreen({super.key, required this.selectedPackage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ✅ Dùng HdiAppBar thay vì copy-paste
      appBar: HdiAppBar(title: 'Thông tin người được bảo hiểm'),
      body: SafeArea(
        child: Column(
          children: [
            // ✅ Dùng StepIndicator
            const StepIndicator(currentStep: 2),

            // Options list
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Camera option
                    _buildOptionBox(
                      svgPath: 'assets/icons/icon_camera.svg',
                      title: 'Chụp ảnh CMND/CCCD/Hộ chiếu',
                      onTap: () {
                        // TODO: navigate to camera screen
                      },
                    ),
                    const SizedBox(height: 14),

                    // Upload gallery option
                    _buildOptionBox(
                      svgPath: 'assets/icons/icon_gallery-add.svg',
                      title: 'Tải lên ảnh CMND/CCCD/Hộ chiếu',
                      onTap: () {
                        // TODO: handle gallery upload
                      },
                    ),
                    const SizedBox(height: 14),

                    // Manual input option
                    _buildOptionBox(
                      svgPath: 'assets/icons/icon_edit.svg',
                      title: 'Hoặc nhập tay',
                      hasArrow: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => InsuredInfoFormScreen(
                              selectedPackage: selectedPackage,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ✅ BottomActionBar với topContent slot hiển thị thông tin giá
            BottomActionBar(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ConfirmInfoScreen(selectedPackage: selectedPackage),
                  ),
                );
              },
              topContent: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      'Bảo hiểm chăm sóc sức\nkhỏe và tai nạn',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        selectedPackage.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        selectedPackage.price,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget riêng của screen này - dùng để hiển thị 3 lựa chọn nhập thông tin
  Widget _buildOptionBox({
    required String svgPath,
    required String title,
    bool hasArrow = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF7FA67F)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(svgPath, width: 26, height: 26),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
            if (hasArrow)
              const Icon(Icons.arrow_forward, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
