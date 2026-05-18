import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'clause.dart';
import 'succes_register.dart';
class RegisterDefault extends StatefulWidget{
  const RegisterDefault({super.key});
  static void show(BuildContext context){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context)=> const RegisterDefault(),
        );
  }

  @override
  State<RegisterDefault> createState() => _RegisterDefaultState();
}
class _RegisterDefaultState extends State<RegisterDefault> {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _isObscurePass = true;
  bool _isObscureConfirm = true;
  bool _canRegister = false;

  void _validate() {
    setState(() {
      _canRegister = (_phoneController.text.length == 10 ||
          _phoneController.text.length == 11) &&
          _nameController.text.isNotEmpty &&
          _passController.text.isNotEmpty &&
          _passController.text == _confirmPassController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery
          .of(context)
          .viewInsets
          .bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(width: 40,
              height: 4,
              decoration: BoxDecoration(color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48),
                const Text("Đăng ký tài khoản", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 17)),
                IconButton(icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  onChanged: (_) => _validate(),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                        Icons.phone_android_outlined, color: Colors.grey),
                    labelText: "Số điện thoại",
                    labelStyle: const TextStyle(color: Colors.grey),
                    floatingLabelStyle: const TextStyle(
                        color: Color(0xFFBB8A0B)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFBB8A0B)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _nameController,
                  hint: "Họ tên",
                  icon: Icons.person_outline,
                ),
                _buildPasswordField(
                  controller: _passController,
                  hint: "Mật khẩu",
                  isObscure: _isObscurePass,
                  onToggle: () =>
                      setState(() => _isObscurePass = !_isObscurePass),
                ),
                const SizedBox(height: 15),
                _buildPasswordField(
                  controller: _confirmPassController,
                  hint: "Xác nhận mật khẩu",
                  isObscure: _isObscureConfirm,
                  onToggle: () =>
                      setState(() => _isObscureConfirm = !_isObscureConfirm),
                ),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(
                        text: "Bằng việc nhấn nút ĐĂNG KÝ, bạn đã đồng ý với ",
                      ),

                      TextSpan(
                        text: "Điều khoản điều kiện của Bảo hiểm HD",
                        style: const TextStyle(
                          color: Color(0xFFBB8A0B),
                          fontWeight: FontWeight.bold,
                        ),

                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_)=>Clause(),))
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _canRegister ? ()=> SuccessDialog.show(context) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _canRegister
                          ? const Color(0xFFBB8A0B)
                          : Colors.grey[200],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      "Đăng ký",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _canRegister ? Colors.white : Colors.grey[500],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: (_) => _validate(),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        labelText: hint,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 15),
        floatingLabelStyle: const TextStyle(color: Color(0xFFBB8A0B)),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFBB8A0B)),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isObscure,
    required VoidCallback onToggle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        onChanged: (_) => _validate(),
        decoration: InputDecoration(
          prefixIcon: ImageIcon(AssetImage("assets/icons/icon_pass.png")),
          suffixIcon: IconButton(
            icon: Icon(isObscure ? Icons.visibility_off_outlined : Icons
                .visibility_outlined, color: Colors.grey),
            onPressed: onToggle,
          ),
          labelText: hint,
          // Label sẽ bay lên khi click hoặc nhập liệu
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 15),
          floatingLabelStyle: const TextStyle(color: Color(0xFFBB8A0B)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[200]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFBB8A0B)),
          ),
        ),
      ),
    );
  }
}