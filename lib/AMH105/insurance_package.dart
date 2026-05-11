class InsuranceBenefit {
  final String title;
  final String value;

  InsuranceBenefit({required this.title, required this.value});
}

class InsurancePackage {
  final String title;
  final String subTitle;
  final String price;

  final List<InsuranceBenefit> benefits;

  InsurancePackage({
    required this.title,
    required this.subTitle,
    required this.price,
    required this.benefits,
  });
}
