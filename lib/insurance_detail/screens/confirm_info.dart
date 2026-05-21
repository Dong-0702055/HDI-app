import 'package:flutter/material.dart';
import '../models/comparison_data.dart';
import '../models/confirm_info_data.dart';
import 'order_review.dart';
import '../../../shared/widgets/hdi_app_bar.dart';
import '../../../shared/widgets/step_indicator.dart';
import '../../../shared/widgets/bottom_action_bar.dart';

class ConfirmInfoScreen extends StatefulWidget {
  final ComparisonPackage selectedPackage;

  const ConfirmInfoScreen({super.key, required this.selectedPackage});

  @override
  State<ConfirmInfoScreen> createState() => _ConfirmInfoScreenState();
}

class _ConfirmInfoScreenState extends State<ConfirmInfoScreen> {
  // null = chưa chọn | 'yes' = Có | 'no' = Không
  String? _selectedAnswer;
  bool _isTermsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      // ✅ Dùng HdiAppBar thay vì copy-paste
      appBar: HdiAppBar(title: 'Xác nhận thông tin'),
      body: Column(
        children: [
          // ✅ Dùng StepIndicator, chỉ truyền currentStep
          const StepIndicator(currentStep: 3),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Câu hỏi loại trừ ──
                  _buildQuestionCard(),
                  const SizedBox(height: 16),

                  // ── Cảnh báo (chỉ hiện khi chọn "Có") ──
                  if (_selectedAnswer == 'yes') ...[
                    _buildWarning(),
                    const SizedBox(height: 16),
                  ],

                  // ── Điều khoản cam kết ──
                  _buildTermsSection(),
                ],
              ),
            ),
          ),
          // ✅ Dùng BottomActionBar, null khi chưa chọn radio → tự disabled
          BottomActionBar(
            onPressed: _selectedAnswer == null
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderReviewScreen(
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

  // QUESTION CARD
  Widget _buildQuestionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question text
          Text(
            ConfirmInfoData.questionText,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          // Exclusion list
          ...ConfirmInfoData.exclusions.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                '${e.index}. ${e.content}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Radio buttons
          Row(
            children: [
              _buildRadio(label: 'Có', value: 'yes'),
              const SizedBox(width: 32),
              _buildRadio(label: 'Không', value: 'no'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadio({required String label, required String value}) {
    final isSelected = _selectedAnswer == value;
    return GestureDetector(
      onTap: () => setState(() {
        _selectedAnswer = value;
        // Reset expand khi chuyển đáp án
        if (value == 'yes') _isTermsExpanded = false;
      }),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
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
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFBB8A0B),
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  // WARNING (Chọn "Có")
  Widget _buildWarning() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3F3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 14, color: Colors.red, height: 1.5),
          children: [
            TextSpan(text: ConfirmInfoData.warningText),
            TextSpan(
              text: ConfirmInfoData.hotline,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TERMS SECTION
  Widget _buildTermsSection() {
    // Luôn hiện điều khoản a)
    // b) và c) chỉ hiện khi expand
    final clauses = _isTermsExpanded
        ? ConfirmInfoData.termsClauses
        : [ConfirmInfoData.termsClauses.first];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bằng việc nhấn nút "TIẾP TỤC" đồng nghĩa với việc Bên mua bảo hiểm xác nhận và cam kết:',
          style: TextStyle(fontSize: 14, color: Colors.black, height: 1.4),
        ),
        const SizedBox(height: 14),

        // Clauses
        ...clauses.map(
          (clause) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildClauseText(clause),
          ),
        ),

        // "Xem tất cả / Thu gọn" — luôn hiện
        GestureDetector(
          onTap: () => setState(() => _isTermsExpanded = !_isTermsExpanded),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isTermsExpanded ? 'Thu gọn' : 'Xem tất cả',
                style: const TextStyle(
                  color: Color(0xFFBB8A0B),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                _isTermsExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: const Color(0xFFBB8A0B),
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClauseText(TermsClause clause) {
    // Nếu không có link highlight → dùng Text bình thường
    if (clause.links.isEmpty) {
      return Text(
        '${clause.prefix} ${clause.content}',
        style: TextStyle(fontSize: 14, color: Colors.black, height: 1.4),
      );
    }

    // Có link → dùng RichText để highlight màu vàng
    final fullText = '${clause.prefix} ${clause.content}';
    final spans = <TextSpan>[];
    int cursor = 0;

    for (final link in clause.links) {
      final idx = fullText.indexOf(link.text, cursor);
      if (idx < 0) continue;

      if (idx > cursor) {
        spans.add(TextSpan(text: fullText.substring(cursor, idx)));
      }
      spans.add(
        TextSpan(
          text: link.text,
          style: const TextStyle(
            color: Color(0xFFBB8A0B),
            decoration: TextDecoration.none,
          ),
        ),
      );
      cursor = idx + link.text.length;
    }
    if (cursor < fullText.length) {
      spans.add(TextSpan(text: fullText.substring(cursor)));
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 14, color: Colors.black, height: 1.4),
        children: spans,
      ),
    );
  }

}
