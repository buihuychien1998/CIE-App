/// topic : {"message":"SUCCESS ADD TOPIC","error":null}
/// error : null

class TopicCreateResponse {
  TopicCreateResponse({
      Topic? topic, 
      dynamic error,}){
    _topic = topic;
    _error = error;
}

  TopicCreateResponse.fromJson(dynamic json) {
    _topic = json['topic'] != null ? Topic.fromJson(json['topic']) : null;
    _error = json['error'];
  }
  Topic? _topic;
  dynamic _error;
TopicCreateResponse copyWith({  Topic? topic,
  dynamic error,
}) => TopicCreateResponse(  topic: topic ?? _topic,
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

/// message : "SUCCESS ADD TOPIC"
/// error : null

class Topic {
  Topic({
      String? message, 
      dynamic error,}){
    _message = message;
    _error = error;
}

  Topic.fromJson(dynamic json) {
    _message = json['message'];
    _error = json['error'];
  }
  String? _message;
  dynamic _error;
Topic copyWith({  String? message,
  dynamic error,
}) => Topic(  message: message ?? _message,
  error: error ?? _error,
);
  String? get message => _message;
  dynamic get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['error'] = _error;
    return map;
  }

}