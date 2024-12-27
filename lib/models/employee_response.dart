/// employee : [{"id":1,"fullname":"test3","employ_code":"2222","position":"Giam doc","birthday":"18/10/1994","id_card_number":"123435","social_code":null,"address":"Ha Noi","education":"12/12","level":"Dai hoc","foreign_lang":"Tieng Anh B2","it_level":"-","join_clan":"18/10/2024","nation":null,"sex":null,"date_join":"17/12/2024","payday":"17/12/2024","level_salary":"1","multiplier":"1","extend_salary":"NO","link_file_id_card":null,"link_education":null,"link_contract":null}]
/// error : null

class EmployeeResponse {
  EmployeeResponse({
    List<Employee>? employee,
    dynamic error,
  }) {
    _employee = employee;
    _error = error;
  }

  EmployeeResponse.fromJson(dynamic json) {
    if (json['employee'] != null) {
      _employee = [];
      json['employee'].forEach((v) {
        _employee?.add(Employee.fromJson(v));
      });
    }
    _error = json['error'];
  }

  List<Employee>? _employee;
  dynamic _error;

  EmployeeResponse copyWith({
    List<Employee>? employee,
    dynamic error,
  }) =>
      EmployeeResponse(
        employee: employee ?? _employee,
        error: error ?? _error,
      );

  List<Employee>? get employee => _employee;

  dynamic get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_employee != null) {
      map['employee'] = _employee?.map((v) => v.toJson()).toList();
    }
    map['error'] = _error;
    return map;
  }
}

/// id : 1
/// fullname : "test3"
/// employ_code : "2222"
/// position : "Giam doc"
/// birthday : "18/10/1994"
/// id_card_number : "123435"
/// social_code : null
/// address : "Ha Noi"
/// education : "12/12"
/// level : "Dai hoc"
/// foreign_lang : "Tieng Anh B2"
/// it_level : "-"
/// join_clan : "18/10/2024"
/// nation : null
/// sex : null
/// date_join : "17/12/2024"
/// payday : "17/12/2024"
/// level_salary : "1"
/// multiplier : "1"
/// extend_salary : "NO"
/// link_file_id_card : null
/// link_education : null
/// link_contract : null

class Employee {
  Employee({
    num? id,
    String? fullname,
    String? employCode,
    String? position,
    String? birthday,
    String? idCardNumber,
    String? socialCode,
    String? address,
    String? education,
    String? level,
    String? foreignLang,
    String? itLevel,
    String? joinClan,
    String? nation,
    String? sex,
    String? dateJoin,
    String? payday,
    String? levelSalary,
    String? multiplier,
    String? extendSalary,
    String? linkFileIdCard,
    String? linkEducation,
    String? linkContract,
  }) {
    _id = id;
    _fullname = fullname;
    _employCode = employCode;
    _position = position;
    _birthday = birthday;
    _idCardNumber = idCardNumber;
    _socialCode = socialCode;
    _address = address;
    _education = education;
    _level = level;
    _foreignLang = foreignLang;
    _itLevel = itLevel;
    _joinClan = joinClan;
    _nation = nation;
    _sex = sex;
    _dateJoin = dateJoin;
    _payday = payday;
    _levelSalary = levelSalary;
    _multiplier = multiplier;
    _extendSalary = extendSalary;
    _linkFileIdCard = linkFileIdCard;
    _linkEducation = linkEducation;
    _linkContract = linkContract;
  }

  Employee.fromJson(dynamic json) {
    _id = json['id'];
    _fullname = json['fullname'];
    _employCode = json['employ_code'];
    _position = json['position'];
    _birthday = json['birthday'];
    _idCardNumber = json['id_card_number'];
    _socialCode = json['social_code'];
    _address = json['address'];
    _education = json['education'];
    _level = json['level'];
    _foreignLang = json['foreign_lang'];
    _itLevel = json['it_level'];
    _joinClan = json['join_clan'];
    _nation = json['nation'];
    _sex = json['sex'];
    _dateJoin = json['date_join'];
    _payday = json['payday'];
    _levelSalary = json['level_salary'];
    _multiplier = json['multiplier'];
    _extendSalary = json['extend_salary'];
    _linkFileIdCard = json['link_file_id_card'];
    _linkEducation = json['link_education'];
    _linkContract = json['link_contract'];
  }

