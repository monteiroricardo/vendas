class ClientModel {
  String name;
  String? number;
  String? addres;
  ClientModel({
    required this.name,
    this.number,
    this.addres,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
      'addres': addres,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      name: map['name'],
      number: map['number'],
      addres: map['addres'],
    );
  }
}
