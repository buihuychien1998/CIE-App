/// user : {"id":1,"name":"admin","password":"$2a$10$HxpO7q7vV0at6b.fw85cUurPaAmVUu0KqPCptdasFoU9tBbWmUKrm","email":"admin@gmail.com"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwiaWF0IjoxNzM0MzQ2NTMyLCJleHAiOjE3MzQzNTAxMzJ9.TQDCysJJkCC0km0Em_NcwpM8pdSBnE5PXlNx4EdNmzs"

class SignInResponse {
  SignInResponse({
    User? user,
    String? token,
  }) {
    _user = user;
    _token = token;
  }

  SignInResponse.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
  }

  User? _user;
  String? _token;

  SignInResponse copyWith({
    User? user,
    String? token,
  }) =>
      SignInResponse(
        user: user ?? _user,
        token: token ?? _token,
      );

  User? get user => _user;

  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token'] = _token;
    return map;
  }
}

/// id : 1
/// name : "admin"
/// password : "$2a$10$HxpO7q7vV0at6b.fw85cUurPaAmVUu0KqPCptdasFoU9tBbWmUKrm"
/// email : "admin@gmail.com"

class User {
  User({
    num? id,
    String? name,
    String? password,
    String? email,
  }) {
    _id = id;
    _name = name;
    _password = password;
    _email = email;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _password = json['password'];
    _email = json['email'];
  }

  num? _id;
  String? _name;
  String? _password;
  String? _email;

  User copyWith({
    num? id,
    String? name,
    String? password,
    String? email,
  }) =>
      User(
        id: id ?? _id,
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
