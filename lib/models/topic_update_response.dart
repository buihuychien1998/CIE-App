/// topic : {"id":5,"name_topic":"ssfdsgs","topic_code":"21","version":"99","type":"Đề tài","unit":"12","level_manager":"Cấp học viện","burget":"21","year":"21","link_file_explanation":null,"link_file_outline":null,"link_file_report":null}
/// error : null

class TopicUpdateResponse {
  TopicUpdateResponse({
      Topic? topic, 
      dynamic error,}){
    _topic = topic;
    _error = error;
}

  TopicUpdateResponse.fromJson(dynamic json) {
    _topic = json['topic'] != null ? Topic.fromJson(json['topic']) : null;
    _error = json['error'];
  }
  Topic? _topic;
  dynamic _error;
TopicUpdateResponse copyWith({  Topic? topic,
  dynamic error,
}) => TopicUpdateResponse(  topic: topic ?? _topic,
  error: error ?? _error,
);
  Topic? get topic => _topic;
  dynamic get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_topic != null) {
      map['topic'] = _topic?.toJson();
    }
    map['error'] = _error;
    return map;
  }

}

/// id : 5
/// name_topic : "ssfdsgs"
/// topic_code : "21"
/// version : "99"
/// type : "Đề tài"
/// unit : "12"
/// level_manager : "Cấp học viện"
/// burget : "21"
/// year : "21"
/// link_file_explanation : null
/// link_file_outline : null
/// link_file_report : null

class Topic {
  Topic({
      num? id, 
      String? nameTopic, 
      String? topicCode, 
      String? version, 
      String? type, 
      String? unit, 
      String? levelManager, 
      String? burget, 
      String? year, 
      dynamic linkFileExplanation, 
      dynamic linkFileOutline, 
      dynamic linkFileReport,}){
    _id = id;
    _nameTopic = nameTopic;
    _topicCode = topicCode;
    _version = version;
    _type = type;
    _unit = unit;
    _levelManager = levelManager;
    _burget = burget;
    _year = year;
    _linkFileExplanation = linkFileExplanation;
    _linkFileOutline = linkFileOutline;
    _linkFileReport = linkFileReport;
}

  Topic.fromJson(dynamic json) {
    _id = json['id'];
    _nameTopic = json['name_topic'];
    _topicCode = json['topic_code'];
    _version = json['version'];
    _type = json['type'];
    _unit = json['unit'];
    _levelManager = json['level_manager'];
    _burget = json['burget'];
    _year = json['year'];
    _linkFileExplanation = json['link_file_explanation'];
    _linkFileOutline = json['link_file_outline'];
    _linkFileReport = json['link_file_report'];
  }
  num? _id;
  String? _nameTopic;
  String? _topicCode;
  String? _version;
  String? _type;
  String? _unit;
  String? _levelManager;
  String? _burget;
  String? _year;
  dynamic _linkFileExplanation;
  dynamic _linkFileOutline;
  dynamic _linkFileReport;
Topic copyWith({  num? id,
  String? nameTopic,
  String? topicCode,
  String? version,
  String? type,
  String? unit,
  String? levelManager,
  String? burget,
  String? year,
  dynamic linkFileExplanation,
  dynamic linkFileOutline,
  dynamic linkFileReport,
}) => Topic(  id: id ?? _id,
  nameTopic: nameTopic ?? _nameTopic,
  topicCode: topicCode ?? _topicCode,
  version: version ?? _version,
  type: type ?? _type,
  unit: unit ?? _unit,
  levelManager: levelManager ?? _levelManager,
  burget: burget ?? _burget,
  year: year ?? _year,
  linkFileExplanation: linkFileExplanation ?? _linkFileExplanation,
  linkFileOutline: linkFileOutline ?? _linkFileOutline,
  linkFileReport: linkFileReport ?? _linkFileReport,
);
  num? get id => _id;
  String? get nameTopic => _nameTopic;
  String? get topicCode => _topicCode;
  String? get version => _version;
  String? get type => _type;
  String? get unit => _unit;
  String? get levelManager => _levelManager;
  String? get burget => _burget;
  String? get year => _year;
  dynamic get linkFileExplanation => _linkFileExplanation;
  dynamic get linkFileOutline => _linkFileOutline;
  dynamic get linkFileReport => _linkFileReport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name_topic'] = _nameTopic;
    map['topic_code'] = _topicCode;
    map['version'] = _version;
    map['type'] = _type;
    map['unit'] = _unit;
    map['level_manager'] = _levelManager;
    map['burget'] = _burget;
    map['year'] = _year;
    map['link_file_explanation'] = _linkFileExplanation;
    map['link_file_outline'] = _linkFileOutline;
    map['link_file_report'] = _linkFileReport;
    return map;
  }

}