  num? _id;
  String? _fullname;
  String? _employCode;
  String? _position;
  String? _birthday;
  String? _idCardNumber;
  dynamic _socialCode;
  String? _address;
  String? _education;
  String? _level;
  String? _foreignLang;
  String? _itLevel;
  String? _joinClan;
  String? _nation;
  String? _sex;
  String? _dateJoin;
  String? _payday;
  String? _levelSalary;
  String? _multiplier;
  String? _extendSalary;
  String? _linkFileIdCard;
  String? _linkEducation;
  String? _linkContract;

  Employee copyWith({
    num? id,
    String? fullname,
    String? employCode,
    String? position,
    String? birthday,
    String? idCardNumber,
    String? socialCode,
    String? address,
    String? education,
    String? level,
    String? foreignLang,
    String? itLevel,
    String? joinClan,
    String? nation,
    String? sex,
    String? dateJoin,
    String? payday,
    String? levelSalary,
    String? multiplier,
    String? extendSalary,
    String? linkFileIdCard,
    String? linkEducation,
    String? linkContract,
  }) =>
      Employee(
        id: id ?? _id,
        fullname: fullname ?? _fullname,
        employCode: employCode ?? _employCode,
        position: position ?? _position,
        birthday: birthday ?? _birthday,
        idCardNumber: idCardNumber ?? _idCardNumber,
        socialCode: socialCode ?? _socialCode,
        address: address ?? _address,
        education: education ?? _education,
        level: level ?? _level,
        foreignLang: foreignLang ?? _foreignLang,
        itLevel: itLevel ?? _itLevel,
        joinClan: joinClan ?? _joinClan,
        nation: nation ?? _nation,
        sex: sex ?? _sex,
        dateJoin: dateJoin ?? _dateJoin,
        payday: payday ?? _payday,
        levelSalary: levelSalary ?? _levelSalary,
        multiplier: multiplier ?? _multiplier,
        extendSalary: extendSalary ?? _extendSalary,
        linkFileIdCard: linkFileIdCard ?? _linkFileIdCard,
        linkEducation: linkEducation ?? _linkEducation,
        linkContract: linkContract ?? _linkContract,
      );

  num? get id => _id;

  String? get fullname => _fullname;

  String? get employCode => _employCode;

  String? get position => _position;

  String? get birthday => _birthday;

  String? get idCardNumber => _idCardNumber;

  String? get socialCode => _socialCode;

  String? get address => _address;

  String? get education => _education;

  String? get level => _level;

  String? get foreignLang => _foreignLang;

  String? get itLevel => _itLevel;

  String? get joinClan => _joinClan;

  String? get nation => _nation;

  String? get sex => _sex;

  String? get dateJoin => _dateJoin;

  String? get payday => _payday;

  String? get levelSalary => _levelSalary;

  String? get multiplier => _multiplier;

  String? get extendSalary => _extendSalary;

  String? get linkFileIdCard => _linkFileIdCard;

  String? get linkEducation => _linkEducation;

  String? get linkContract => _linkContract;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['fullname'] = _fullname;
    map['employ_code'] = _employCode;
    map['position'] = _position;
    map['birthday'] = _birthday;
    map['id_card_number'] = _idCardNumber;
    map['social_code'] = _socialCode;
    map['address'] = _address;
    map['education'] = _education;
    map['level'] = _level;
    map['foreign_lang'] = _foreignLang;
    map['it_level'] = _itLevel;
    map['join_clan'] = _joinClan;
    map['nation'] = _nation;
    map['sex'] = _sex;
    map['date_join'] = _dateJoin;
    map['payday'] = _payday;
    map['level_salary'] = _levelSalary;
    map['multiplier'] = _multiplier;
    map['extend_salary'] = _extendSalary;
    map['link_file_id_card'] = _linkFileIdCard;
    map['link_education'] = _linkEducation;
    map['link_contract'] = _linkContract;
    return map;
  }
}
