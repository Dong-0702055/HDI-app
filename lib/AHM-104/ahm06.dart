import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ahm07.dart';
import 'ahm08.dart';

class Ahm06 extends StatefulWidget {
  final String packageName;
  final String packagePrice;

  const Ahm06({super.key, this.packageName = "Gói Vàng", this.packagePrice = "6.600.000 VNĐ"});

  @override
  State<Ahm06> createState() => _Ahm06State();
}

class _Ahm06State extends State<Ahm06> {
  final _formKey = GlobalKey<FormState>();
  final _hoTenController = TextEditingController();
  final _cmndController = TextEditingController();
  final _soDienThoaiController = TextEditingController();
  final _emailController = TextEditingController();

  String _ngaySinh = "";
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 5));
  DateTime _viewingMonth = DateTime.now();
  bool _isSelectingStartDate = true;
  bool _muonHoaDon = false;
  bool _muaBaoHiemLaNguoiDuocBaoHiem = true;
  int _soNguoiBaoHiem = 0;
  List<InsuredPerson> _insuredPeople = []; // Danh sách người được BH từ ahm07

  String get _ngayDiVeText =>
      "${_startDate.day.toString().padLeft(2, '0')}/${_startDate.month.toString().padLeft(2, '0')}/${_startDate.year} - ${_endDate.day.toString().padLeft(2, '0')}/${_endDate.month.toString().padLeft(2, '0')}/${_endDate.year}";

  @override
  void dispose() {
    _hoTenController.dispose();
    _cmndController.dispose();
    _soDienThoaiController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _chonNgaySinh() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990, 1, 1),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF007A3E)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _ngaySinh = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _showDateRangePicker() {
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
                    Text(_isSelectingStartDate ? "Chọn ngày đi" : "Chọn ngày về",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 8),
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
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text("—", style: TextStyle(color: Colors.grey))),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setModalState(() => _isSelectingStartDate = false),
                        child: _buildDateTab("Ngày kết thúc", _endDate, !_isSelectingStartDate),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Month nav
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => setModalState(() => _viewingMonth = DateTime(_viewingMonth.year, _viewingMonth.month - 1)),
                      icon: const Icon(Icons.chevron_left, color: Colors.grey),
                    ),
                    Text("${_monthName(_viewingMonth.month)} ${_viewingMonth.year}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(
                      onPressed: () => setModalState(() => _viewingMonth = DateTime(_viewingMonth.year, _viewingMonth.month + 1)),
                      icon: const Icon(Icons.chevron_right, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
                          .map((d) => SizedBox(width: 40, child: Center(child: Text(d, style: const TextStyle(color: Color(0xFFBB8A0B), fontWeight: FontWeight.bold, fontSize: 12)))))
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    _buildCalendarGrid(setModalState),
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
                      setState(() {});
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

  Widget _buildDateTab(String label, DateTime date, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFFF9C4) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isActive ? const Color(0xFFBB8A0B) : Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 4),
          Text("${date.day}/${date.month}/${date.year}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _monthName(int m) {
    const months = ["Tháng 1","Tháng 2","Tháng 3","Tháng 4","Tháng 5","Tháng 6","Tháng 7","Tháng 8","Tháng 9","Tháng 10","Tháng 11","Tháng 12"];
    return months[m - 1];
  }

  Widget _buildCalendarGrid(StateSetter setModalState) {
    final first = DateTime(_viewingMonth.year, _viewingMonth.month, 1);
    final last = DateTime(_viewingMonth.year, _viewingMonth.month + 1, 0);
    int leading = first.weekday - 1;
    List<DateTime?> days = List.generate(leading, (_) => null);
    for (int i = 1; i <= last.day; i++) {
      days.add(DateTime(_viewingMonth.year, _viewingMonth.month, i));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: days.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 4, crossAxisSpacing: 4),
      itemBuilder: (context, index) {
        final current = days[index];
        if (current == null) return const SizedBox();

        final start0 = DateTime(_startDate.year, _startDate.month, _startDate.day);
        final end0 = DateTime(_endDate.year, _endDate.month, _endDate.day);
        final cur0 = DateTime(current.year, current.month, current.day);

        bool isStart = cur0 == start0;
        bool isEnd = cur0 == end0;
        bool inRange = cur0.isAfter(start0) && cur0.isBefore(end0);

        Color? bg = inRange ? const Color(0xFFE0F2F1) : null;
        Color textColor = Colors.black;
        BorderRadius br = BorderRadius.zero;

        if (isStart || isEnd) {
          bg = const Color(0xFF004D40);
          textColor = Colors.white;
          br = BorderRadius.circular(4);
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
            decoration: BoxDecoration(color: bg, borderRadius: br),
            child: Center(child: Text("${current.day}", style: TextStyle(color: textColor, fontSize: 13, fontWeight: (isStart || isEnd) ? FontWeight.bold : FontWeight.normal))),
          ),
        );
      },
    );
  }

  String? _validatePhone(String? val) {
    if (val == null || val.isEmpty) return "Vui lòng nhập số điện thoại";
    if (!RegExp(r'^0\d{9}$').hasMatch(val)) return "Số điện thoại phải là 10 số bắt đầu bằng 0";
    return null;
  }

  String? _validateCmnd(String? val) {
    if (val == null || val.isEmpty) return "Vui lòng nhập CMND/CCCD";
    if (!RegExp(r'^\d{9}$|^\d{12}$').hasMatch(val)) return "CMND phải có 9 số hoặc CCCD phải có 12 số";
    return null;
  }

  String? _validateEmail(String? val) {
    if (val == null || val.isEmpty) return null; // Không bắt buộc
    if (!RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(val)) return "Email không đúng định dạng";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF007A3E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Thông tin người được bảo hiểm",
            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildStepProgress(currentStep: 2),
            const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BÊN MUA BẢO HIỂM
                    const Text("Bên mua bảo hiểm", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildCard(children: [
                      _buildValidatedField(
                        controller: _hoTenController,
                        hint: "Họ và tên *",
                        icon: Icons.person_outline,
                        validator: (v) => (v == null || v.isEmpty) ? "Vui lòng nhập họ và tên" : null,
                      ),
                      const Divider(height: 1),
                      _buildDateField(hint: "Ngày sinh *", value: _ngaySinh, icon: Icons.calendar_today_outlined, onTap: _chonNgaySinh),
                      const Divider(height: 1),
                      _buildValidatedField(
                        controller: _cmndController,
                        hint: "CMND/CCCD/Hộ chiếu *",
                        icon: Icons.badge_outlined,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
                        validator: _validateCmnd,
                      ),
                      const Divider(height: 1),
                      _buildValidatedField(
                        controller: _soDienThoaiController,
                        hint: "Số điện thoại *",
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                        validator: _validatePhone,
                      ),
                      const Divider(height: 1),
                      _buildValidatedField(
                        controller: _emailController,
                        hint: "Email",
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                        isRequired: false,
                      ),
                    ]),

                    const SizedBox(height: 16),

                    // THÔNG TIN CHUYẾN ĐI
                    const Text("Thông tin chuyến đi", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildCard(children: [
                      _buildDateField(
                        hint: "Ngày đi - Ngày về *",
                        value: _ngayDiVeText,
                        icon: Icons.date_range_outlined,
                        onTap: _showDateRangePicker,
                      ),
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Tôi muốn nhận Hoá đơn điện tử", style: TextStyle(fontSize: 14, color: Colors.grey)),
                            Transform.scale(
                              scale: 0.85,
                              child: Switch(
                                value: _muonHoaDon,
                                onChanged: (val) => setState(() => _muonHoaDon = val),
                                activeColor: const Color(0xFF007A3E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),

                    const SizedBox(height: 16),

                    // NGƯỜI ĐƯỢC BẢO HIỂM
                    const Text("Người được bảo hiểm", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildCard(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            Checkbox(
                              value: _muaBaoHiemLaNguoiDuocBaoHiem,
                              onChanged: (val) => setState(() => _muaBaoHiemLaNguoiDuocBaoHiem = val ?? true),
                              activeColor: const Color(0xFF007A3E),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            ),
                            const Expanded(
                              child: Text("Bên mua bảo hiểm đồng thời là người được bảo hiểm", style: TextStyle(fontSize: 13)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                        child: OutlinedButton(
                          onPressed: () async {
                            final result = await Navigator.push<Map<String, dynamic>>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Ahm07(
                                  buyerIsInsured: _muaBaoHiemLaNguoiDuocBaoHiem,
                                  buyerName: _hoTenController.text,
                                  buyerNgaySinh: _ngaySinh,
                                  buyerCmnd: _cmndController.text,
                                  initialPeople: _insuredPeople,
                                ),
                              ),
                            );
                            if (result != null) {
                              setState(() {
                                _soNguoiBaoHiem = result['count'] as int;
                                _insuredPeople = List<InsuredPerson>.from(result['people'] as List);
                              });
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFBB8A0B)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 8),
                              Text("Danh sách người được bảo hiểm ($_soNguoiBaoHiem)",
                                  style: const TextStyle(color: Color(0xFFBB8A0B), fontWeight: FontWeight.bold)),
                              const Icon(Icons.chevron_right, color: Color(0xFFBB8A0B)),
                            ],
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
    );
  }

  Widget _buildValidatedField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool isRequired = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Icon(icon, color: Colors.grey, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              validator: validator,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                errorStyle: const TextStyle(fontSize: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField({required String hint, required String value, required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value.isEmpty ? hint : value,
                style: TextStyle(color: value.isEmpty ? Colors.grey : Colors.black, fontSize: 14),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, -4))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Du lịch Việt Nam", style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text("${widget.packageName} (x$_soNguoiBaoHiem người)", style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tổng phí bảo hiểm:", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(widget.packagePrice, style: const TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold)),
                  const Text("(Không tính VAT)", style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                if (_ngaySinh.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Vui lòng chọn ngày sinh"), backgroundColor: Colors.red),
                  );
                  return;
                }
                if (_soNguoiBaoHiem < 1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Ở bước 2, vui lòng thêm ít nhất 1 người được bảo hiểm!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Ahm08(
                      packageName: widget.packageName,
                      packagePrice: widget.packagePrice,
                      buyerName: _hoTenController.text,
                      buyerNgaySinh: _ngaySinh,
                      buyerCmnd: _cmndController.text,
                      buyerPhone: _soDienThoaiController.text,
                      buyerEmail: _emailController.text,
                      startDate: _startDate,
                      endDate: _endDate,
                      soNguoiBaoHiem: _soNguoiBaoHiem,
                      buyerIsInsured: _muaBaoHiemLaNguoiDuocBaoHiem,
                      insuredPeople: _insuredPeople,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBB8A0B),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Tiếp tục", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
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
}
