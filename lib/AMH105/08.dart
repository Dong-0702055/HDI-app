import 'package:flutter/material.dart';
import 'package:my_hdi/AMH105/insurance_package.dart';
import 'package:my_hdi/AMH105/09.dart';
import 'package:intl/intl.dart';
import 'package:my_hdi/AMH105/10.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_hdi/AMH105/04.dart';

class XacNhanThongTinScreen extends StatefulWidget {
  final String destination;
  final String dateRange;
  final String people;
  final InsurancePackage selectedPackage;

  const XacNhanThongTinScreen({
    super.key,
    required this.selectedPackage,
    required this.destination,
    required this.people,
    required this.dateRange,
  });

  @override
  State<XacNhanThongTinScreen> createState() => _XacNhanThongTinScreenState();
}

class _XacNhanThongTinScreenState extends State<XacNhanThongTinScreen> {
  bool isInvoice = false;
  bool isChecked = true;
  final TextEditingController nameController = TextEditingController();

  final TextEditingController birthController = TextEditingController();

  final TextEditingController cccdController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  List<InsuredPerson> insuredPersons = [];

  late int peopleCount;
  late String destination;
  late String dateRange;
  late String people;

  @override
  void initState() {
    super.initState();

    destination = widget.destination;
    dateRange = widget.dateRange;
    people = widget.people;

    peopleCount = int.parse(people);
  }

  @override
  Widget build(BuildContext context) {
    double originalPrice = 6685000;

    bool hasDiscount = peopleCount >= 5 && peopleCount <= 10;

    double discount = hasDiscount ? originalPrice * 0.05 : 0;

    double finalPrice = originalPrice - discount;
    final moneyFormat = NumberFormat("#,###", "vi_VN");

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
                        "Thông tin người được bảo hiểm",

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
                      /// BÊN MUA
                      const Text(
                        "Bên mua bảo hiểm",

                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 14),

                      buildField(
                        icon: "assets/image/105/hoten.png",

                        label: "Họ và tên *",

                        controller: nameController,
                      ),

                      const SizedBox(height: 12),

                      buildField(
                        icon: "assets/image/105/ngaysinh.png",
                        label: "Ngày sinh *",
                        controller: birthController,
                        isDropdown: true,
                        readOnly: true,

                        onTap: () async {
                          DateTime tempDate = DateTime(1990, 11, 20);

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
                                              setState(() {
                                                birthController.text =
                                                    DateFormat(
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
                      ),

                      const SizedBox(height: 12),

                      buildField(
                        icon: "assets/image/105/cccd.png",

                        label: "CMND/CCCD/Hộ chiếu *",
                        controller: cccdController,
                      ),

                      const SizedBox(height: 12),

                      buildField(
                        icon: "assets/image/105/sdt.png",

                        label: "Số điện thoại *",
                        controller: phoneController,
                      ),

                      const SizedBox(height: 12),

                      buildField(
                        icon: "assets/image/105/email.png",

                        label: "Email *",
                        controller: emailController,
                      ),

                      const SizedBox(height: 28),

                      /// THÔNG TIN CHUYẾN ĐI
                      const Text(
                        "Thông tin chuyến đi",

                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 14),

                      GestureDetector(
                        onTap: () {
                          showDestinationBottomSheet(
                            context,

                            onConfirm: (value) {
                              setState(() {
                                destination = value.join(", ");
                              });
                            },
                          );
                        },

                        child: buildField(
                          icon: "assets/image/105/diadiem.png",
                          label: "Điểm đến *",
                          value: destination,
                          isDropdown: true,
                        ),
                      ),

                      const SizedBox(height: 12),

                      GestureDetector(
                        onTap: () {
                          showDateBottomSheet(
                            context,

                            onConfirm: (DateTime start, DateTime end) {
                              setState(() {
                                dateRange =
                                    "${start.day}/${start.month}/${start.year}"
                                    " - "
                                    "${end.day}/${end.month}/${end.year}";
                              });
                            },
                          );
                        },

                        child: buildField(
                          icon: "assets/image/105/ngaygio.png",
                          label: "Ngày đi - Ngày về *",
                          value: dateRange,
                          isDropdown: true,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Tôi muốn nhận Hóa đơn điện tử",

                              style: TextStyle(fontSize: 13),
                            ),
                          ),

                          Switch(
                            value: isInvoice,

                            activeColor: const Color(0xff2F7D32),

                            onChanged: (v) {
                              setState(() {
                                isInvoice = v;
                              });
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      /// NGƯỜI ĐƯỢC BH
                      const Text(
                        "Người được bảo hiểm",

                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 14),

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

                                if (isChecked) {
                                  final buyer = InsuredPerson(
                                    name: nameController.text,
                                    birth: birthController.text,
                                    cccd: cccdController.text,
                                    isBuyer: true,
                                  );

                                  bool alreadyExists = insuredPersons.any(
                                    (e) => e.isBuyer,
                                  );

                                  if (!alreadyExists) {
                                    insuredPersons.insert(0, buyer);
                                  }
                                } else {
                                  insuredPersons.removeWhere((e) => e.isBuyer);
                                }
                              });
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (_) => DanhSachNguoiBHScreen(
                                people: peopleCount,
                                initialPersons: insuredPersons,
                              ),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              insuredPersons = result["persons"];

                              final buyer = result["buyer"];

                              if (buyer != null && buyer.name.isNotEmpty) {
                                nameController.text = buyer.name;

                                birthController.text = buyer.birth;

                                cccdController.text = buyer.cccd;
                              }
                            });
                          }
                        },

                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),

