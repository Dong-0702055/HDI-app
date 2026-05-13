class PaymentMethod {
  final String label;
  final String svgPath;
  final List<String> logoPaths;

  const PaymentMethod({
    required this.label,
    this.svgPath = '',
    this.logoPaths = const [],
  });
}

class PaymentData {
  /// Thời gian đếm ngược ban đầu (giây) — 29:30
  static const int initialCountdownSeconds = 29 * 60 + 30;

  static const List<PaymentMethod> methods = [
    PaymentMethod(
      label: 'Thẻ ghi nợ/Tín dụng',
      svgPath: 'assets/icons/creditcard.png',
    ),
    PaymentMethod(
      label: 'Thẻ ATM/ Tài khoản ngân hàng',
      svgPath: 'assets/icons/money-change.svg',
    ),
    PaymentMethod(
      label: 'Ứng dụng di động',
      svgPath: 'assets/icons/money-change.svg',
    ),
  ];
}
