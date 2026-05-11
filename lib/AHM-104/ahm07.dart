import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class InsuredPerson {
  String hoTen;
  String ngaySinh;
  String cmnd;

  InsuredPerson({this.hoTen = "", this.ngaySinh = "", this.cmnd = ""});

  bool get isEmpty => hoTen.isEmpty && ngaySinh.isEmpty && cmnd.isEmpty;
}

class Ahm07 extends StatefulWidget {
  final bool buyerIsInsured;
  final String buyerName;
  final String buyerNgaySinh;
  final String buyerCmnd;
  final List<InsuredPerson>? initialPeople;

  const Ahm07({
    super.key,
    this.buyerIsInsured = true,
    this.buyerName = "",
    this.buyerNgaySinh = "",
    this.buyerCmnd = "",
    this.initialPeople,
  });

  @override
  State<Ahm07> createState() => _Ahm07State();
}

class _Ahm07State extends State<Ahm07> {
  late bool _buyerIsInsured;
  late List<InsuredPerson> _people;

  @override
  void initState() {
    super.initState();
    _buyerIsInsured = widget.buyerIsInsured;
    _people = widget.initialPeople != null ? List.from(widget.initialPeople!) : [];
  }

  int get _totalCount => (_buyerIsInsured ? 1 : 0) + _people.length;
  bool get _canContinue => _totalCount >= 1;

  // Show method selection bottom sheet
  void _showAddMethodSheet({int? editIndex}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
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
                const Text("Lựa chọn thêm thông tin người", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
            const SizedBox(height: 16),
            // Option 1: Scan camera
            _buildMethodOption(
              icon: Icons.camera_alt_outlined,
              label: "Chụp ảnh CMND/CCCD/Hộ chiếu",
              onTap: () async {
                Navigator.pop(context);
                final result = await Navigator.push<InsuredPerson>(
                  context,
                  MaterialPageRoute(builder: (_) => const _QRScannerScreen()),
                );
                if (result != null) {
                  setState(() {
                    if (editIndex != null) {
                      _people[editIndex] = result;
                    } else {
                      _people.add(result);
                    }
                  });
                }
              },
            ),
            const SizedBox(height: 12),
            // Option 2: Manual input
            _buildMethodOption(
              icon: Icons.edit_outlined,
              label: "Hoặc nhập tay",
              showArrow: true,
              onTap: () async {
                Navigator.pop(context);
                final person = editIndex != null ? _people[editIndex] : InsuredPerson();
                final result = await showModalBottomSheet<InsuredPerson>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => _EditPersonSheet(person: person),
                );
                if (result != null) {
                  setState(() {
                    if (editIndex != null) {
                      _people[editIndex] = result;
                    } else {
                      _people.add(result);
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool showArrow = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF007A3E), size: 22),
            const SizedBox(width: 14),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
            if (showArrow) const Icon(Icons.arrow_forward, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }

  void _removePerson(int index) {
    setState(() => _people.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF007A3E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context, {
            'count': _totalCount,
            'people': _people,
          }),
        ),
        title: const Text("Danh sách  người được bảo hiểm",
            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Danh sách người được bảo hiểm ($_totalCount)",
                    style: const TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  // Checkbox buyer = insured
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _buyerIsInsured,
                          onChanged: (val) => setState(() => _buyerIsInsured = val ?? true),
                          activeColor: const Color(0xFF007A3E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        const Expanded(
                          child: Text("Bên mua bảo hiểm đồng thời là người được bảo hiểm",
                              style: TextStyle(fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Buyer card (locked)
                  if (_buyerIsInsured) _buildBuyerCard(),
                  const SizedBox(height: 8),
                  // Additional people
                  ..._people.asMap().entries.map((entry) {
                    final i = entry.key;
                    final person = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _buildPersonCard(person, i),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          // Bottom action
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 12, offset: const Offset(0, -4))],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Thêm ngay 1 người trống vào danh sách
                      setState(() => _people.add(InsuredPerson()));
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFBB8A0B)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Thêm người được bảo hiểm",
                        style: TextStyle(color: Color(0xFFBB8A0B), fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _canContinue ? () => Navigator.pop(context, {
                      'count': _totalCount,
                      'people': _people,
                    }) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _canContinue ? const Color(0xFFBB8A0B) : Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                    child: const Text("Tiếp tục",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuyerCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _infoRow("Họ tên:", widget.buyerName.isEmpty ? "—" : widget.buyerName),
        _infoRow("Ngày sinh:", widget.buyerNgaySinh.isEmpty ? "—" : widget.buyerNgaySinh),
        _infoRow("CMND/CCCD/\nHộ chiếu:", widget.buyerCmnd.isEmpty ? "—" : widget.buyerCmnd),
      ]),
    );
  }

  Widget _buildPersonCard(InsuredPerson person, int index) {
    final bool hasData = !person.isEmpty;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _infoRow("Họ tên:", hasData ? person.hoTen : "Nhập thông tin",
                  valueColor: hasData ? Colors.black : const Color(0xFFBB8A0B)),
              _infoRow("Ngày sinh:", person.ngaySinh.isEmpty ? "/" : person.ngaySinh),
              _infoRow("CMND/CCCD/\nHộ chiếu:", person.cmnd.isEmpty ? "/" : person.cmnd),
            ]),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () => _showAddMethodSheet(editIndex: index),
                child: const Icon(Icons.edit_outlined, color: Color(0xFFBB8A0B), size: 20),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _removePerson(index),
                child: const Text("Xoá", style: TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 90, child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey))),
          Expanded(child: Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: valueColor ?? Colors.black))),
        ],
      ),
    );
  }
}

