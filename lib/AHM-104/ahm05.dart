import 'package:flutter/material.dart';
import 'ahm06.dart';

class Ahm05 extends StatefulWidget {
  final int initialPackageIndex;
  const Ahm05({super.key, this.initialPackageIndex = 0});

  @override
  State<Ahm05> createState() => _Ahm05State();
}

class _Ahm05State extends State<Ahm05> {
  late int _selectedLeft;
  late int _selectedRight;

  final List<Map<String, dynamic>> _packages = [
    {
      "name": "Gói Đồng",
      "subtitle": "Tiết Kiệm",
      "price": "188.000 VNĐ/chuyến",
      "values": {
        "tuVong": "1.250.000.000 VNĐ",
        "tuVong1": "2.200.000.000 VNĐ",
        "tuVong2": "2.200.000.000 VNĐ",
        "tuVong3": "4.400.000.000 VNĐ",
        "chiPhiYTe": "1.540.000.000 VNĐ",
        "noiTru": "4.400.000.000 VNĐ",
        "ngoaiTru": "4.400.000.000 VNĐ",
      },
    },
    {
      "name": "Gói Bạc",
      "subtitle": "Tối Ưu",
      "price": "1.425.000 VNĐ/chuyến",
      "values": {
        "tuVong": "4.400.000.000 VNĐ",
        "tuVong1": "2.200.000.000 VNĐ",
        "tuVong2": "2.200.000.000 VNĐ",
        "tuVong3": "4.400.000.000 VNĐ",
        "chiPhiYTe": "1.540.000.000 VNĐ",
        "noiTru": "4.400.000.000 VNĐ",
        "ngoaiTru": "4.400.000.000 VNĐ",
      },
    },
    {
      "name": "Gói Vàng",
      "subtitle": "Toàn Diện",
      "price": "6.188.000 VNĐ/chuyến",
      "values": {
        "tuVong": "6.600.000.000 VNĐ",
        "tuVong1": "3.300.000.000 VNĐ",
        "tuVong2": "3.300.000.000 VNĐ",
        "tuVong3": "6.600.000.000 VNĐ",
        "chiPhiYTe": "3.080.000.000 VNĐ",
        "noiTru": "8.800.000.000 VNĐ",
        "ngoaiTru": "8.800.000.000 VNĐ",
      },
    },
  ];

  @override
  void initState() {
    super.initState();
    // Gói được chọn (từ ahm03) nằm ở cột PHẢI (có checkmark, hiện ở bottom bar)
    _selectedRight = widget.initialPackageIndex;
    // Cột trái là gói so sánh: lấy gói khác (gói liền trước, hoặc gói tiếp theo nếu là gói đầu)
    _selectedLeft = widget.initialPackageIndex == 0
        ? 1
        : widget.initialPackageIndex - 1;
  }

