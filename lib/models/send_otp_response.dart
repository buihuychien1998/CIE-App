/// message : "OTP was sended to your mail"

class SendOtpResponse {
  SendOtpResponse({
      String? message,}){
    _message = message;
}

  SendOtpResponse.fromJson(dynamic json) {
    _message = json['message'];
  }
  String? _message;
SendOtpResponse copyWith({  String? message,
}) => SendOtpResponse(  message: message ?? _message,
);
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }

}