import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:my_hdi/AMH105/07.dart';

class InsuredPerson {
  String name;
  String birth;
  String cccd;
  bool isBuyer;

  InsuredPerson({
    required this.name,
    required this.birth,
    required this.cccd,
    this.isBuyer = false,
  });
}

class DanhSachNguoiBHScreen extends StatefulWidget {
  final int people;
  final List<InsuredPerson> initialPersons;
  const DanhSachNguoiBHScreen({
    super.key,
    required this.people,
    required this.initialPersons,
  });

  @override
  State<DanhSachNguoiBHScreen> createState() => _DanhSachNguoiBHScreenState();
}

class _DanhSachNguoiBHScreenState extends State<DanhSachNguoiBHScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController cccdController = TextEditingController();

  String selectedDate = "";

  bool isChecked = false;

  late List<InsuredPerson?> persons;

  @override
  void initState() {
    super.initState();

    /// sinh sẵn số card trống
    persons = List<InsuredPerson?>.from(widget.initialPersons);

    while (persons.length < widget.people) {
      persons.add(null);
    }
    isChecked = persons.any((e) => e?.isBuyer == true);
  }

  bool get hasDiscount => persons.length >= 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Container(
              height: 60,

              padding: const EdgeInsets.symmetric(horizontal: 16),

              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff3D9B3D), Color(0xff006B2D)],
                ),
              ),

              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        "Danh sách người được bảo hiểm",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Danh sách người được bảo hiểm (${persons.length})",

                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Bên mua bảo hiểm đồng thời là người được bảo hiểm",

                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),

                          Checkbox(
                            value: isChecked,

                            activeColor: const Color(0xff2F7D32),

                            onChanged: (v) {
                              setState(() {
                                isChecked = v ?? false;
                              });
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// LIST CARD
                      ...List.generate(persons.length, (index) {
                        final person = persons[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),

                          child: person == null
                              ? buildEmptyCard(
                                  () {
                                    showSelectInputMethod(editIndex: index);
                                  },

                                  onDelete: () {
                                    setState(() {
                                      persons.removeAt(index);
                                    });
                                  },
                                )
                              : buildPersonCard(
                                  person: person,

                                  onEdit: () {
                                    showSelectInputMethod(editIndex: index);
                                  },

                                  onDelete: () {
                                    setState(() {
                                      persons.removeAt(index);
                                    });
                                  },
                                ),
                        );
                      }),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            /// BOTTOM
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,

                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),

              child: Column(
                children: [
                  if (hasDiscount)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),

                      child: Text(
                        "Ưu đãi 5% nhóm 5-10 người",

                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,

                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                persons.add(null);
                              });
                            },

                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xffC69214)),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            child: const Text(
                              "Thêm người được bảo hiểm",

                              textAlign: TextAlign.center,

                              style: TextStyle(
                                color: Color(0xffC69214),

                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: SizedBox(
                          height: 48,

                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, {
                                "persons": persons
                                    .whereType<InsuredPerson>()
                                    .toList(),

                                "buyer": persons
                                    .whereType<InsuredPerson>()
                                    .firstWhere(
                                      (e) => e.isBuyer,
                                      orElse: () => InsuredPerson(
                                        name: "",
                                        birth: "",
                                        cccd: "",
                                      ),
                                    ),
                              });
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffC69214),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            child: const Text(
                              "Tiếp tục",

                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// INPUT DIALOG
  void showInputDialog({required int editIndex}) {
    if (persons[editIndex] != null) {
      nameController.text = persons[editIndex]!.name;

      cccdController.text = persons[editIndex]!.cccd;

      selectedDate = persons[editIndex]!.birth;
    } else {
      nameController.clear();
      cccdController.clear();
      selectedDate = "";
    }

    showDialog(
      context: context,

      barrierDismissible: false,

      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    buildInputField(
                      controller: nameController,

                      icon: "assets/image/105/hoten.png",

                      label: "Họ và tên *",
                    ),

                    const SizedBox(height: 14),

                    GestureDetector(
                      onTap: () async {
                        DateTime tempDate = DateTime(1999, 9, 9);

                        if (selectedDate.isNotEmpty) {
                          try {
                            tempDate = DateFormat(
                              "dd/MM/yyyy",
                            ).parse(selectedDate);
                          } catch (_) {}
                        }

                        showModalBottomSheet(
                          context: context,

                          backgroundColor: Colors.white,

                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),

                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setModalState) {
                                return Container(
                                  height: 420,

                                  padding: const EdgeInsets.all(20),

                                  child: Column(
                                    children: [
                                      /// LINE
                                      Container(
                                        width: 60,
                                        height: 5,

                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,

                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 18),

                                      /// TITLE
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: Center(
                                              child: Text(
                                                "Ngày sinh",

                                                style: TextStyle(
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),

                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },

                                            child: const Icon(
                                              Icons.close,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 18),

                                      Text(
                                        "Độ tuổi áp dụng bảo hiểm "
                                        "${DateFormat("dd/MM/yyyy").format(tempDate)}"
                                        " - ${DateTime.now().year - tempDate.year} tuổi",

                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),

                                      const SizedBox(height: 18),

                                      /// DATE PICKER
                                      Expanded(
                                        child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.date,

                                          initialDateTime: tempDate,

                                          minimumDate: DateTime(1950),

                                          maximumDate: DateTime.now(),

                                          onDateTimeChanged: (value) {
                                            tempDate = value;

                                            setModalState(() {});
                                          },
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      /// BUTTON
                                      SizedBox(
                                        width: double.infinity,
                                        height: 54,

                                        child: ElevatedButton(
                                          onPressed: () {
                                            setStateDialog(() {
                                              selectedDate = DateFormat(
                                                "dd/MM/yyyy",
                                              ).format(tempDate);
                                            });

                                            Navigator.pop(context);
                                          },

                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xffC69214,
                                            ),

                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),

                                          child: const Text(
                                            "Xác nhận",

                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },

                      child: buildInputField(
                        icon: "assets/image/105/ngaysinh.png",

                        label: "Ngày sinh *",

                        value: selectedDate,

                        isDropdown: true,
                      ),
                    ),

                    const SizedBox(height: 14),

                    buildInputField(
                      controller: cccdController,

                      icon: "assets/image/105/cccd.png",

                      label: "CMND/CCCD/Hộ chiếu *",

                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 46,

                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffF5E8BF),

                                elevation: 0,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              child: const Text(
                                "Hủy",

                                style: TextStyle(color: Color(0xffC69214)),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: SizedBox(
                            height: 46,

                            child: ElevatedButton(
                              onPressed: () {
                                if (nameController.text.isEmpty ||
                                    cccdController.text.isEmpty ||
                                    selectedDate.isEmpty) {
                                  return;
                                }

                                setState(() {
                                  persons[editIndex] = InsuredPerson(
                                    name: nameController.text,

                                    birth: selectedDate,

                                    cccd: cccdController.text,
                                    isBuyer:
                                        persons[editIndex]?.isBuyer ?? false,
                                  );
                                });

                                Navigator.pop(context);
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffC69214),

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              child: const Text(
                                "Xác nhận",

                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showSelectInputMethod({required int editIndex}) {
    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.white,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              /// LINE
              Container(
                width: 60,
                height: 5,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 18),

              /// HEADER
              Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Lựa chọn thêm thông tin người",

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// CHỤP ẢNH
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);

                  final result = await Navigator.push(
                    context,

                    MaterialPageRoute(builder: (_) => const CameraCmndScreen()),
                  );

                  if (result != null) {
                    setState(() {
                      persons[editIndex] = InsuredPerson(
                        name: result["name"] ?? "",

                        birth: result["birth"] ?? "",

                        cccd: result["cccd"] ?? "",

                        isBuyer: persons[editIndex]?.isBuyer ?? false,
                      );
                    });
                  }
                },

                child: buildUploadBox(
                  icon: "assets/image/105/camera.png",

                  title: "Chụp ảnh CMND/CCCD/Hộ chiếu",
                ),
              ),

              const SizedBox(height: 14),

              /// NHẬP TAY
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  showInputDialog(editIndex: editIndex);
                },

                child: buildUploadBox(
                  icon: "assets/image/105/edit.png",

                  title: "Hoặc nhập tay",

                  hasArrow: true,
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget buildUploadBox({
    required String icon,
    required String title,
    bool hasArrow = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),

        border: Border.all(
          color: const Color(0xff8DB38B),
          style: BorderStyle.solid,
        ),
      ),

      child: Row(
        children: [
          Image.asset(icon, width: 24, height: 24),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,

              style: const TextStyle(fontSize: 14, color: Color(0xff4B4B4B)),
            ),
          ),

          if (hasArrow) const Icon(Icons.arrow_forward, color: Colors.black54),
        ],
      ),
    );
  }
}

/// INPUT FIELD
Widget buildInputField({
  TextEditingController? controller,
  required String icon,
  required String label,
  String? value,
  bool isDropdown = false,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),

      border: Border.all(color: Colors.grey.shade300),
    ),

    child: Row(
      children: [
        Image.asset(icon, width: 20, height: 20),

        const SizedBox(width: 12),

        Expanded(
          child: controller != null
              ? TextField(
                  controller: controller,

                  keyboardType: keyboardType,

                  decoration: InputDecoration(
                    isDense: true,

                    border: InputBorder.none,

                    hintText: label,

                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      label,

                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),

                    if (value != null && value.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),

                        child: Text(
                          value,

                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                  ],
                ),
        ),

        if (isDropdown)
          Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
      ],
    ),
  );
}

/// CARD ĐÃ NHẬP
Widget buildPersonCard({
  required InsuredPerson person,
  required VoidCallback onEdit,
  required VoidCallback onDelete,
}) {
  return Stack(
    children: [
      Container(
        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(14),

          boxShadow: [
            BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.04)),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// HỌ TÊN
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                SizedBox(
                  width: 120,

                  child: Text(
                    "Họ tên:",

                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  ),
                ),

                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Flexible(
                        child: Text(
                          person.name,

                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black87,
                          ),

                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(width: 6),

                      GestureDetector(
                        onTap: onEdit,

                        child: Image.asset(
                          "assets/image/105/sua.png",
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            /// NGÀY SINH
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(
                  width: 120,

                  child: Text(
                    "Ngày sinh:",

                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  ),
                ),

                Expanded(
                  child: Text(
                    person.birth,

                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            /// CCCD
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(
                  width: 120,

                  child: Text(
                    "CMND/CCCD/\nHộ chiếu:",

                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  ),
                ),

                Expanded(
                  child: Text(
                    person.cccd,

                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// XÓA
            Align(
              alignment: Alignment.centerRight,

              child: GestureDetector(
                onTap: onDelete,

                child: Text(
                  "Xóa",

                  style: TextStyle(
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      /// TICK GÓC PHẢI
      if (person.isBuyer)
        Positioned(
          top: 0,
          right: 0,

          child: Image.asset(
            "assets/image/105/tick.png",
            width: 42,
            height: 42,
          ),
        ),
    ],
  );
}

/// CARD TRỐNG
Widget buildEmptyCard(VoidCallback onTap, {required VoidCallback onDelete}) {
  return Container(
    padding: const EdgeInsets.all(14),

    decoration: BoxDecoration(
      color: Colors.white,

      borderRadius: BorderRadius.circular(14),

      boxShadow: [
        BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.04)),
      ],
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        /// HỌ TÊN
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox(
              width: 120,

              child: Text(
                "Họ tên:",

                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
            ),

            GestureDetector(
              onTap: onTap,

              child: Row(
                children: [
                  const Text(
                    "Nhập thông tin",

                    style: TextStyle(
                      color: Color(0xffC69214),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(width: 6),

                  Image.asset(
                    "assets/image/105/sua.png",
                    width: 18,
                    height: 18,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        /// NGÀY SINH
        Row(
          children: [
            SizedBox(
              width: 120,

              child: Text(
                "Ngày sinh:",

                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
            ),

            const Text(
              "/",

              style: TextStyle(
                color: Color(0xffC69214),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        /// CCCD
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              width: 120,

              child: Text(
                "CMND/CCCD/\nHộ chiếu:",

                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 2),

              child: Text(
                "/",

                style: TextStyle(
                  color: Color(0xffC69214),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        /// XÓA
        Align(
          alignment: Alignment.centerRight,

          child: GestureDetector(
            onTap: onDelete,

            child: Text(
              "Xóa",

              style: TextStyle(
                color: Colors.red.shade400,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
