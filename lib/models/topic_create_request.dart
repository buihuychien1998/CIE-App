class TopicCreateRequest {
  TopicCreateRequest({
    DataCreate? dataCreate,
    List<Student>? student,
  }) {
    _dataCreate = dataCreate;
    _student = student;
  }

  TopicCreateRequest.fromJson(dynamic json) {
    _dataCreate =
    json['data_create'] != null ? DataCreate.fromJson(json['data_create']) : null;
    if (json['student'] != null) {
      _student = [];
      json['student'].forEach((v) {
        _student?.add(Student.fromJson(v));
      });
    }
  }

  DataCreate? _dataCreate;
  List<Student>? _student;

  DataCreate? get dataCreate => _dataCreate;
  set dataCreate(DataCreate? value) => _dataCreate = value;

  List<Student>? get student => _student;
  set student(List<Student>? value) => _student = value;

  TopicCreateRequest copyWith({
    DataCreate? dataCreate,
    List<Student>? student,
  }) =>
      TopicCreateRequest(
        dataCreate: dataCreate ?? _dataCreate,
        student: student ?? _student,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_dataCreate != null) {
      map['data_create'] = _dataCreate?.toJson();
    }
    if (_student != null) {
      map['student'] = _student?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Student {
  Student({
    String? fullname,
    String? studentCode,
    String? positionName,
  }) {
    _fullname = fullname;
    _studentCode = studentCode;
    _positionName = positionName;
  }

  Student.fromJson(dynamic json) {
    _fullname = json['fullname'];
    _studentCode = json['student_code'];
    _positionName = json['position_name'];
  }

  String? _fullname;
  String? _studentCode;
  String? _positionName;

  String? get fullname => _fullname;
  set fullname(String? value) => _fullname = value;

  String? get studentCode => _studentCode;
  set studentCode(String? value) => _studentCode = value;

  String? get positionName => _positionName;
  set positionName(String? value) => _positionName = value;

  Student copyWith({
    String? fullname,
    String? studentCode,
    String? positionName,
  }) =>
      Student(
        fullname: fullname ?? _fullname,
        studentCode: studentCode ?? _studentCode,
        positionName: positionName ?? _positionName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullname'] = _fullname;
    map['student_code'] = _studentCode;
    map['position_name'] = _positionName;
    return map;
  }
}

class DataCreate {
  DataCreate({
    String? nameTopic,
    String? topicCode,
    String? version,
    String? type,
    String? unit,
    String? levelManager,
    String? burget,
    String? year,
  }) {
    _nameTopic = nameTopic;
    _topicCode = topicCode;
    _version = version;
    _type = type;
    _unit = unit;
    _levelManager = levelManager;
    _burget = burget;
    _year = year;
  }

  DataCreate.fromJson(dynamic json) {
    _nameTopic = json['name_topic'];
    _topicCode = json['topic_code'];
    _version = json['version'];
    _type = json['type'];
    _unit = json['unit'];
    _levelManager = json['level_manager'];
    _burget = json['burget'];
    _year = json['year'];
  }

  String? _nameTopic;
  String? _topicCode;
  String? _version;
  String? _type;
  String? _unit;
  String? _levelManager;
  String? _burget;
  String? _year;

  String? get nameTopic => _nameTopic;
  set nameTopic(String? value) => _nameTopic = value;

  String? get topicCode => _topicCode;
  set topicCode(String? value) => _topicCode = value;

  String? get version => _version;
  set version(String? value) => _version = value;

  String? get type => _type;
  set type(String? value) => _type = value;

  String? get unit => _unit;
  set unit(String? value) => _unit = value;

  String? get levelManager => _levelManager;
  set levelManager(String? value) => _levelManager = value;

  String? get burget => _burget;
  set burget(String? value) => _burget = value;

  String? get year => _year;
  set year(String? value) => _year = value;

  DataCreate copyWith({
    String? nameTopic,
    String? topicCode,
    String? version,
    String? type,
    String? unit,
    String? levelManager,
    String? burget,
    String? year,
  }) =>
      DataCreate(
        nameTopic: nameTopic ?? _nameTopic,
        topicCode: topicCode ?? _topicCode,
        version: version ?? _version,
        type: type ?? _type,
        unit: unit ?? _unit,
        levelManager: levelManager ?? _levelManager,
        burget: burget ?? _burget,
        year: year ?? _year,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name_topic'] = _nameTopic;
    map['topic_code'] = _topicCode;
    map['version'] = _version;
    map['type'] = _type;
    map['unit'] = _unit;
    map['level_manager'] = _levelManager;
    map['burget'] = _burget;
    map['year'] = _year;
    return map;
  }
}
