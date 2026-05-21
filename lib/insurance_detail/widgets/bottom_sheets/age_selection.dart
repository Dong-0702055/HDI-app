import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../screens/insurance_packages.dart';

class AgeSelectionBottomSheet extends StatefulWidget {
  const AgeSelectionBottomSheet({super.key});

  @override
  State<AgeSelectionBottomSheet> createState() =>
      _AgeSelectionBottomSheetState();
}

class _AgeSelectionBottomSheetState extends State<AgeSelectionBottomSheet> {
  String? _selectedGender;
  int? _selectedDay;
  int? _selectedMonth;
  int? _selectedYear;

  int? get _calculatedAge {
    if (_selectedYear == null) return null;
    final currentYear = 2026;
    return currentYear - _selectedYear!;
  }

  bool get _isFormValid =>
      _selectedGender != null &&
      _selectedDay != null &&
      _selectedMonth != null &&
      _selectedYear != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(top: 12, bottom: 24, left: 20, right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 24),
              const Text(
                'Chọn độ tuổi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Giới tính',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          const SizedBox(height: 12),
          _GenderOption(
            label: 'Nam',
            iconPath: 'assets/icons/icon_male.svg',
            isSelected: _selectedGender == 'Nam',
            onTap: () => setState(() => _selectedGender = 'Nam'),
          ),
          const SizedBox(height: 12),
          _GenderOption(
            label: 'Nữ',
            iconPath: 'assets/icons/icon_female.svg',
            isSelected: _selectedGender == 'Nữ',
            onTap: () => setState(() => _selectedGender = 'Nữ'),
          ),
          const SizedBox(height: 24),
          const Text(
            'Ngày sinh',
            style: TextStyle(
              color: Color.fromARGB(255, 14, 83, 46),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 32, // Giữ khoảng trống cố định để không bị giật card
            child: (_calculatedAge != null &&
                    _selectedDay != null &&
                    _selectedMonth != null)
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      'Độ tuổi áp dụng bảo hiểm $_selectedDay/$_selectedMonth/$_selectedYear - $_calculatedAge tuổi',
                      style: const TextStyle(color: Color(0xFF555555), fontSize: 15),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Row(
            children: [
              Expanded(
                child: _CustomWheelPicker(
                  title: 'Ngày',
                  itemCount: 31,
                  onSelectedItemChanged: (i) =>
                      setState(() => _selectedDay = i + 1),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _CustomWheelPicker(
                  title: 'Tháng',
                  itemCount: 12,
                  onSelectedItemChanged: (i) =>
                      setState(() => _selectedMonth = i + 1),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _CustomWheelPicker(
                  title: 'Năm',
                  itemCount: 100,
                  startValue: 1926,
                  onSelectedItemChanged: (i) =>
                      setState(() => _selectedYear = 1926 + i),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isFormValid
                  ? () {
                      Navigator.pop(context); // Close age selection sheet
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const InsurancePackagesScreen(),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: const Color(0xFFEEEEEE),
                disabledForegroundColor: const Color(0xFFAAAAAA),
                backgroundColor: const Color(0xFFBB8A0B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Tiếp tục',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String label;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.label,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFFBB8A0B) : Colors.grey[300]!,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: SvgPicture.asset(iconPath, width: 35, height: 35),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
            Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFBB8A0B)
                      : Colors.grey[400]!,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFBB8A0B),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomWheelPicker extends StatelessWidget {
  final String title;
  final int itemCount;
  final int startValue;
  final ValueChanged<int> onSelectedItemChanged;

  const _CustomWheelPicker({
    required this.title,
    required this.itemCount,
    this.startValue = 1,
    required this.onSelectedItemChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  color: const Color(0xFFFFF7E6),
                ),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.2, 0.8, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 40,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: onSelectedItemChanged,
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: itemCount,
                      builder: (context, index) {
                        return Center(
                          child: Text(
                            '${startValue + index}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
