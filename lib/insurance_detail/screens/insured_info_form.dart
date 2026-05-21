import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_hdi/insurance_detail/screens/confirm_info.dart';
import '../models/comparison_data.dart';
import '../../../shared/widgets/hdi_app_bar.dart';
import '../../../shared/widgets/step_indicator.dart';
import '../../../shared/widgets/bottom_action_bar.dart';
import '../../../shared/widgets/form_field_tile.dart';
import '../../../shared/widgets/tappable_field_tile.dart';

class InsuredInfoFormScreen extends StatefulWidget {
  final ComparisonPackage selectedPackage;

  const InsuredInfoFormScreen({super.key, required this.selectedPackage});

  @override
  State<InsuredInfoFormScreen> createState() => _InsuredInfoFormScreenState();
}

class _InsuredInfoFormScreenState extends State<InsuredInfoFormScreen> {
  final _nameController = TextEditingController();
  final _birthController = TextEditingController();
  final _cccdController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  String? _selectedGender;
  bool _wantsInvoice = false;

  @override
  void dispose() {
    _nameController.dispose();
    _birthController.dispose();
    _cccdController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  void _pickDate(TextEditingController controller, String title) {
    DateTime tempDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModal) => SizedBox(
            height: 420,
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
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pop(ctx),
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: tempDate,
                      minimumDate: DateTime(1950),
                      maximumDate: DateTime(2100),
                      onDateTimeChanged: (val) {
                        tempDate = val;
                        setModal(() {});
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.text = DateFormat(
                            'dd/MM/yyyy',
                          ).format(tempDate);
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
                      child: const Text(
                        'Xác nhận',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  void _pickGender() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              const Text(
                'Giới tính',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...['Nam', 'Nữ', 'Khác'].map((gender) {
                final isSelected = _selectedGender == gender;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedGender = gender);
                    Navigator.pop(ctx);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2F7D32)
                            : Colors.grey.shade300,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: isSelected
                              ? const Color(0xFF2F7D32)
                              : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        Text(gender, style: const TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ✅ Dùng HdiAppBar thay vì copy-paste AppBar
      appBar: HdiAppBar(title: 'Thông tin người được bảo hiểm'),
      body: Column(
        children: [
          // ✅ Dùng StepIndicator, chỉ truyền currentStep
          const StepIndicator(currentStep: 2),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Dùng FormFieldTile thay vì _buildField
                  FormFieldTile(
                    svgPath: 'assets/icons/icon_user.svg',
                    label: 'Họ và tên *',
                    controller: _nameController,
                    hint: 'Nguyễn Văn A',
                  ),
                  const SizedBox(height: 12),

                  // ✅ Dùng TappableFieldTile thay vì _buildTappableField
                  TappableFieldTile(
                    svgPath: 'assets/icons/icon_calendar-edit.svg',
                    label: 'Ngày sinh *',
                    value: _birthController.text,
                    onTap: () => _pickDate(_birthController, 'Ngày sinh'),
                  ),
                  const SizedBox(height: 12),

                  TappableFieldTile(
                    svgPath: 'assets/icons/icon_user-tag.svg',
                    label: 'Giới tính *',
                    value: _selectedGender ?? '',
                    onTap: _pickGender,
                  ),
                  const SizedBox(height: 12),

                  FormFieldTile(
                    svgPath: 'assets/icons/icon_personalcard.svg',
                    label: 'CMND/CCCD/Hộ chiếu *',
                    controller: _cccdController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),

                  FormFieldTile(
                    svgPath: 'assets/icons/icon_mobile.svg',
                    label: 'Số điện thoại *',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),

                  FormFieldTile(
                    svgPath: 'assets/icons/icon_email.svg',
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Thời hạn bảo hiểm',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 14),

                  TappableFieldTile(
                    svgPath: 'assets/icons/icon_calendar-edit.svg',
                    label: 'Ngày bắt đầu hiệu lực *',
                    value: _startDateController.text,
                    onTap: () => _pickDate(
                      _startDateController,
                      'Ngày bắt đầu hiệu lực',
                    ),
                  ),
                  const SizedBox(height: 12),

                  TappableFieldTile(
                    svgPath: 'assets/icons/icon_calendar-edit.svg',
                    label: 'Ngày hết hiệu lực *',
                    value: _endDateController.text,
                    onTap: () =>
                        _pickDate(_endDateController, 'Ngày hết hiệu lực'),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Tôi muốn nhận Hoá đơn điện tử',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Switch(
                        value: _wantsInvoice,
                        activeThumbColor: const Color(0xFF2F7D32),
                        onChanged: (v) => setState(() => _wantsInvoice = v),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          // ✅ Dùng BottomActionBar thay vì _buildBottomBar
          BottomActionBar(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ConfirmInfoScreen(
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
}
