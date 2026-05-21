import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/comparison_data.dart';
import '../models/insured_person_data.dart';
import '../widgets/bottom_sheets/edit_insured_info_sheet.dart';
import 'payment.dart';
import '../../../shared/widgets/hdi_app_bar.dart';
import '../../../shared/widgets/step_indicator.dart';
import '../../../shared/widgets/bottom_action_bar.dart';

class OrderReviewScreen extends StatefulWidget {
  final ComparisonPackage selectedPackage;

  const OrderReviewScreen({super.key, required this.selectedPackage});

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  InsuredPersonInfo _insuredInfo = InsuredPersonData.mockPerson;

  Future<void> _openEditSheet() async {
    final result = await showModalBottomSheet<InsuredPersonInfo>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => EditInsuredInfoSheet(initialInfo: _insuredInfo),
    );
    if (result != null) {
      setState(() => _insuredInfo = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      // ✅ Dùng HdiAppBar
      appBar: HdiAppBar(title: 'Thông tin người được bảo hiểm'),
      body: Column(
        children: [
          // ✅ Dùng StepIndicator
          const StepIndicator(currentStep: 3),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildProductCard(),
                  const SizedBox(height: 14),
                  _buildInsuredSection(),
                  const SizedBox(height: 14),
                  _buildCertificateRow(),
                ],
              ),
            ),
          ),
          // ✅ Dùng BottomActionBar, nhãn khác: 'Thanh toán'
          BottomActionBar(
            label: 'Thanh toán',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentScreen(
                    selectedPackage: widget.selectedPackage,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════
  // PRODUCT CARD
  // ══════════════════════════════════════════
  Widget _buildProductCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product icon
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF0FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: SvgPicture.asset('assets/icons/icon_dia.svg'),
            ),
          ),
          const SizedBox(width: 10),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bảo Hiểm Chăm Sóc Sức Khỏe \nVà Tai Nạn',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 49, 113, 51),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'x1 ${widget.selectedPackage.title}',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Chi tiết',
                        style: TextStyle(
                          color: Color(0xFFBB8A0B),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.selectedPackage.price,
                  style: const TextStyle(color: Colors.red, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════
  // INSURED PERSON SECTION
  // ══════════════════════════════════════════
  Widget _buildInsuredSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              const Text(
                'Người được bảo hiểm',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _openEditSheet,
                child: const Text(
                  'Chỉnh sửa',
                  style: TextStyle(color: Color(0xFFBB8A0B), fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Info rows
          _infoRow('Họ tên:', _insuredInfo.name),
          _infoRow('Ngày sinh:', _insuredInfo.birthDate),
          _infoRow('Giới tính:', _insuredInfo.gender),
          _infoRow('CMND/CCCD/Hộ Chiếu:', _insuredInfo.idNumber),
          _infoRow('Số điện thoại:', _insuredInfo.phone),
          _infoRow('Email:', _insuredInfo.email),
          _infoRow('Thời hạn bảo hiểm:', _insuredInfo.insurancePeriod),
        ],
      ),
    );
  }

  // Hàm tạo từng hàng thông tin
  Widget _infoRow(String label, String value) {
    return Padding(
      // Thêm padding để các hàng không bị dính sát vào nhau
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        // Căn lên trên cùng (phòng trường hợp value dài phải rớt xuống 2 dòng)
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Nhãn (Label) bên trái
          Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(255, 96, 96, 96), // Chữ xám cho phần nhãn
              fontSize: 14,
            ),
          ),

          const SizedBox(width: 16), // Khoảng cách an toàn giữa nhãn và giá trị
          // 2. Giá trị (Value) bên phải
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right, // Ép chữ dạt hết sang lề phải
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w500, // In đậm nhẹ để nổi bật thông tin
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════
  // CERTIFICATE ROW
  // ══════════════════════════════════════════
  Widget _buildCertificateRow() {
    return GestureDetector(
      onTap: () {
        // TODO: show sample certificate
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/icon_safe2.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Xem giấy chứng nhận mẫu',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

}
