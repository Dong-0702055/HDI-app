import 'package:flutter/material.dart';

class DotsWithTooltip extends StatelessWidget {
  final int activeIndex;
  final int dotCount;
  final List<String> labels;
  final ValueChanged<int> onDotTap;

  const DotsWithTooltip({
    super.key,
    required this.activeIndex,
    required this.dotCount,
    required this.labels,
    required this.onDotTap,
  });

  static const double _slotW = 20.0;
  static double _centerXOfDot(int index) => index * _slotW + _slotW / 2;
  static double _totalRowWidth(int count) => count * _slotW;

  @override
  Widget build(BuildContext context) {
    final isLastDot = activeIndex == dotCount - 1;
    final arrowTargetIndex = activeIndex + 1;
    final label = labels[activeIndex];
    final rowW = _totalRowWidth(dotCount);
    final arrowX = isLastDot ? 0.0 : _centerXOfDot(arrowTargetIndex);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            dotCount,
            (i) => GestureDetector(
              onTap: () => onDotTap(i),
              child: _Dot(isActive: i == activeIndex),
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 40,
          child: isLastDot
              ? null
              : LayoutBuilder(
                  builder: (ctx, constraints) {
                    final rowStartX = (constraints.maxWidth - rowW) / 2;
                    final arrowCenterAbsX = rowStartX + arrowX;

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          left: arrowCenterAbsX,
                          top: 0,
                          child: FractionalTranslation(
                            translation: const Offset(-0.5, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomPaint(
                                  size: const Size(14, 7),
                                  painter: const _TrianglePainter(
                                    color: Color(0xFF222222),
                                  ),
                                ),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: _TooltipBubble(
                                    key: ValueKey(activeIndex),
                                    label: label,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final bool isActive;
  const _Dot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.0,
      height: 16.0,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFBB8A0B) : const Color(0xFFCCCCCC),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  const _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TooltipBubble extends StatelessWidget {
  final String label;
  const _TooltipBubble({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF3E3E3E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
