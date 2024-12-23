/// topic : [{"id":1,"name_topic":"8888","topic_code":"9999","version":"1","type":"1","unit":"dao tao","level_manager":"cap hoc vien","burget":"30000000","year":"2024","link_file_explanation":null,"link_file_outline":null,"link_file_report":null,"student":[{"id":1,"fullname":" BUa","student_code":"TDB009","position_name":"Lead","topic_code":"9999"},{"id":2,"fullname":" vvvv","student_code":"TDB021","position_name":"memeber","topic_code":"9999"}]}]
/// error : null

class TopicResponse {
  TopicResponse({
      List<Topic>? topic, 
      dynamic error,}){
    _topic = topic;
    _error = error;
}

  TopicResponse.fromJson(dynamic json) {
    if (json['topic'] != null) {
      _topic = [];
      json['topic'].forEach((v) {
        _topic?.add(Topic.fromJson(v));
      });
    }
    _error = json['error'];
  }
  List<Topic>? _topic;
  dynamic _error;
TopicResponse copyWith({  List<Topic>? topic,
  dynamic error,
}) => TopicResponse(  topic: topic ?? _topic,
  error: error ?? _error,
);
  List<Topic>? get topic => _topic;
  dynamic get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_topic != null) {
      map['topic'] = _topic?.map((v) => v.toJson()).toList();
    }
    map['error'] = _error;
    return map;
  }

}

/// id : 1
/// name_topic : "8888"
/// topic_code : "9999"
/// version : "1"
/// type : "1"
/// unit : "dao tao"
/// level_manager : "cap hoc vien"
/// burget : "30000000"
/// year : "2024"
/// link_file_explanation : null
/// link_file_outline : null
/// link_file_report : null
/// student : [{"id":1,"fullname":" BUa","student_code":"TDB009","position_name":"Lead","topic_code":"9999"},{"id":2,"fullname":" vvvv","student_code":"TDB021","position_name":"memeber","topic_code":"9999"}]

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
    dynamic linkFileReport,
    List<Student>? student,
  }) {
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
    _student = student;
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
    if (json['student'] != null) {
      _student = [];
      json['student'].forEach((v) {
        _student?.add(Student.fromJson(v));
      });
    }
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
  List<Student>? _student;

  // Setters
  set id(num? value) {
    _id = value;
  }

  set nameTopic(String? value) {
    _nameTopic = value;
  }

  set topicCode(String? value) {
    _topicCode = value;
  }

  set version(String? value) {
    _version = value;
  }

  set type(String? value) {
    _type = value;
  }

  set unit(String? value) {
    _unit = value;
  }

  set levelManager(String? value) {
    _levelManager = value;
  }

  set burget(String? value) {
    _burget = value;
  }

  set year(String? value) {
    _year = value;
  }

  set linkFileExplanation(dynamic value) {
    _linkFileExplanation = value;
  }

  set linkFileOutline(dynamic value) {
    _linkFileOutline = value;
  }

  set linkFileReport(dynamic value) {
    _linkFileReport = value;
  }

  set student(List<Student>? value) {
    _student = value;
  }

  Topic copyWith({
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
    dynamic linkFileReport,
    List<Student>? student,
  }) {
    return Topic(
      id: id ?? _id,
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
      student: student ?? _student,
    );
  }

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
  List<Student>? get student => _student;

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
    if (_student != null) {
      map['student'] = _student?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// fullname : " BUa"
/// student_code : "TDB009"
/// position_name : "Lead"
/// topic_code : "9999"

class Student {
  Student({
    num? id,
    String? fullname,
    String? studentCode,
    String? positionName,
    String? topicCode,
  }) {
    _id = id;
    _fullname = fullname;
    _studentCode = studentCode;
    _positionName = positionName;
    _topicCode = topicCode;
  }

  Student.fromJson(dynamic json) {
    _id = json['id'];
    _fullname = json['fullname'];
    _studentCode = json['student_code'];
    _positionName = json['position_name'];
    _topicCode = json['topic_code'];
  }

  num? _id;
  String? _fullname;
  String? _studentCode;
  String? _positionName;
  String? _topicCode;

  // Setters
  set id(num? value) {
    _id = value;
  }

  set fullname(String? value) {
    _fullname = value;
  }

  set studentCode(String? value) {
    _studentCode = value;
  }

  set positionName(String? value) {
    _positionName = value;
  }

  set topicCode(String? value) {
    _topicCode = value;
  }

  Student copyWith({
    num? id,
    String? fullname,
    String? studentCode,
    String? positionName,
    String? topicCode,
  }) {
    return Student(
      id: id ?? _id,
      fullname: fullname ?? _fullname,
      studentCode: studentCode ?? _studentCode,
      positionName: positionName ?? _positionName,
      topicCode: topicCode ?? _topicCode,
    );
  }

  num? get id => _id;
  String? get fullname => _fullname;
  String? get studentCode => _studentCode;
  String? get positionName => _positionName;
  String? get topicCode => _topicCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['fullname'] = _fullname;
    map['student_code'] = _studentCode;
    map['position_name'] = _positionName;
    map['topic_code'] = _topicCode;
    return map;
  }
}
