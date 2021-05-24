class SpokenLanguages {
  String englishName;
  String iso6391;
  String name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json)
      : englishName = json['english_name'],
        iso6391 = json['iso_639_1'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    return {
      'english_name': this.englishName,
      'iso_639_1': this.iso6391,
      'name': this.name,
    };
  }
}
