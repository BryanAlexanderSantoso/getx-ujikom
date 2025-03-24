class AcaraResponse {
  int? _id;
  String? _image;
  String? _concertName;
  String? _venue;
  String? _date;
  String? _ticketPrice;
  String? _createdAt;
  String? _updatedAt;

  AcaraResponse(
      {int? id,
      String? image,
      String? concertName,
      String? venue,
      String? date,
      String? ticketPrice,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (image != null) {
      this._image = image;
    }
    if (concertName != null) {
      this._concertName = concertName;
    }
    if (venue != null) {
      this._venue = venue;
    }
    if (date != null) {
      this._date = date;
    }
    if (ticketPrice != null) {
      this._ticketPrice = ticketPrice;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get concertName => _concertName;
  set concertName(String? concertName) => _concertName = concertName;
  String? get venue => _venue;
  set venue(String? venue) => _venue = venue;
  String? get date => _date;
  set date(String? date) => _date = date;
  String? get ticketPrice => _ticketPrice;
  set ticketPrice(String? ticketPrice) => _ticketPrice = ticketPrice;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  AcaraResponse.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _image = json['image'];
    _concertName = json['concert_name'];
    _venue = json['venue'];
    _date = json['date'];
    _ticketPrice = json['ticket_price'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['image'] = this._image;
    data['concert_name'] = this._concertName;
    data['venue'] = this._venue;
    data['date'] = this._date;
    data['ticket_price'] = this._ticketPrice;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
