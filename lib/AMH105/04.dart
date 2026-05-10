import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TripInfo {
  final String destination;
  final String date;
  final String people;

  TripInfo({
    required this.destination,
    required this.date,
    required this.people,
  });
}

class ThongTinChuyenDiScreen extends StatefulWidget {
  const ThongTinChuyenDiScreen({super.key});
  State<ThongTinChuyenDiScreen> createState() => _ThongTinChuyenDiScreenState();
}

class _ThongTinChuyenDiScreenState extends State<ThongTinChuyenDiScreen> {
  String dateText = "";
  String destinationText = "";
  String peopleText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            /// ================= HEADER =================
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
                        "Thông tin chuyến đi",

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

            /// ================= BODY =================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                    inputBox(
                      icon: Icons.location_on_outlined,

                      title: "Điểm đến *",

                      value: destinationText.isEmpty ? null : destinationText,

                      onTap: () {
                        showDestinationBottomSheet(
                          context,

                          onConfirm: (value) {
                            setState(() {
                              destinationText = value.join(", ");
                            });
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    /// NGÀY
                    inputBox(
                      icon: Icons.calendar_month_outlined,

                      title: "Ngày đi - Ngày về *",

                      value: dateText.isEmpty ? null : dateText,

                      isHighlight: true,

                      onTap: () {
                        showDateBottomSheet(
                          context,

                          onConfirm: (DateTime start, DateTime end) {
                            setState(() {
                              dateText =
                                  "${start.day}/${start.month}/${start.year}"
                                  " - "
                                  "${end.day}/${end.month}/${end.year}";
                            });
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    /// SỐ NGƯỜI
                    /// SỐ NGƯỜI
                    inputBox(
                      icon: Icons.person_outline,
                      title: "Số người *",
                      value: peopleText.isEmpty ? null : peopleText,
                      isHighlight: true,

                      onTap: () {
                        showPeopleBottomSheet(
                          context,

                          onConfirm: (value) {
                            setState(() {
                              peopleText = value;
                            });
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    const Spacer(),

                    /// BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 52,

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                            context,

                            TripInfo(
                              destination: destinationText.toString(),
                              date: dateText.toString(),
                              people: peopleText.toString(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,

                          elevation: 0,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        child: Text(
                          "Tiếp theo",

                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= INPUT BOX =================
  Widget inputBox({
    required IconData icon,
    required String title,
    String? value,
    bool isHighlight = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,

        padding: const EdgeInsets.symmetric(horizontal: 16),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(14),

          border: Border.all(
            color: isHighlight ? const Color(0xffC69214) : Colors.grey.shade300,
          ),

          boxShadow: [
            BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.03)),
          ],
        ),

        child: Row(
          children: [
            Icon(icon, color: Colors.grey, size: 22),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    title,

                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                  ),

                  if (value != null && value.toString().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),

                      child: Text(
                        value.toString(),

                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

/// ================= DATE PICKER =================
void showDateBottomSheet(
  BuildContext context, {

  required Function(DateTime start, DateTime end) onConfirm,
}) {
  DateTime? startDate;
  DateTime? endDate;

  bool isSelectStart = true;

  final now = DateTime.now();

  showModalBottomSheet(
    context: context,

    isScrollControlled: true,

    backgroundColor: Colors.transparent,

    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          String formatDate(DateTime? date) {
            if (date == null) {
              return "";
            }

            List<String> weekDays = ["CN", "T2", "T3", "T4", "T5", "T6", "T7"];

            return "${weekDays[date.weekday % 7]}"
                " - "
                "${date.day}/${date.month}/${date.year}";
          }

          bool isInRange(DateTime day) {
            if (startDate == null || endDate == null) {
              return false;
            }

            return day.isAfter(startDate!) && day.isBefore(endDate!);
          }

          return Container(
            height: 760,

            decoration: const BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),

            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [
                  /// LINE
                  Container(
                    width: 70,
                    height: 5,

                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,

                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// TITLE
                  Row(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            "Chọn ngày",

                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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

                  /// START - END
                  Row(
                    children: [
                      /// START
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelectStart = true;
                            });
                          },

                          child: Container(
                            padding: const EdgeInsets.all(14),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),

                              border: Border.all(
                                color: isSelectStart
                                    ? const Color(0xffC69214)
                                    : Colors.grey.shade300,
                              ),
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                const Text(
                                  "Ngày bắt đầu",

                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  startDate == null
                                      ? "Chọn ngày"
                                      : formatDate(startDate),

                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Text("-", style: TextStyle(fontSize: 24)),

                      const SizedBox(width: 12),

                      /// END
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelectStart = false;
                            });
                          },

                          child: Container(
                            padding: const EdgeInsets.all(14),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),

                              border: Border.all(
                                color: !isSelectStart
                                    ? const Color(0xffC69214)
                                    : Colors.grey.shade300,
                              ),
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                const Text(
                                  "Ngày kết thúc",

                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  endDate == null
                                      ? "Chọn ngày"
                                      : formatDate(endDate),

                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// CALENDAR
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),

                        border: Border.all(color: Colors.grey.shade200),
                      ),

                      child: Column(
                        children: [
                          /// MONTH
                          Expanded(
                            child: TableCalendar(
                              firstDay: DateTime(2020),
                              lastDay: DateTime(2035),

                              focusedDay: startDate ?? DateTime.now(),

                              headerStyle: const HeaderStyle(
                                titleCentered: true,
                                formatButtonVisible: false,
                              ),

                              calendarStyle: CalendarStyle(
                                todayDecoration: BoxDecoration(
                                  color: Colors.orange.shade200,
                                  shape: BoxShape.circle,
                                ),

                                selectedDecoration: const BoxDecoration(
                                  color: Color(0xff1E6B3A),
                                  shape: BoxShape.circle,
                                ),

                                rangeHighlightColor: const Color(0xffCDEED4),

                                rangeStartDecoration: const BoxDecoration(
                                  color: Color(0xff1E6B3A),
                                  shape: BoxShape.circle,
                                ),

                                rangeEndDecoration: const BoxDecoration(
                                  color: Color(0xff1E6B3A),
                                  shape: BoxShape.circle,
                                ),
                              ),

                              rangeStartDay: startDate,
                              rangeEndDay: endDate,

                              rangeSelectionMode: RangeSelectionMode.enforced,

                              onRangeSelected: (start, end, focusedDay) {
                                setState(() {
                                  startDate = start;
                                  endDate = end;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 52,

                    child: ElevatedButton(
                      onPressed: () {
                        if (startDate != null && endDate != null) {
                          onConfirm(startDate!, endDate!);
                        }

                        Navigator.pop(context);
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffC69214),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: const Text(
                        "Xác nhận",

                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
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

/// ================= WEEK TEXT =================
class WeekText extends StatelessWidget {
  final String text;

  const WeekText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,

      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xffC69214),
      ),
    );
  }
}

/// ================= DESTINATION =================
void showDestinationBottomSheet(
  BuildContext context, {
  required Function(List<String>) onConfirm,
}) {
  final TextEditingController searchController = TextEditingController();

  final Map<String, List<String>> regions = {
    "Châu Á": [
      "Afghanistan",
      "Ấn Độ",
      "Hàn Quốc",
      "Nhật Bản",
      "Singapore",
      "Thái Lan",
    ],
    "Châu Âu": ["Anh", "Đức", "Pháp", "Hà Lan", "Ý"],
    "Bắc Mỹ": ["Mỹ", "Canada", "Mexico"],
    "Châu Đại Dương": ["Úc", "New Zealand"],
    "Châu Phi": ["Ai Cập", "Nam Phi"],
  };

  List<String> selectedCountries = [];

  Map<String, bool> expandState = {
    "Châu Á": false,
    "Châu Âu": false,
    "Bắc Mỹ": false,
    "Châu Đại Dương": false,
    "Châu Phi": false,
  };

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          String keyword = searchController.text.toLowerCase();

          /// kiểm tra có dữ liệu không
          bool hasResult = regions.values.any(
            (countries) =>
                countries.any((e) => e.toLowerCase().contains(keyword)),
          );

          return AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),

            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,

              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),

              child: SafeArea(
                top: false,

                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    /// line
                    Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),

                      child: Row(
                        children: [
                          const Spacer(),

                          const Text(
                            "Chọn điểm đến",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const Spacer(),

                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.close, size: 24),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    /// search
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),

                      child: Container(
                        height: 54,
                        padding: const EdgeInsets.symmetric(horizontal: 14),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xffC69214)),
                        ),

                        child: Row(
                          children: [
                            const Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 22,
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: TextField(
                                controller: searchController,
                                onChanged: (_) => setState(() {}),

                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Tìm kiếm quốc gia",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// selected tags
                    if (selectedCountries.isNotEmpty)
                      SizedBox(
                        height: 40,

                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedCountries.length,

                          itemBuilder: (context, index) {
                            final country = selectedCountries[index];

                            return Container(
                              margin: const EdgeInsets.only(right: 10),

                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),

                              decoration: BoxDecoration(
                                color: const Color(0xffF4F4F4),
                                borderRadius: BorderRadius.circular(10),
                              ),

                              child: Row(
                                children: [
                                  Text(
                                    country,
                                    style: const TextStyle(fontSize: 13),
                                  ),

                                  const SizedBox(width: 6),

                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedCountries.remove(country);
                                      });
                                    },

                                    child: const Icon(Icons.close, size: 16),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                    if (selectedCountries.isNotEmpty)
                      const SizedBox(height: 16),

                    /// content
                    Expanded(
                      child: !hasResult && keyword.isNotEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/image/105/105_bh_6.png",
                                    width: 140,
                                  ),

                                  const SizedBox(height: 18),

                                  const Text(
                                    "Không có quốc gia tìm kiếm.\nVui lòng nhập lại chính xác",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),

                              child: Column(
                                children: regions.entries.map((entry) {
                                  String regionName = entry.key;

                                  List<String> countries = entry.value;

                                  List<String> filtered = countries.where((e) {
                                    return e.toLowerCase().contains(keyword);
                                  }).toList();

                                  if (filtered.isEmpty && keyword.isNotEmpty) {
                                    return const SizedBox();
                                  }

                                  bool isExpand =
                                      expandState[regionName] ?? false;

                                  if (keyword.isNotEmpty) {
                                    isExpand = true;
                                  }

                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 14),

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),

                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              expandState[regionName] =
                                                  !isExpand;
                                            });
                                          },

                                          child: Container(
                                            padding: const EdgeInsets.all(16),

                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    regionName,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff4F7F4F),
                                                    ),
                                                  ),
                                                ),

                                                Icon(
                                                  isExpand
                                                      ? Icons.keyboard_arrow_up
                                                      : Icons
                                                            .keyboard_arrow_down,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        if (isExpand)
                                          Column(
                                            children: filtered.map((country) {
                                              bool isSelected =
                                                  selectedCountries.contains(
                                                    country,
                                                  );

                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (isSelected) {
                                                      selectedCountries.remove(
                                                        country,
                                                      );
                                                    } else {
                                                      selectedCountries.add(
                                                        country,
                                                      );
                                                    }
                                                  });
                                                },

                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 14,
                                                      ),

                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                        color: Colors
                                                            .grey
                                                            .shade200,
                                                      ),
                                                    ),
                                                  ),

                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(country),
                                                      ),

                                                      Container(
                                                        width: 22,
                                                        height: 22,

                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                6,
                                                              ),

                                                          color: isSelected
                                                              ? const Color(
                                                                  0xff1E6B3A,
                                                                )
                                                              : Colors
                                                                    .transparent,

                                                          border: Border.all(
                                                            color: isSelected
                                                                ? const Color(
                                                                    0xff1E6B3A,
                                                                  )
                                                                : Colors
                                                                      .grey
                                                                      .shade400,
                                                          ),
                                                        ),

                                                        child: isSelected
                                                            ? const Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .white,
                                                                size: 15,
                                                              )
                                                            : null,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                    ),

                    /// button
                    Padding(
                      padding: const EdgeInsets.all(16),

                      child: SizedBox(
                        width: double.infinity,
                        height: 52,

                        child: ElevatedButton(
                          onPressed: selectedCountries.isEmpty
                              ? null
                              : () {
                                  onConfirm(selectedCountries);
                                  Navigator.pop(context);
                                },

                          style: ElevatedButton.styleFrom(
                            elevation: 0,

                            backgroundColor: const Color(0xffC69214),

                            disabledBackgroundColor: Colors.grey.shade200,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),

                          child: Text(
                            "Xác nhận",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: selectedCountries.isEmpty
                                  ? Colors.grey
                                  : Colors.white,
                            ),
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
    },
  );
}

/// ================= REGION =================
Widget regionItem(String title) {
  return Container(
    padding: const EdgeInsets.all(16),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),

      border: Border.all(color: Colors.grey.shade200),
    ),

    child: Row(
      children: [
        Expanded(
          child: Text(
            title,

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff4F7F4F),
            ),
          ),
        ),

        const Icon(Icons.keyboard_arrow_down),
      ],
    ),
  );
}

void showPeopleBottomSheet(
  BuildContext context, {
  required Function(String value) onConfirm,
}) {
  final TextEditingController controller = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,

    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),

        child: Container(
          padding: const EdgeInsets.all(20),

          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Nhập số người",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 24),

              TextField(
                controller: controller,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  hintText: "Ví dụ: 4",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),

                    borderSide: const BorderSide(color: Color(0xffC69214)),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton(
                  onPressed: () {
                    if (controller.text.trim().isEmpty) {
                      return;
                    }

                    onConfirm(controller.text);

                    Navigator.pop(context);
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffC69214),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  child: const Text(
                    "Xác nhận",
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
      );
    },
  );
}
