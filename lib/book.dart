class Book {
  var id;
  String title;

  Book({
    required this.id,
    required this.title,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json['id'],
        title: json['midecal'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'midecal': title,
      };
}

class roshh {
  var id;
  var name;
  var instrac;
  var count;
  var discripshn;

  roshh({
    this.id,
    this.name,
    this.instrac,
    this.count,
    this.discripshn,
  });

  factory roshh.fromJson(Map<String, dynamic> json) {
    return roshh(
      id: json["id"],
      name: json["name"],
      instrac: json["instrac"],
      count: json["count"],
      discripshn: json["discripshn"],
    );
  }
}