// ===== QR / Camera Scanner Screen =====
class _QRScannerScreen extends StatefulWidget {
  const _QRScannerScreen();

  @override
  State<_QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<_QRScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _scanned = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_scanned) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null || barcode.rawValue == null) return;

    _scanned = true;
    final raw = barcode.rawValue!;

    // Chuẩn hoá dữ liệu CCCD chip từ chuỗi QR (định dạng: số|họ tên|ngày sinh|giới tính|địa chỉ|ngày cấp)
    final parts = raw.split('|');
    InsuredPerson person;
    if (parts.length >= 3) {
      person = InsuredPerson(
        cmnd: parts[0].trim(),
        hoTen: parts.length > 1 ? parts[1].trim() : "",
        ngaySinh: parts.length > 2 ? parts[2].trim() : "",
      );
    } else {
      // Dữ liệu dạng thô (không phải CCCD chip)
      person = InsuredPerson(cmnd: raw.trim());
    }

    Navigator.pop(context, person);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF007A3E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Quét CMND/CCCD/Hộ chiếu",
            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _controller.toggleTorch(),
            icon: const Icon(Icons.flashlight_on_outlined, color: Colors.white),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(controller: _controller, onDetect: _onDetect),
          // Overlay guide frame
          Center(
            child: Container(
              width: 260,
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFBB8A0B), width: 2.5),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          // Bottom hint
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Icon(Icons.credit_card, color: Colors.white54, size: 36),
                const SizedBox(height: 12),
                const Text(
                  "Đặt mặt trước CMND/CCCD vào khung\nHệ thống sẽ tự động nhận diện",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===== Manual Edit Person Bottom Sheet =====
class _EditPersonSheet extends StatefulWidget {
  final InsuredPerson person;
  const _EditPersonSheet({required this.person});

  @override
  State<_EditPersonSheet> createState() => _EditPersonSheetState();
}

class _EditPersonSheetState extends State<_EditPersonSheet> {
  late TextEditingController _hoTenCtrl;
  late TextEditingController _cmndCtrl;
  String _ngaySinh = "";

  @override
  void initState() {
    super.initState();
    _hoTenCtrl = TextEditingController(text: widget.person.hoTen);
    _cmndCtrl = TextEditingController(text: widget.person.cmnd);
    _ngaySinh = widget.person.ngaySinh;
  }

  @override
  void dispose() {
    _hoTenCtrl.dispose();
    _cmndCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: Color(0xFF007A3E))),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _ngaySinh = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
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
                const Text("Thông tin người được bảo hiểm", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            _sheetField(controller: _hoTenCtrl, hint: "Họ và tên *", icon: Icons.person_outline),
            const SizedBox(height: 10),
            InkWell(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(_ngaySinh.isEmpty ? "Ngày sinh *" : _ngaySinh,
                          style: TextStyle(color: _ngaySinh.isEmpty ? Colors.grey : Colors.black, fontSize: 14)),
                    ),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            _sheetField(
              controller: _cmndCtrl,
              hint: "CMND/CCCD/Hộ chiếu *",
              icon: Icons.badge_outlined,
              keyboardType: TextInputType.number,
              formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, InsuredPerson(
                    hoTen: _hoTenCtrl.text,
                    ngaySinh: _ngaySinh,
                    cmnd: _cmndCtrl.text,
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBB8A0B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Lưu", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sheetField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? formatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: formatters,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey, size: 20),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}
