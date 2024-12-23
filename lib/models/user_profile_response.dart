/// profile : {"id":1,"name":"admin","password":"$2a$10$HxpO7q7vV0at6b.fw85cUurPaAmVUu0KqPCptdasFoU9tBbWmUKrm","email":"admin@gmail.com"}
/// error : null

class UserProfileResponse {
  UserProfileResponse({
      Profile? profile, 
      dynamic error,}){
    _profile = profile;
    _error = error;
}

  UserProfileResponse.fromJson(dynamic json) {
    _profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    _error = json['error'];
  }
  Profile? _profile;
  dynamic _error;
UserProfileResponse copyWith({  Profile? profile,
  dynamic error,
}) => UserProfileResponse(  profile: profile ?? _profile,
  error: error ?? _error,
);
  Profile? get profile => _profile;
  dynamic get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_profile != null) {
      map['profile'] = _profile?.toJson();
    }
    map['error'] = _error;
    return map;
  }

}

/// id : 1
/// name : "admin"
/// password : "$2a$10$HxpO7q7vV0at6b.fw85cUurPaAmVUu0KqPCptdasFoU9tBbWmUKrm"
/// email : "admin@gmail.com"

class Profile {
  Profile({
      num? id, 
      String? name, 
      String? password, 
      String? email,}){
    _id = id;
    _name = name;
    _password = password;
    _email = email;
}

  Profile.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _password = json['password'];
    _email = json['email'];
  }
  num? _id;
  String? _name;
  String? _password;
  String? _email;
Profile copyWith({  num? id,
  String? name,
  String? password,
  String? email,
}) => Profile(  id: id ?? _id,
  name: name ?? _name,
  password: password ?? _password,
  email: email ?? _email,
);
  num? get id => _id;
  String? get name => _name;
  String? get password => _password;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['password'] = _password;
    map['email'] = _email;
    return map;
  }

}