import 'package:flutter/material.dart';

class Ahm04 extends StatefulWidget {
  const Ahm04({super.key});

  @override
  State<Ahm04> createState() => _Ahm04State();
}

class _Ahm04State extends State<Ahm04> {
  String _dateRange = "28/12/2023 - 02/01/2024";
  int _adultCount = 1;
  int _childCount = 0;

  void _showPeoplePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  const Text("Chọn số lượng người bảo hiểm", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                ],
              ),
              const Divider(),
              _buildCounterRow("Trên 2 tuổi - 70 tuổi", _adultCount, (val) {
                setModalState(() => _adultCount = val);
                setState(() {});
              }),
              const SizedBox(height: 15),
              _buildCounterRow("Từ 15 ngày - 2 tuổi (Miễn phí)", _childCount, (val) {
                setModalState(() => _childCount = val);
                setState(() {});
              }),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
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

  Widget _buildCounterRow(String label, int value, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        Row(
          children: [
            IconButton(
              onPressed: value > 0 ? () => onChanged(value - 1) : null,
              icon: Icon(Icons.remove_circle_outline, color: value > 0 ? const Color(0xFFBB8A0B) : Colors.grey),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
              child: Text("$value", style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            IconButton(
              onPressed: () => onChanged(value + 1),
              icon: const Icon(Icons.add_circle_outline, color: Color(0xFFBB8A0B)),
            ),
          ],
        ),
      ],
    );
  }

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 5));
  DateTime _viewingMonth = DateTime.now();
  bool _isSelectingStartDate = true;

  void _showCustomDatePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40),
                    Text(_isSelectingStartDate ? "Chọn ngày đi" : "Chọn ngày về", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              // Date Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setModalState(() => _isSelectingStartDate = true),
                        child: _buildDateTab("Ngày bắt đầu", _startDate, _isSelectingStartDate),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("—", style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setModalState(() => _isSelectingStartDate = false),
                        child: _buildDateTab("Ngày kết thúc", _endDate, !_isSelectingStartDate),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Month Navigator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => setModalState(() {
                        _viewingMonth = DateTime(_viewingMonth.year, _viewingMonth.month - 1);
                      }),
                      icon: const Icon(Icons.chevron_left, color: Colors.grey),
                    ),
                    Text(
                      "${_getMonthName(_viewingMonth.month)} ${_viewingMonth.year}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    IconButton(
                      onPressed: () => setModalState(() {
                        _viewingMonth = DateTime(_viewingMonth.year, _viewingMonth.month + 1);
                      }),
                      icon: const Icon(Icons.chevron_right, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Calendar Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ["Mo", "Tu", "We", "Th", "Fr", "Sat", "Su"]
                          .map((d) => SizedBox(
                                width: 40,
                                child: Center(
                                    child: Text(d,
                                        style: const TextStyle(
                                            color: Color(0xFFBB8A0B),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    _buildCalendarDays(setModalState),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _dateRange = "${_startDate.day}/${_startDate.month}/${_startDate.year} - ${_endDate.day}/${_endDate.month}/${_endDate.year}";
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBB8A0B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Xác nhận", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    return months[month - 1];
  }

  Widget _buildDateTab(String label, DateTime date, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFFF9C4) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isActive ? const Color(0xFFBB8A0B) : Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text("${_getDayOfWeek(date)} - ${date.day}/${date.month}/${date.year}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _getDayOfWeek(DateTime date) {
    const days = ["CN", "T2", "T3", "T4", "T5", "T6", "T7"];
    return days[date.weekday % 7];
  }

  Widget _buildCalendarDays(StateSetter setModalState) {
    final firstDayOfMonth = DateTime(_viewingMonth.year, _viewingMonth.month, 1);
    final lastDayOfMonth = DateTime(_viewingMonth.year, _viewingMonth.month + 1, 0);
    
    // Calculate leading nulls (adjust for Monday start)
    int leadingDays = firstDayOfMonth.weekday - 1;
    if (leadingDays < 0) leadingDays = 6;

    List<DateTime?> days = List.generate(leadingDays, (index) => null);
    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      days.add(DateTime(_viewingMonth.year, _viewingMonth.month, i));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: days.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        DateTime? current = days[index];
        if (current == null) return const SizedBox();

        bool isStart = current.isAtSameMomentAs(DateTime(_startDate.year, _startDate.month, _startDate.day));
        bool isEnd = current.isAtSameMomentAs(DateTime(_endDate.year, _endDate.month, _endDate.day));
        bool isInRange = current.isAfter(_startDate) && current.isBefore(_endDate);

        Color? bgColor;
        Color textColor = Colors.black;
        BorderRadius borderRadius = BorderRadius.zero;

        if (isStart || isEnd) {
          bgColor = const Color(0xFF004D40);
          textColor = Colors.white;
          borderRadius = BorderRadius.circular(4);
        } else if (isInRange) {
          bgColor = const Color(0xFFE0F2F1);
        }

        return GestureDetector(
          onTap: () {
            setModalState(() {
              if (_isSelectingStartDate) {
                _startDate = current;
                if (_startDate.isAfter(_endDate)) _endDate = _startDate.add(const Duration(days: 1));
                _isSelectingStartDate = false;
              } else {
                if (current.isBefore(_startDate)) {
                  _startDate = current;
                } else {
                  _endDate = current;
                }
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(color: bgColor, borderRadius: borderRadius),
            child: Center(
              child: Text(
                "${current.day}",
                style: TextStyle(
                  color: textColor,
                  fontWeight: (isStart || isEnd) ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF007A3E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Thông tin chuyến đi",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputField(
                  label: "Ngày đi - Ngày về",
                  value: _dateRange,
                  icon: Icons.calendar_today_outlined,
                  onTap: _showCustomDatePicker,
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  label: "Số người",
                  value: "${_adultCount + _childCount}",
                  icon: Icons.person_outline,
                  onTap: _showPeoplePicker,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Trả dữ liệu về cho ahm03
                  Navigator.pop(context, {
                    "dateRange": _dateRange,
                    "count": _adultCount + _childCount,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBB8A0B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Cập nhật", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({required String label, required String value, required IconData icon, required VoidCallback onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const TextSpan(text: " *", style: TextStyle(color: Colors.red, fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.grey, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
