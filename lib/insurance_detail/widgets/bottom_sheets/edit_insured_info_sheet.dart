import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../models/insured_person_data.dart';

class EditInsuredInfoSheet extends StatefulWidget {
  final InsuredPersonInfo initialInfo;

  const EditInsuredInfoSheet({super.key, required this.initialInfo});

  @override
  State<EditInsuredInfoSheet> createState() => _EditInsuredInfoSheetState();
}

class _EditInsuredInfoSheetState extends State<EditInsuredInfoSheet> {
  late TextEditingController _nameCtrl;
  late TextEditingController _birthCtrl;
  late TextEditingController _idCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _emailCtrl;
  late String _gender;

  @override
  void initState() {
    super.initState();
    final i = widget.initialInfo;
    _nameCtrl = TextEditingController(text: i.name);
    _birthCtrl = TextEditingController(text: i.birthDate);
    _idCtrl = TextEditingController(text: i.idNumber);
    _phoneCtrl = TextEditingController(text: i.phone);
    _emailCtrl = TextEditingController(text: i.email);
    _gender = i.gender;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _birthCtrl.dispose();
    _idCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _pickDate() {
    DateTime tempDate = DateTime(1990, 1, 1);
    try {
      tempDate = DateFormat('dd/MM/yyyy').parse(_birthCtrl.text);
    } catch (_) {}

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModal) => SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      const Text('Ngày sinh',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pop(ctx),
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: tempDate,
                      minimumDate: DateTime(1950),
                      maximumDate: DateTime.now(),
                      onDateTimeChanged: (val) {
                        tempDate = val;
                        setModal(() {});
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _birthCtrl.text =
                              DateFormat('dd/MM/yyyy').format(tempDate);
                        });
                        Navigator.pop(ctx);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBB8A0B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text('Xác nhận',
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title row
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Chỉnh sửa thông tin',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Họ và tên
              _buildTextField(
                svgPath: 'assets/icons/icon_user.svg',
                hint: 'Họ và tên *',
                controller: _nameCtrl,
              ),
              const SizedBox(height: 12),

              // Ngày sinh
              GestureDetector(
                onTap: _pickDate,
                child: _buildReadonlyField(
                  svgPath: 'assets/icons/icon_calendar-edit.svg',
                  hint: 'Ngày sinh *',
                  value: _birthCtrl.text,
                ),
              ),
              const SizedBox(height: 12),

              // Giới tính toggle
              const Text('Giới tính',
                  style:
                      TextStyle(fontSize: 13, color: Colors.black54)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _buildGenderCard('Nam', 'assets/icons/icon_male.svg')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildGenderCard('Nữ', 'assets/icons/icon_female.svg')),
                ],
              ),
              const SizedBox(height: 12),

              // CMND
              _buildTextField(
                svgPath: 'assets/icons/icon_personalcard.svg',
                hint: 'CMND/CCCD/Hộ chiếu *',
                controller: _idCtrl,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),

              // SĐT
              _buildTextField(
                svgPath: 'assets/icons/icon_mobile.svg',
                hint: 'Số điện thoại *',
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),

              // Email
              _buildTextField(
                svgPath: 'assets/icons/icon_email.svg',
                hint: 'Email',
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF5E8BF),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Hủy',
                            style: TextStyle(
                                color: Color(0xFFBB8A0B),
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          final updated = widget.initialInfo.copyWith(
                            name: _nameCtrl.text,
                            birthDate: _birthCtrl.text,
                            gender: _gender,
                            idNumber: _idCtrl.text,
                            phone: _phoneCtrl.text,
                            email: _emailCtrl.text,
                          );
                          Navigator.pop(context, updated);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFBB8A0B),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Xác nhận',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderCard(String label, String svgPath) {
    final isSelected = _gender == label;
    return GestureDetector(
      onTap: () => setState(() => _gender = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFBB8A0B)
                : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(svgPath, width: 24, height: 24),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.normal,
                )),
            const Spacer(),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFBB8A0B)
                      : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFBB8A0B),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String svgPath,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          SvgPicture.asset(svgPath, width: 20, height: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle:
                    TextStyle(fontSize: 14, color: Colors.grey.shade500),
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12),
              ),
              style:
                  const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadonlyField({
    required String svgPath,
    required String hint,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          SvgPicture.asset(svgPath, width: 20, height: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : hint,
              style: TextStyle(
                fontSize: 14,
                color: value.isNotEmpty
                    ? Colors.black87
                    : Colors.grey.shade500,
              ),
            ),
          ),
          Icon(Icons.keyboard_arrow_down,
              color: Colors.grey.shade500, size: 20),
        ],
      ),
    );
  }
}
