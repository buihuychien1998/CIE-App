/// fullname : "test3"
/// employ_code : "33"
/// position : "Nhân viên"
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

class StaffCreateRequest {
  StaffCreateRequest({
    String? fullname,
    String? employCode,
    String? position,
    String? birthday,
    String? idCardNumber,
    dynamic socialCode,
    String? address,
    String? education,
    String? level,
    String? foreignLang,
    String? itLevel,
    String? joinClan,
    dynamic nation,
    dynamic sex,
    String? dateJoin,
    String? payday,
    String? levelSalary,
    String? multiplier,
    String? extendSalary,
    dynamic linkFileIdCard,
    dynamic linkEducation,
    dynamic linkContract,
  }) {
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

  // Private fields
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
  dynamic _nation;
  dynamic _sex;
  String? _dateJoin;
  String? _payday;
  String? _levelSalary;
  String? _multiplier;
  String? _extendSalary;
  dynamic _linkFileIdCard;
  dynamic _linkEducation;
  dynamic _linkContract;

  // Getters
  String? get fullname => _fullname;
  String? get employCode => _employCode;
  String? get position => _position;
  String? get birthday => _birthday;
  String? get idCardNumber => _idCardNumber;
  dynamic get socialCode => _socialCode;
  String? get address => _address;
  String? get education => _education;
  String? get level => _level;
  String? get foreignLang => _foreignLang;
  String? get itLevel => _itLevel;
  String? get joinClan => _joinClan;
  dynamic get nation => _nation;
  dynamic get sex => _sex;
  String? get dateJoin => _dateJoin;
  String? get payday => _payday;
  String? get levelSalary => _levelSalary;
  String? get multiplier => _multiplier;
  String? get extendSalary => _extendSalary;
  dynamic get linkFileIdCard => _linkFileIdCard;
  dynamic get linkEducation => _linkEducation;
  dynamic get linkContract => _linkContract;

  // Setters
  set fullname(String? value) => _fullname = value;
  set employCode(String? value) => _employCode = value;
  set position(String? value) => _position = value;
  set birthday(String? value) => _birthday = value;
  set idCardNumber(String? value) => _idCardNumber = value;
  set socialCode(dynamic value) => _socialCode = value;
  set address(String? value) => _address = value;
  set education(String? value) => _education = value;
  set level(String? value) => _level = value;
  set foreignLang(String? value) => _foreignLang = value;
  set itLevel(String? value) => _itLevel = value;
  set joinClan(String? value) => _joinClan = value;
  set nation(dynamic value) => _nation = value;
  set sex(dynamic value) => _sex = value;
  set dateJoin(String? value) => _dateJoin = value;
  set payday(String? value) => _payday = value;
  set levelSalary(String? value) => _levelSalary = value;
  set multiplier(String? value) => _multiplier = value;
  set extendSalary(String? value) => _extendSalary = value;
  set linkFileIdCard(dynamic value) => _linkFileIdCard = value;
  set linkEducation(dynamic value) => _linkEducation = value;
  set linkContract(dynamic value) => _linkContract = value;

// Other methods like fromJson, toJson, and copyWith remain unchanged
  StaffCreateRequest.fromJson(dynamic json) {
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

  StaffCreateRequest copyWith({  String? fullname,
    String? employCode,
    String? position,
    String? birthday,
    String? idCardNumber,
    dynamic socialCode,
    String? address,
    String? education,
    String? level,
    String? foreignLang,
    String? itLevel,
    String? joinClan,
    dynamic nation,
    dynamic sex,
    String? dateJoin,
    String? payday,
    String? levelSalary,
    String? multiplier,
    String? extendSalary,
    dynamic linkFileIdCard,
    dynamic linkEducation,
    dynamic linkContract,
  }) => StaffCreateRequest(  fullname: fullname ?? _fullname,
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
