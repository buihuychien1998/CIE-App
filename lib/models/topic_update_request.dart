/// topic_code : "21"
/// data_update : {"name_topic":"ssfdsgs","topic_code":"21","version":"99","type":"Đề tài","unit":"12","level_manager":"Cấp học viện","burget":"21","year":"21","link_file_explanation":null,"link_file_outline":null,"link_file_report":null}

class TopicUpdateRequest {
  TopicUpdateRequest({
    String? topicCode,
    DataUpdate? dataUpdate,}){
    _topicCode = topicCode;
    _dataUpdate = dataUpdate;
  }

  TopicUpdateRequest.fromJson(dynamic json) {
    _topicCode = json['topic_code'];
    _dataUpdate = json['data_update'] != null ? DataUpdate.fromJson(json['data_update']) : null;
  }

  String? _topicCode;
  DataUpdate? _dataUpdate;

  // Setter methods
  set topicCode(String? topicCode) {
    _topicCode = topicCode;
  }

  set dataUpdate(DataUpdate? dataUpdate) {
    _dataUpdate = dataUpdate;
  }

  TopicUpdateRequest copyWith({
    String? topicCode,
    DataUpdate? dataUpdate,
  }) => TopicUpdateRequest(
    topicCode: topicCode ?? _topicCode,
    dataUpdate: dataUpdate ?? _dataUpdate,
  );

  String? get topicCode => _topicCode;
  DataUpdate? get dataUpdate => _dataUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['topic_code'] = _topicCode;
    if (_dataUpdate != null) {
      map['data_update'] = _dataUpdate?.toJson();
    }
    return map;
  }
}

class DataUpdate {
  DataUpdate({
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

  DataUpdate.fromJson(dynamic json) {
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

  // Setter methods
  set nameTopic(String? nameTopic) {
    _nameTopic = nameTopic;
  }

  set topicCode(String? topicCode) {
    _topicCode = topicCode;
  }

  set version(String? version) {
    _version = version;
  }

  set type(String? type) {
    _type = type;
  }

  set unit(String? unit) {
    _unit = unit;
  }

  set levelManager(String? levelManager) {
    _levelManager = levelManager;
  }

  set burget(String? burget) {
    _burget = burget;
  }

  set year(String? year) {
    _year = year;
  }

  set linkFileExplanation(dynamic linkFileExplanation) {
    _linkFileExplanation = linkFileExplanation;
  }

  set linkFileOutline(dynamic linkFileOutline) {
    _linkFileOutline = linkFileOutline;
  }

  set linkFileReport(dynamic linkFileReport) {
    _linkFileReport = linkFileReport;
  }

  DataUpdate copyWith({
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
  }) => DataUpdate(
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
