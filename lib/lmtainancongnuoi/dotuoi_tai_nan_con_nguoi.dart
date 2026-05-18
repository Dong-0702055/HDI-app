import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'goibaohiem_tai_nan_con_nguoi.dart';
import '';
class ChonDoTuoiModal extends StatefulWidget {
  @override
  State<ChonDoTuoiModal> createState() => _ChonDoTuoiModalState();
}

class _ChonDoTuoiModalState extends State<ChonDoTuoiModal> {
  String _selectedGender = "Nam";
  int _selectedDay = 2;
  int _selectedMonth = 7;
  int _selectedYear = 2005;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10))),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48),
                const Text("Chọn độ tuổi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close, size: 28), onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          const Divider(height: 1),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Giới tính", style: TextStyle(color: Color(0xFF055E20), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildGenderOption("Nam", "assets/image/avatar_male.png"),
                  const SizedBox(height: 10),
                  _buildGenderOption("Nữ", "assets/image/avatar_female.png"),
                  const SizedBox(height: 24),
                  const Text("Ngày sinh", style: TextStyle(color: Color(0xFF055E20), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    "Độ tuổi áp dụng bảo hiểm ${_formatDate()} - ${_calculateAge(_selectedDay, _selectedMonth, _selectedYear)} tuổi",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    child: Row(
                      children: [
                        _buildScrollPicker(
                            "Ngày",
                            List.generate(31, (i) => i + 1),
                                (val) => _selectedDay = val
                        ),
                        _buildScrollPicker(
                            "Tháng",
                            List.generate(12, (i) => i + 1),
                                (val) => _selectedMonth = val
                        ),
                        _buildScrollPicker(
                            "Năm",
                            List.generate(100, (i) => DateTime.now().year - i),
                                (val) => _selectedYear = val
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GoibaohiemTaiNanConNguoi()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBB8A0B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: const Text("Tiếp tục", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String gender, String assetPath) {
    bool isSelected = _selectedGender == gender;
    return InkWell(
      onTap: () => setState(() => _selectedGender = gender),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFBB8A0B) : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(assetPath, width: 30, height: 30),
            const SizedBox(width: 12),
            Text(gender, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const Spacer(),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? const Color(0xFFBB8A0B) : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildScrollPicker(String label, List<int> items, Function(int) onSelected) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40,
              scrollController: FixedExtentScrollController(
                  initialItem: items.indexOf(label == "Ngày" ? _selectedDay : (label == "Tháng" ? _selectedMonth : _selectedYear))
              ),
              onSelectedItemChanged: (index) {
                setState(() {
                  onSelected(items[index]);
                });
              },
              selectionOverlay: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFFBB8A0B), width: 0.5),
                    bottom: BorderSide(color: Color(0xFFBB8A0B), width: 0.5),
                  ),
                  color: Color(0x11BB8A0B),
                ),
              ),
              children: items.map((e) => Center(
                  child: Text("$e", style: const TextStyle(fontSize: 16))
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
  int _calculateAge(int day, int month, int year) {
    DateTime today = DateTime.now();
    DateTime birthDate = DateTime(year, month, day);
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
  String _formatDate() {
    String d = _selectedDay < 10 ? "0$_selectedDay" : "$_selectedDay";
    String m = _selectedMonth < 10 ? "0$_selectedMonth" : "$_selectedMonth";
    return "$d/$m/$_selectedYear";
  }
}