class OurJourneyModel {
  final String name;
  final String title;
  final String partyName;
  final String quote;
  final int fromYear;
  final int toYear;
  final String imagePath;
  final String? filePath;

  OurJourneyModel({
    required this.name,
    required this.title,
    required this.partyName,
    required this.quote,
    required this.fromYear,
    required this.toYear,
    required this.imagePath,
    this.filePath,
  });

  // Handy for partial updates when editing
  OurJourneyModel copyWith({
    String? name,
    String? title,
    String? partyName,
    String? quote,
    int? fromYear,
    int? toYear,
    String? imagePath,
    String? filePath, // pass explicit null to clear
    bool clearFilePath = false,
  }) {
    return OurJourneyModel(
      name: name ?? this.name,
      title: title ?? this.title,
      partyName: partyName ?? this.partyName,
      quote: quote ?? this.quote,
      fromYear: fromYear ?? this.fromYear,
      toYear: toYear ?? this.toYear,
      imagePath: imagePath ?? this.imagePath,
      filePath: clearFilePath ? null : (filePath ?? this.filePath),
    );
  }

  factory OurJourneyModel.fromJson(Map<String, dynamic> json) {
    return OurJourneyModel(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      partyName: json['partyName'] ?? '',
      quote: json['quote'] ?? '',
      fromYear: int.tryParse(json['fromYear'].toString()) ?? 0,
      toYear: int.tryParse(json['toYear'].toString()) ?? 0,
      imagePath: json['imagePath'] ?? '',
      filePath: json['filePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'partyName': partyName,
      'quote': quote,
      'fromYear': fromYear,
      'toYear': toYear,
      'imagePath': imagePath,
      'filePath': filePath,
    };
  }

  // Equality to safely find/compare items
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OurJourneyModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          title == other.title &&
          partyName == other.partyName &&
          quote == other.quote &&
          fromYear == other.fromYear &&
          toYear == other.toYear &&
          imagePath == other.imagePath &&
          filePath == other.filePath;

  @override
  int get hashCode => Object.hash(
        name, title, partyName, quote, fromYear, toYear, imagePath, filePath,
      );
}
