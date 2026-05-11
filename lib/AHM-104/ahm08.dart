import 'package:flutter/material.dart';
import 'ahm07.dart';
import 'ahm09.dart';

class Ahm08 extends StatefulWidget {
  final String packageName;
  final String packagePrice;
  final String buyerName;
  final String buyerNgaySinh;
  final String buyerCmnd;
  final String buyerPhone;
  final String buyerEmail;
  final DateTime startDate;
  final DateTime endDate;
  final int soNguoiBaoHiem;
  final bool buyerIsInsured;
  final List<InsuredPerson> insuredPeople;

  const Ahm08({
    super.key,
    required this.packageName,
    required this.packagePrice,
    required this.buyerName,
    required this.buyerNgaySinh,
    required this.buyerCmnd,
    required this.buyerPhone,
    required this.buyerEmail,
    required this.startDate,
    required this.endDate,
    required this.soNguoiBaoHiem,
    this.buyerIsInsured = true,
    this.insuredPeople = const [],
  });

  @override
  State<Ahm08> createState() => _Ahm08State();
}

class _Ahm08State extends State<Ahm08> {
  bool? _filterAnswer;
  late DateTime _startDate;
  late DateTime _endDate;
  late DateTime _viewingMonth;
  bool _isSelectingStartDate = true;

  @override
  void initState() {
    super.initState();
    _startDate = widget.startDate;
    _endDate = widget.endDate;
    _viewingMonth = DateTime(_startDate.year, _startDate.month);
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  int _daysBetween() => _endDate.difference(_startDate).inDays;

  String _getPackageImage(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('vàng')) return 'assets/image/AHM-104/Vàng.png';
    if (lower.contains('bạc')) return 'assets/image/AHM-104/bạc.png';
    return 'assets/image/AHM-104/đồng.png';
  }

