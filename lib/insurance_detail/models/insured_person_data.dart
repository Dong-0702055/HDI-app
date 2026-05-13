class InsuredPersonInfo {
  final String name;
  final String birthDate;
  final String gender;
  final String idNumber;
  final String phone;
  final String email;
  final String startDate;
  final String endDate;

  const InsuredPersonInfo({
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.idNumber,
    required this.phone,
    required this.email,
    required this.startDate,
    required this.endDate,
  });

  String get insurancePeriod => '$startDate - $endDate';

  InsuredPersonInfo copyWith({
    String? name,
    String? birthDate,
    String? gender,
    String? idNumber,
    String? phone,
    String? email,
    String? startDate,
    String? endDate,
  }) {
    return InsuredPersonInfo(
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      idNumber: idNumber ?? this.idNumber,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

class InsuredPersonData {
  static const InsuredPersonInfo mockPerson = InsuredPersonInfo(
    name: 'Nguyễn Văn Anh Long',
    birthDate: '10/10/1990',
    gender: 'Nam',
    idNumber: '3242342352134',
    phone: '02834872234',
    email: 'longaaaa90@gmail.com',
    startDate: '13/5/2023',
    endDate: '13/5/2024',
  );
}
