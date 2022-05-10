class UserModel {
  String firstName;
  String lastName;
  String email;
  String contactNumber;
  String role;
  bool isActive;
  bool accountSetup;
  var addresses = [];
  var emergencyContacts = [];
  Map medicalCard = {};

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.role,
    required this.isActive,
    required this.accountSetup,
    required this.addresses,
    required this.emergencyContacts,
    required this.medicalCard
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    UserModel user = UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      contactNumber: json['contactNumber'],
      role: json['role'],
      isActive: json['isActive'],
      accountSetup: json['accountSetup'],
      addresses: json['addresses'],
      emergencyContacts: json['emergencyContacts'],
      medicalCard: json['medicalCard']
    );
    return user;
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'isActive': isActive,
      'accountSetup': accountSetup,
      'addresses': addresses,
      'emergencyContacts': emergencyContacts,
      'medicalCard': medicalCard,
    };
  }

  getName() {
    return '$firstName $lastName';
  }

  getFirstName() {
    return firstName;
  }

  hasPhoneNumber() {
    return contactNumber;
  }

  setPhoneNumber(contactNumber) {
    this.contactNumber = contactNumber;
  }

  isSetup() {
    return accountSetup;
  }

  addEmergencyContact(emergencyContact) {
    emergencyContacts.add(emergencyContact);
  }

  getAge() {
    var date = DateTime.parse(medicalCard['dateOfBirth']);
    var now = DateTime.now();
    var age = now.difference(date).inDays;
    return age ~/ 365;
  }
}
