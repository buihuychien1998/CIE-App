/// topic : [{"year":"2024","count":1}]
/// proposal : [{"count":1},{"count":1},{"count":1},{"year":"2024","count":4}]
/// employee : [{"year":"2024","count":2}]

class ChartResponse {
  ChartResponse({
      List<Topic>? topic, 
      List<Proposal>? proposal, 
      List<Employee>? employee,}){
    _topic = topic;
    _proposal = proposal;
    _employee = employee;
}

  ChartResponse.fromJson(dynamic json) {
    if (json['topic'] != null) {
      _topic = [];
      json['topic'].forEach((v) {
        _topic?.add(Topic.fromJson(v));
      });
    }
    if (json['proposal'] != null) {
      _proposal = [];
      json['proposal'].forEach((v) {
        _proposal?.add(Proposal.fromJson(v));
      });
    }
    if (json['employee'] != null) {
      _employee = [];
      json['employee'].forEach((v) {
        _employee?.add(Employee.fromJson(v));
      });
    }
  }
  List<Topic>? _topic;
  List<Proposal>? _proposal;
  List<Employee>? _employee;
ChartResponse copyWith({  List<Topic>? topic,
  List<Proposal>? proposal,
  List<Employee>? employee,
}) => ChartResponse(  topic: topic ?? _topic,
  proposal: proposal ?? _proposal,
  employee: employee ?? _employee,
);
  List<Topic>? get topic => _topic;
  List<Proposal>? get proposal => _proposal;
  List<Employee>? get employee => _employee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_topic != null) {
      map['topic'] = _topic?.map((v) => v.toJson()).toList();
    }
    if (_proposal != null) {
      map['proposal'] = _proposal?.map((v) => v.toJson()).toList();
    }
    if (_employee != null) {
      map['employee'] = _employee?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// year : "2024"
/// count : 2

class Employee {
  Employee({
      String? year, 
      num? count,}){
    _year = year;
    _count = count;
}

  Employee.fromJson(dynamic json) {
    _year = json['year'];
    _count = json['count'];
  }
  String? _year;
  num? _count;
Employee copyWith({  String? year,
  num? count,
}) => Employee(  year: year ?? _year,
  count: count ?? _count,
);
  String? get year => _year;
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = _year;
    map['count'] = _count;
    return map;
  }

}

/// count : 1

class Proposal {
  Proposal({
      num? count,}){
    _count = count;
}

  Proposal.fromJson(dynamic json) {
    _count = json['count'];
  }
  num? _count;
Proposal copyWith({  num? count,
}) => Proposal(  count: count ?? _count,
);
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    return map;
  }

}

/// year : "2024"
/// count : 1

class Topic {
  Topic({
      String? year, 
      num? count,}){
    _year = year;
    _count = count;
}

  Topic.fromJson(dynamic json) {
    _year = json['year'];
    _count = json['count'];
  }
  String? _year;
  num? _count;
Topic copyWith({  String? year,
  num? count,
}) => Topic(  year: year ?? _year,
  count: count ?? _count,
);
  String? get year => _year;
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = _year;
    map['count'] = _count;
    return map;
  }

}