class PersonModel {
  final String name;
  final int id;
  final String email;

  PersonModel({required this.name, required this.id, required this.email});

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
        name: json['name'], id: json['id'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'id': id, 'email': email};
  }
}
