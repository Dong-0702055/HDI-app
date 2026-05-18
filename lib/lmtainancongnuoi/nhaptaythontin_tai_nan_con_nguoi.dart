import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'xacnhanthongtin_tai_nan_con_nguoi.dart';

class InvoiceModel {
  final String companyName;
  final String taxCode;
  final String phoneNumber;
  final String address;

  InvoiceModel({
    required this.companyName,
    required this.taxCode,
    required this.phoneNumber,
    required this.address,
  });
}

class NhapTayThongTinScreen extends StatefulWidget {
  final Map<String, dynamic> sanPham;

  const NhapTayThongTinScreen({super.key, required this.sanPham});

  @override
  State<NhapTayThongTinScreen> createState() => _NhapTayThongTinScreenState();
}

class _NhapTayThongTinScreenState extends State<NhapTayThongTinScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isInvoiceEnabled = false;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? birthDate;
  String selectedGender = "";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  InvoiceModel? savedInvoiceData;

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "";
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  void _showRequiredSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleContinue() async {
    // 1. Validate các trường text (Họ tên, CCCD, SĐT, Email)
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // 2. Validate các trường chọn lựa
    if (birthDate == null) {
      _showRequiredSnackBar("Vui lòng chọn Ngày sinh");
      return;
    }
    if (selectedGender.isEmpty) {
      _showRequiredSnackBar("Vui lòng chọn Giới tính");
      return;
    }
    if (startDate == null) {
      _showRequiredSnackBar("Vui lòng chọn Ngày bắt đầu hiệu lực");
      return;
    }
    if (endDate == null) {
      _showRequiredSnackBar("Vui lòng chọn Ngày hết hiệu lực");
      return;
    }

    if (endDate!.isBefore(startDate!)) {
      _showRequiredSnackBar("Ngày hết hiệu lực phải sau Ngày bắt đầu");
      return;
    }

    if (isInvoiceEnabled && savedInvoiceData == null) {
      _openInvoiceForm();
      return;
    }

    _navigateToNextScreen();
  }

  void _openInvoiceForm() async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return InvoiceBottomSheetContent(initialData: savedInvoiceData);
      },
    );

    if (result != null && result is InvoiceModel) {
      setState(() {
        savedInvoiceData = result;
      });
    }
  }

  void _navigateToNextScreen() {
    final Map<String, dynamic> personalData = {
      "sanPham": widget.sanPham,
      "name": _nameController.text.trim(),
      "birthDate": birthDate,
      "gender": selectedGender,
      "idNumber": _idController.text.trim(),
      "phone": _phoneController.text.trim(),
      "email": _emailController.text.trim(),
      "startDate": startDate,
      "endDate": endDate,
      "invoiceData": savedInvoiceData,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => XacNhanThongTinScreen(dataPacket: personalData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0A7029), Color(0xFF055E20)],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Thông tin người được bảo hiểm",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      icon: Icons.person_outline,
                      label: "Họ và tên *",
                      controller: _nameController,
                      validator: (value) => (value == null || value.trim().isEmpty) ? "Vui lòng nhập họ và tên" : null,
                    ),
                    _buildDropdownField(
                      icon: Icons.calendar_today_outlined,
                      label: "Ngày sinh *",
                      onPress: () => _selectBirthDate(context),
                      value: _formatDate(birthDate),
                    ),
                    _buildDropdownField(
                      icon: Icons.person_pin_outlined,
                      label: "Giới tính *",
                      onPress: () => _showGenderPicker(context),
                      value: selectedGender,
                    ),

                    // 👉 Ô NHẬP CĂN CƯỚC CÔNG DÂN: Chỉ nhận số, bắt buộc đúng 12 số
                    _buildTextField(
                      icon: Icons.badge_outlined,
                      label: "CMND/CCCD/Hộ chiếu *",
                      controller: _idController,
                      keyboardType: TextInputType.number,
                      maxLength: 12,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return "Vui lòng nhập số CMND/CCCD/Hộ chiếu";
                        if (value.trim().length != 12) return "Số Căn cước công dân bắt buộc phải đủ 12 số";
                        return null;
                      },
                    ),

                    // 👉 Ô NHẬP SỐ ĐIỆN THOẠI: Chỉ nhận số, độ dài 10 hoặc 11 số
                    _buildTextField(
                      icon: Icons.phone_android_outlined,
                      label: "Số điện thoại *",
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 11,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return "Vui lòng nhập số điện thoại";
                        final len = value.trim().length;
                        if (len != 10 && len != 11) {
                          return "Số điện thoại phải có độ dài 10 hoặc 11 số";
                        }
                        return null;
                      },
                    ),

                    _buildTextField(
                      icon: Icons.email_outlined,
                      label: "Email *",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return "Vui lòng nhập email";
                        final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (!emailRegex.hasMatch(value.trim())) return "Định dạng Email không hợp lệ";
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      "Thời hạn bảo hiểm",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    _buildDropdownField(
                      icon: Icons.calendar_today_outlined,
                      label: "Ngày bắt đầu hiệu lực *",
                      onPress: () => _selectStartDate(context),
                      value: _formatDate(startDate),
                    ),
                    _buildDropdownField(
                      icon: Icons.calendar_today_outlined,
                      label: "Ngày hết hiệu lực *",
                      onPress: () => _selectEndDate(context),
                      value: _formatDate(endDate),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tôi muốn nhận Hoá đơn điện tử",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Switch(
                          value: isInvoiceEnabled,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              isInvoiceEnabled = value;
                              if (!value) {
                                savedInvoiceData = null;
                              }
                            });
                          },
                        ),
                      ],
                    ),

                    if (isInvoiceEnabled && savedInvoiceData != null) ...[
                      const SizedBox(height: 12),
                      _buildInvoiceSummaryCard(),
                    ],
                  ],
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB8860B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    "Tiếp tục",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceSummaryCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFC8E6C9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Thông tin xuất hóa đơn",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14),
                ),
                InkWell(
                  onTap: _openInvoiceForm,
                  child: const Row(
                    children: [
                      Text(
                        "Chỉnh sửa",
                        style: TextStyle(color: Color(0xFFB8860B), fontWeight: FontWeight.w500, fontSize: 13),
                      ),
                      Icon(Icons.chevron_right, color: Color(0xFFB8860B), size: 16),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFC8E6C9)),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _buildSummaryRow("Tên đơn vị:", savedInvoiceData!.companyName),
                _buildSummaryRow("Mã số thuế:", savedInvoiceData!.taxCode),
                _buildSummaryRow("Điện thoại:", savedInvoiceData!.phoneNumber),
                _buildSummaryRow("Địa chỉ:", savedInvoiceData!.address),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey, size: 22),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          border: InputBorder.none,
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          errorStyle: const TextStyle(height: 1.0, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required IconData icon,
    required String label,
    required VoidCallback onPress,
    String value = "",
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: onPress,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    if (value.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: birthDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0A7029),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
      });
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        endDate = picked;
      });
    }
  }

  void _showGenderPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Chọn giới tính", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.male, color: Colors.blue),
                title: const Text("Nam"),
                onTap: () {
                  setState(() => selectedGender = "Nam");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.female, color: Colors.pink),
                title: const Text("Nữ"),
                onTap: () {
                  setState(() => selectedGender = "Nữ");
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class InvoiceBottomSheetContent extends StatefulWidget {
  final InvoiceModel? initialData;
  const InvoiceBottomSheetContent({super.key, this.initialData});

  @override
  State<InvoiceBottomSheetContent> createState() => _InvoiceBottomSheetContentState();
}

class _InvoiceBottomSheetContentState extends State<InvoiceBottomSheetContent> {
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _taxCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _companyController.text = widget.initialData!.companyName;
      _taxCodeController.text = widget.initialData!.taxCode;
      _phoneController.text = widget.initialData!.phoneNumber;
      _addressController.text = widget.initialData!.address;
    }

    _companyController.addListener(_validateForm);
    _taxCodeController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _addressController.addListener(_validateForm);

    _validateForm();
  }

  @override
  void dispose() {
    _companyController.dispose();
    _taxCodeController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid = _companyController.text.trim().isNotEmpty &&
        _taxCodeController.text.trim().isNotEmpty &&
        _phoneController.text.trim().isNotEmpty &&
        _addressController.text.trim().isNotEmpty;

    if (isValid != isFormValid) {
      setState(() {
        isFormValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                const Text(
                  "Hoá đơn điện tử",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black54),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            const Divider(height: 1),
            const SizedBox(height: 16),

            _buildInvoiceField(Icons.domain, "Tên cá nhân/tổ chức *", _companyController),

            // 👉 Mã số thuế: Chỉ nhận số, chặn gõ chữ
            _buildInvoiceField(
              Icons.receipt_long,
              "Mã số thuế *",
              _taxCodeController,
              keyboardType: TextInputType.number,
              maxLength: 14,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),

            // 👉 Số điện thoại hóa đơn: Chỉ nhận số, chặn gõ chữ
            _buildInvoiceField(
              Icons.phone_android,
              "Số điện thoại *",
              _phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 11,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),

            _buildInvoiceField(Icons.place_outlined, "Địa chỉ người mua *", _addressController),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFF8E7),
                        side: const BorderSide(color: Colors.transparent),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Huỷ", style: TextStyle(color: Color(0xFFB8860B), fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: isFormValid ? () {
                        final invoiceData = InvoiceModel(
                          companyName: _companyController.text.trim(),
                          taxCode: _taxCodeController.text.trim(),
                          phoneNumber: _phoneController.text.trim(),
                          address: _addressController.text.trim(),
                        );
                        Navigator.pop(context, invoiceData);
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB8860B),
                        disabledBackgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        "Xác nhận",
                        style: TextStyle(
                          color: isFormValid ? Colors.white : Colors.black38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceField(
      IconData icon,
      String label,
      TextEditingController controller, {
        TextInputType? keyboardType,
        int? maxLength,
        List<TextInputFormatter>? inputFormatters,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey.shade600, size: 22),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          border: InputBorder.none,
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
      ),
    );
  }
}