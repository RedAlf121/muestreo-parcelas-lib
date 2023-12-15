
class Comment {
  String _comment;
  bool _acceptordecline;
  DateTime _date;

  Comment(this._comment, this._acceptordecline, this._date);

  //Getters
  String get comment => _comment;

  bool get acceptordecline => _acceptordecline;

  DateTime get date => _date;

  //Setters
  set comment(String comment) {
    _comment = comment;
  }

  set acceptordecline(bool aod) {
    _acceptordecline = aod;
  }

  set datetime(DateTime daytime) {
    _date = daytime;
  }
}