                            border: Border.all(color: const Color(0xffC69214)),
                          ),

                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Danh sách người được bảo hiểm ($peopleCount)",

                                  style: const TextStyle(
                                    color: Color(0xffC69214),

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              const Icon(
                                Icons.arrow_forward_ios,

                                size: 16,

                                color: Color(0xffC69214),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 120),
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
                  /// ================= GROUP 1 =================
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Expanded(
                        child: Text(
                          "Bảo hiểm du lịch\nquốc tế",

                          style: TextStyle(fontSize: 13),
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          Text(
                            widget.selectedPackage.title,

                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "${moneyFormat.format(finalPrice)}VNĐ",

                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "(Bao gồm VAT)",

                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  /// ================= GROUP 2 =================
                  if (hasDiscount) ...[
                    const SizedBox(height: 18),

                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),

                        color: Colors.grey.shade50,
                      ),

                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                "$peopleCount x người:",

                                style: const TextStyle(fontSize: 13),
                              ),

                              Text(
                                "${moneyFormat.format(originalPrice)}VNĐ",

                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,

                                  decoration: TextDecoration.lineThrough,

                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Ưu đãi 5% nhóm 5-10 người:",

                                  style: TextStyle(
                                    color: Colors.green,

                                    fontWeight: FontWeight.bold,

                                    fontSize: 13,
                                  ),
                                ),
                              ),

                              Text(
                                "- ${moneyFormat.format(discount)}đ",

                                style: const TextStyle(
                                  color: Colors.green,

                                  fontWeight: FontWeight.bold,

                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 18),

                  /// BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CamKetThanhToanScreen(
                              buyerName: nameController.text,
                              buyerBirth: birthController.text,
                              buyerCccd: cccdController.text,
                              buyerPhone: phoneController.text,
                              buyerEmail: emailController.text,
                              insuredPersons: insuredPersons,
                              selectedPackage: widget.selectedPackage,
                            ),
                          ),
                        );
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// FIELD
  Widget buildField({
    required String icon,
    required String label,
    TextEditingController? controller,
    String? value,
    bool isDropdown = false,
    VoidCallback? onTap,
    bool readOnly = false,
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
                    readOnly: readOnly,
                    onTap: onTap,

                    decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: label,

                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),

                      isDense: true,
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

                      if (value != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 3),

                          child: Text(value),
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
}
