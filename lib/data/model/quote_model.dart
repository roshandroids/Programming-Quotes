class QuoteModel {
  String sId;
  String en;
  String author;
  double rating;
  String id;

  QuoteModel({this.sId, this.en, this.author, this.id});

  QuoteModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    en = json['en'];
    author = json['author'];
    rating = json['rating'] == null ? 0.0 : json['rating'].toDouble();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['en'] = this.en;
    data['author'] = this.author;
    data['rating'] = this.rating.toDouble();
    data['id'] = this.id;
    return data;
  }
}