  String _getPackageIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('vàng')) return 'assets/image/AHM-104/12.png';
    if (lower.contains('bạc')) return 'assets/image/AHM-104/11.png';
    return 'assets/image/AHM-104/13.png';
  }

  void _showDatePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModal) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                    Text(_isSelectingStartDate ? 'Chọn ngày đi' : 'Chọn ngày về',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.close)),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(child: GestureDetector(
                      onTap: () => setModal(() => _isSelectingStartDate = true),
                      child: _dateTab('Ngày bắt đầu', _startDate, _isSelectingStartDate),
                    )),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('—', style: TextStyle(color: Colors.grey))),
                    Expanded(child: GestureDetector(
                      onTap: () => setModal(() => _isSelectingStartDate = false),
                      child: _dateTab('Ngày kết thúc', _endDate, !_isSelectingStartDate),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => setModal(() => _viewingMonth = DateTime(_viewingMonth.year, _viewingMonth.month - 1)),
                      icon: const Icon(Icons.chevron_left, color: Colors.grey),
                    ),
                    Text('${_monthName(_viewingMonth.month)} ${_viewingMonth.year}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(
                      onPressed: () => setModal(() => _viewingMonth = DateTime(_viewingMonth.year, _viewingMonth.month + 1)),
                      icon: const Icon(Icons.chevron_right, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ['Mo','Tu','We','Th','Fr','Sa','Su']
                        .map((d) => SizedBox(width: 40, child: Center(child: Text(d, style: const TextStyle(color: Color(0xFFBB8A0B), fontWeight: FontWeight.bold, fontSize: 12)))))
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  _buildCalendarGrid(setModal),
                ]),
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
                      Navigator.pop(ctx);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBB8A0B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Xác nhận', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateTab(String label, DateTime date, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFFF9C4) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isActive ? const Color(0xFFBB8A0B) : Colors.grey.shade300),
      ),
      child: Column(children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 4),
        Text('${date.day}/${date.month}/${date.year}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  String _monthName(int m) {
    const months = ['Tháng 1','Tháng 2','Tháng 3','Tháng 4','Tháng 5','Tháng 6','Tháng 7','Tháng 8','Tháng 9','Tháng 10','Tháng 11','Tháng 12'];
    return months[m - 1];
  }

  Widget _buildCalendarGrid(StateSetter setModal) {
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
        final s0 = DateTime(_startDate.year, _startDate.month, _startDate.day);
        final e0 = DateTime(_endDate.year, _endDate.month, _endDate.day);
        final c0 = DateTime(current.year, current.month, current.day);
        bool isStart = c0 == s0;
        bool isEnd = c0 == e0;
        bool inRange = c0.isAfter(s0) && c0.isBefore(e0);
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
            setModal(() {
              if (_isSelectingStartDate) {
                _startDate = current;
                if (_endDate.isBefore(_startDate)) _endDate = _startDate.add(const Duration(days: 1));
                _isSelectingStartDate = false;
              } else {
                if (current.isAfter(_startDate)) {
                  _endDate = current;
                  _isSelectingStartDate = true;
                }
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(color: bg, borderRadius: br),
            child: Center(child: Text('${current.day}', style: TextStyle(color: textColor, fontSize: 13))),
          ),
        );
      },
    );
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
        title: const Text('Xác nhận thông tin',
            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildStepProgress(currentStep: 3),
          const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gói bảo hiểm
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(_getPackageImage(widget.packageName), width: 64, height: 64, fit: BoxFit.cover),
                            ),
                            Image.asset(_getPackageIcon(widget.packageName), width: 38, height: 38, fit: BoxFit.contain),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Bảo hiểm du lịch Việt Nam',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('x${widget.soNguoiBaoHiem} ${widget.packageName}',
                                      style: const TextStyle(fontSize: 13, color: Colors.black87)),
                                  // Chi tiết quyền lợi → pop 2 lần về ahm05
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context); // về ahm06
                                      Navigator.pop(context); // về ahm05
                                    },
                                    child: const Text('Chi tiết quyền lợi',
                                        style: TextStyle(fontSize: 13, color: Color(0xFFBB8A0B), fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(widget.packagePrice,
                                  style: const TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Thông tin chuyến đi (Chỉnh sửa → mở date picker)
                  _buildSectionHeader('Thông tin chuyến đi',
                      trailingText: 'Chỉnh sửa', trailingOnTap: _showDatePicker),
                  const SizedBox(height: 8),
                  _buildInfoCard([
                    _infoRow('Thời gian:', '${_daysBetween()} ngày (${_fmt(_startDate)} - ${_fmt(_endDate)})'),
                    _infoRow('Ngày về:', _fmt(_endDate)),
                  ]),

                  const SizedBox(height: 16),

                  // Bên mua bảo hiểm
                  _buildSectionHeader('Bên mua bảo hiểm',
                      trailingText: 'Chỉnh sửa', trailingOnTap: () => Navigator.pop(context)),
                  const SizedBox(height: 8),
                  _buildInfoCard([
                    _infoRow('Họ tên:', widget.buyerName),
                    _infoRow('Ngày sinh:', widget.buyerNgaySinh),
                    _infoRow('CMND/CCCD/\nHộ chiếu:', widget.buyerCmnd),
                    _infoRow('Số điện thoại:', widget.buyerPhone),
                    if (widget.buyerEmail.isNotEmpty) _infoRow('Email:', widget.buyerEmail),
                  ]),

                  const SizedBox(height: 16),

                  // Người được bảo hiểm
                  _buildSectionHeader('Người được bảo hiểm (${widget.soNguoiBaoHiem})',
                      trailingText: 'Chỉnh sửa', trailingOnTap: () => Navigator.pop(context)),
                  const SizedBox(height: 8),
                  ...List.generate(widget.soNguoiBaoHiem, (i) {
                    final isBuyer = widget.buyerIsInsured && i == 0;
                    final personIndex = widget.buyerIsInsured ? i - 1 : i;

                    final person = (personIndex >= 0 && personIndex < widget.insuredPeople.length)
                        ? widget.insuredPeople[personIndex]
                        : null;

                    final hoTen = isBuyer ? widget.buyerName : (person?.hoTen.isNotEmpty == true ? person!.hoTen : '—');
                    final ngaySinh = isBuyer ? widget.buyerNgaySinh : (person?.ngaySinh.isNotEmpty == true ? person!.ngaySinh : '—');
                    final cmnd = isBuyer ? widget.buyerCmnd : (person?.cmnd.isNotEmpty == true ? person!.cmnd : '—');

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _buildInfoCard([
                        _infoRow('Họ tên:', hoTen),
                        _infoRow('Ngày sinh:', ngaySinh),
                        _infoRow('CMND/CCCD/\nHộ chiếu:', cmnd),
                      ]),
                    );
                  }),

                  const SizedBox(height: 8),
                  _buildFilterQuestion(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildStepProgress({required int currentStep}) {
    final steps = [
      {'num': 1, 'label': 'Chọn gói\nbảo hiểm'},
      {'num': 2, 'label': 'Người được\nbảo hiểm'},
      {'num': 3, 'label': 'Xác nhận\nthông tin'},
      {'num': 4, 'label': 'Thanh toán'},
    ];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Stack(children: [
        Positioned(
          top: 14, left: 35, right: 35,
          child: Row(children: [
            Expanded(child: Container(height: 4, color: currentStep > 1 ? const Color(0xFF1B5E20) : Colors.grey[200])),
            Expanded(child: Container(height: 4, color: currentStep > 2 ? const Color(0xFF1B5E20) : Colors.grey[200])),
            Expanded(child: Container(height: 4, color: currentStep > 3 ? const Color(0xFF1B5E20) : Colors.grey[200])),
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: steps.map((step) {
            final stepNum = step['num'] as int;
            final label = step['label'] as String;
            final ok = stepNum <= currentStep;
            return SizedBox(
              width: 70,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: ok ? const Color(0xFF1B5E20) : Colors.grey[200]),
                  child: Center(child: Text('$stepNum', style: TextStyle(color: ok ? Colors.white : Colors.grey[500], fontSize: 14, fontWeight: FontWeight.bold))),
                ),
                const SizedBox(height: 8),
                Text(label, textAlign: TextAlign.center, style: TextStyle(color: ok ? Colors.black87 : Colors.grey, fontSize: 12, height: 1.3)),
              ]),
            );
          }).toList(),
        ),
      ]),
    );
  }

  Widget _buildSectionHeader(String title, {String? trailingText, VoidCallback? trailingOnTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
        if (trailingText != null)
          GestureDetector(
            onTap: trailingOnTap,
            child: Text(trailingText, style: const TextStyle(fontSize: 13, color: Color(0xFFBB8A0B), fontWeight: FontWeight.w600)),
          ),
      ],
    );
  }

  Widget _buildInfoCard(List<Widget> rows) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows),
    );
  }

  Widget _infoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: 110, child: Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey))),
        Expanded(child: Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: valueColor ?? Colors.black87))),
      ]),
    );
  }

  Widget _buildFilterQuestion() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Người tham gia bảo hiểm có thuộc một trong các đối tượng sau đây?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        _bullet('1. Người đang mắc bệnh tâm thần, bệnh ung thư, bệnh phong'),
        _bullet('2. Người bị thương tật vĩnh viễn từ 70% trở lên'),
        _bullet('3. Người đang trong thời gian điều trị bệnh tật, thương tật'),
        const SizedBox(height: 14),
        Row(children: [_radio('Có', true), const SizedBox(width: 24), _radio('Không', false)]),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 10),
        RichText(text: const TextSpan(
          style: TextStyle(fontSize: 12, color: Colors.grey),
          children: [
            TextSpan(text: 'Bằng việc nhấn nút '),
            TextSpan(text: '"TIẾP TỤC"', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
            TextSpan(text: ' đồng nghĩa với việc Bên mua bảo hiểm xác nhận và cam kết:\n\na) Các thông tin được khai báo, cung cấp là đúng sự thật và hoàn toàn chịu trách nhiệm trước pháp luật. Đồng thời, Bên mua bảo hiểm đã đọc, hiểu và đồng ý với điều kiện, điều khoản và quy tắc của Bảo hiểm HD.'),
          ],
        )),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {},
          child: const Text('Xem tất cả ∨', style: TextStyle(color: Color(0xFFBB8A0B), fontWeight: FontWeight.bold, fontSize: 13)),
        ),
      ]),
    );
  }

  Widget _bullet(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.black87)),
  );

  Widget _radio(String label, bool value) {
    final isSelected = _filterAnswer == value;
    return GestureDetector(
      onTap: () => setState(() => _filterAnswer = value),
      child: Row(children: [
        Container(
          width: 22, height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: isSelected ? const Color(0xFFBB8A0B) : Colors.grey, width: 2),
          ),
          child: isSelected ? Center(child: Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFBB8A0B)))) : null,
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 14)),
      ]),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, -4))],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (_filterAnswer == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Vui lòng trả lời câu hỏi sàng lọc!'), backgroundColor: Colors.red),
              );
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Ahm09(buyerName: widget.buyerName),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBB8A0B),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('Thanh toán', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
