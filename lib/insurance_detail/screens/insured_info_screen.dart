import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_hdi/insurance_detail/screens/confirm_info_screen.dart';
import '../models/comparison_data.dart';
import 'insured_info_form_screen.dart';

class InsuredInfoScreen extends StatelessWidget {
  final ComparisonPackage selectedPackage;

  const InsuredInfoScreen({super.key, required this.selectedPackage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Thông tin người được bảo hiểm',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Step indicator
            _buildStepIndicator(),

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

            // Bottom CTA
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    const steps = [
      {'number': '1', 'label': 'Chọn gói\nsức khỏe', 'active': true},
      {'number': '2', 'label': 'Người được bảo hiểm', 'active': true},
      {'number': '3', 'label': 'Xác nhận\nthông tin', 'active': false},
      {'number': '4', 'label': 'Thanh toán', 'active': false},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Column(
        children: [
          // Row 1: circles + lines
          Row(
            children: [
              for (int i = 0; i < steps.length; i++) ...[
                CircleAvatar(
                  radius: 10,
                  backgroundColor: (steps[i]['active'] as bool)
                      ? const Color(0xFF2F7D32)
                      : Colors.grey.shade300,
                  child: Text(
                    steps[i]['number'] as String,
                    style: TextStyle(
                      color: (steps[i]['active'] as bool)
                          ? Colors.white
                          : Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (i < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: (steps[i + 1]['active'] as bool)
                          ? const Color(0xFF2F7D32)
                          : Colors.grey.shade300,
                    ),
                  ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          // Row 2: labels (aligned under each circle)
          Row(
            children: [
              for (int i = 0; i < steps.length; i++) ...[
                SizedBox(
                  width: 50, // same width as circle diameter (radius 10 * 2)
                  child: Text(
                    steps[i]['label'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.3,
                      color: (steps[i]['active'] as bool)
                          ? Colors.black87
                          : Colors.grey,
                    ),
                  ),
                ),
                if (i < steps.length - 1) const Expanded(child: SizedBox()),
              ],
            ],
          ),
        ],
      ),
    );
  }

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

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
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
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ConfirmInfoScreen(selectedPackage: selectedPackage),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBB8A0B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Tiếp tục',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
