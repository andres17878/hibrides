class Record {
  String titol;
  String descripcio;

  Record({required this.titol, required this.descripcio});

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      titol: json['titol'],
      descripcio: json['descripcio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titol': titol,
      'descripcio': descripcio,
    };
  }

  @override
  String toString() {
    return 'Record{titol: $titol, descripcio: $descripcio}';
  }
}
