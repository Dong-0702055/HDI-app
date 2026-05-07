import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/package_data.dart';

class PackageCard extends StatelessWidget {
  final InsurancePackage package;
  final bool isActive;

  const PackageCard({super.key, required this.package, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: isActive ? 16 : 32, // Scale effect through margin
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isActive
                ? Colors.blue.withValues(alpha: 0.2) // Subtle active glow
                : Colors.black.withValues(alpha: 0.1),
            blurRadius: isActive ? 20 : 10,
            offset: Offset(0, isActive ? 8 : 4),
          ),
        ],
        border: isActive
            ? Border.all(color: const Color(0xFFBB8A0B), width: 2)
            : Border.all(color: Colors.transparent, width: 2),
      ),
      child: Column(
        children: [
          // Header Image & Titles
          SizedBox(
            height: 140,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                    child: Image.asset(package.bgPath, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: -40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SvgPicture.asset(
                      package.iconPath,
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        package.name,
                        style: const TextStyle(
                          color: Color(0xFFCC0000), // Red
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        package.subtitle,
                        style: const TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        package.price,
                        style: const TextStyle(
                          color: Color(0xFF1B8A4E), // Green
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Benefits List
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Quyền lợi bảo hiểm',
                        style: TextStyle(
                          color: Color(0xFF1B8A4E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Số tiền bảo hiểm',
                        style: TextStyle(
                          color: Color(0xFF1B8A4E),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: package.benefits.length,
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: const _DashedDivider(color: Color(0xFFE0E0E0)),
                      ),
                      itemBuilder: (context, index) {
                        final key = package.benefits.keys.elementAt(index);
                        final value = package.benefits[key]!;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                key,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF444444),
                                  height: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 2,
                              child: Text(
                                value,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF1B8A4E), // Green values
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // Detail Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Chi tiết',
                            style: TextStyle(
                              color: Color(0xFFBB8A0B), // Yellow
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Color(0xFFBB8A0B),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Mua ngay Button
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBB8A0B),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Mua ngay',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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
    );
  }
}

class _DashedDivider extends StatelessWidget {
  final Color color;
  const _DashedDivider({this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
        );
      },
    );
  }
}