  void _showPackagePicker() {
    int _tempSelected = _selectedRight;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: 16), decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 30),
                  const Text("Gói bảo hiểm", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 10),
              ...List.generate(_packages.length, (index) {
                final pkg = _packages[index];
                final bool isSelected = _tempSelected == index;
                return GestureDetector(
                  onTap: () => setModalState(() => _tempSelected = index),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFFFF8E1) : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: isSelected ? const Color(0xFFBB8A0B) : Colors.grey.shade200, width: isSelected ? 1.5 : 1),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                          color: isSelected ? const Color(0xFFBB8A0B) : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(pkg['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              Text(pkg['subtitle'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ),
                        Text(pkg['price'], style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() => _selectedRight = _tempSelected);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBB8A0B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Xác nhận", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final leftPkg = _packages[_selectedLeft];
    final rightPkg = _packages[_selectedRight];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF007A3E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Chi tiết quyền lợi các gói",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildStepProgress(currentStep: 1),
          const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
          // Top header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              children: [
                // "Chọn gói so sánh khác" button
                GestureDetector(
                  onTap: _showPackagePicker,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text("Chọn gói so sánh khác", style: TextStyle(color: Color(0xFFBB8A0B), fontSize: 13, fontWeight: FontWeight.bold)),
                      Icon(Icons.keyboard_arrow_down, color: Color(0xFFBB8A0B)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Two column package cards
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(child: _buildPackageHeader(leftPkg, isSelected: false)),
                      const SizedBox(width: 10),
                      Expanded(child: _buildPackageHeader(rightPkg, isSelected: true)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Comparison table
          Expanded(
            child: SingleChildScrollView(
              child: _buildComparisonTable(leftPkg['values'], rightPkg['values']),
            ),
          ),
          _buildBottomAction(rightPkg),
        ],
      ),
    );
  }

  Widget _buildStepProgress({required int currentStep}) {
    final steps = [
      {"num": 1, "label": "Chọn gói\nbảo hiểm"},
      {"num": 2, "label": "Người được\nbảo hiểm"},
      {"num": 3, "label": "Xác nhận\nthông tin"},
      {"num": 4, "label": "Thanh toán"},
    ];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Stack(
        children: [
          // Background Lines
          Positioned(
            top: 14,
            left: 35,
            right: 35,
            child: Row(
              children: [
                Expanded(child: Container(height: 4, color: currentStep > 1 ? const Color(0xFF1B5E20) : Colors.grey[200])),
                Expanded(child: Container(height: 4, color: currentStep > 2 ? const Color(0xFF1B5E20) : Colors.grey[200])),
                Expanded(child: Container(height: 4, color: currentStep > 3 ? const Color(0xFF1B5E20) : Colors.grey[200])),
              ],
            ),
          ),
          // Circles and Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: steps.map((step) {
              final stepNum = step['num'] as int;
              final label = step['label'] as String;
              final isActiveOrDone = stepNum <= currentStep;
              
              return SizedBox(
                width: 70,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActiveOrDone ? const Color(0xFF1B5E20) : Colors.grey[200],
                      ),
                      child: Center(
                        child: Text(
                          "$stepNum",
                          style: TextStyle(
                            color: isActiveOrDone ? Colors.white : Colors.grey[500],
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isActiveOrDone ? Colors.black87 : Colors.grey,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageHeader(Map<String, dynamic> pkg, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isSelected ? const Color(0xFFBB8A0B) : Colors.grey.shade200, width: isSelected ? 2 : 1),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(pkg['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(pkg['subtitle'], style: const TextStyle(color: Colors.grey, fontSize: 11)),
              const SizedBox(height: 4),
              Text(pkg['price'], style: const TextStyle(color: Color(0xFF007A3E), fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          if (isSelected)
            const Positioned(
              top: -6,
              right: -6,
              child: Icon(Icons.check_box, color: Color(0xFFBB8A0B), size: 20),
            ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable(Map vals1, Map vals2) {
    return Column(
      children: [
        _buildCategoryHeader("I. Tử vong, thương tật vĩnh viễn"),
        _buildRow(vals1['tuVong']!, vals2['tuVong']!),
        _buildSubLabel("1. Tử vong do tai nạn"),
        _buildRow(vals1['tuVong1']!, vals2['tuVong1']!),
        _buildSubLabel("2. Thương tật vĩnh viễn do tai nạn"),
        _buildRow(vals1['tuVong2']!, vals2['tuVong2']!),
        _buildSubLabel("3. Tử vong do tai nạn khi sử dụng\nphương tiện vận tải công cộng"),
        _buildRow(vals1['tuVong3']!, vals2['tuVong3']!),

        _buildCategoryHeader("II. Chi phí y tế"),
        _buildRow(vals1['chiPhiYTe']!, vals2['chiPhiYTe']!),
        _buildSubLabel("1. Chi phí y tế cho tai nạn và ốm đau", isRed: true),
        _buildSubLabel("A. Chi phí điều trị nội trú"),
        _buildRow(vals1['noiTru']!, vals2['noiTru']!),
        _buildSubLabel("B. Chi phí điều trị ngoại trú"),
        _buildRow(vals1['ngoaiTru']!, vals2['ngoaiTru']!),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(4)),
      child: Center(child: Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
    );
  }

  Widget _buildSubLabel(String text, {bool isRed = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: isRed ? Colors.red : Colors.grey[700], fontWeight: isRed ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }

  Widget _buildRow(String val1, String val2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        children: [
          Expanded(child: Center(child: Text(val1, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)))),
          Container(width: 1, height: 22, color: Colors.grey.shade200),
          Expanded(child: Center(child: Text(val2, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)))),
        ],
      ),
    );
  }

  Widget _buildBottomAction(Map<String, dynamic> selectedPkg) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 12, offset: const Offset(0, -4))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(TextSpan(children: [
                  const TextSpan(text: "Gói bảo hiểm: ", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  TextSpan(text: selectedPkg['name'], style: const TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold)),
                ])),
                Text.rich(TextSpan(children: [
                  const TextSpan(text: "Phí bảo hiểm: ", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  TextSpan(text: selectedPkg['price'], style: const TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold)),
                ])),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            height: 48,
            width: 130,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Ahm06(
                      packageName: selectedPkg['name'],
                      packagePrice: selectedPkg['price'],
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBB8A0B),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Mua ngay", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
