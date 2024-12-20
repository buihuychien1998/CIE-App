/// proposal : [{"id":1,"name_proposal":"44444","proposal_code":"00099999","date_created":"12-12-2024","signer":"tao","status":true,"link_file_not_sign":null,"link_file_report_proposal":null,"version":[{"id":1,"name_version":"v1","proposal_code":"00099999","date_version_created":"13/12/2024","signer_version":"ssss4","fwd":"ff"},{"id":2,"name_version":"v2","proposal_code":"00099999","date_version_created":"31/12/2024","signer_version":"ssss4","fwd":"ff"}]}]
/// error : null

class ProposalResponse {
  ProposalResponse({
      List<Proposal>? proposal, 
      dynamic error,}){
    _proposal = proposal;
    _error = error;
}

  ProposalResponse.fromJson(dynamic json) {
    if (json['proposal'] != null) {
      _proposal = [];
      json['proposal'].forEach((v) {
        _proposal?.add(Proposal.fromJson(v));
      });
    }
    _error = json['error'];
  }
  List<Proposal>? _proposal;
  dynamic _error;
ProposalResponse copyWith({  List<Proposal>? proposal,
  dynamic error,
}) => ProposalResponse(  proposal: proposal ?? _proposal,
  error: error ?? _error,
);
  List<Proposal>? get proposal => _proposal;
  dynamic get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_proposal != null) {
      map['proposal'] = _proposal?.map((v) => v.toJson()).toList();
    }
    map['error'] = _error;
    return map;
  }

}

/// id : 1
/// name_proposal : "44444"
/// proposal_code : "00099999"
/// date_created : "12-12-2024"
/// signer : "tao"
/// status : true
/// link_file_not_sign : null
/// link_file_report_proposal : null
/// version : [{"id":1,"name_version":"v1","proposal_code":"00099999","date_version_created":"13/12/2024","signer_version":"ssss4","fwd":"ff"},{"id":2,"name_version":"v2","proposal_code":"00099999","date_version_created":"31/12/2024","signer_version":"ssss4","fwd":"ff"}]

class Proposal {
  Proposal({
    num? id,
    String? nameProposal,
    String? proposalCode,
    String? dateCreated,
    String? signer,
    bool? status,
    dynamic linkFileNotSign,
    dynamic linkFileReportProposal,
    List<Version>? version,
  }) {
    _id = id;
    _nameProposal = nameProposal;
    _proposalCode = proposalCode;
    _dateCreated = dateCreated;
    _signer = signer;
    _status = status;
    _linkFileNotSign = linkFileNotSign;
    _linkFileReportProposal = linkFileReportProposal;
    _version = version;
  }

  Proposal.fromJson(dynamic json) {
    _id = json['id'];
    _nameProposal = json['name_proposal'];
    _proposalCode = json['proposal_code'];
    _dateCreated = json['date_created'];
    _signer = json['signer'];
    _status = json['status'];
    _linkFileNotSign = json['link_file_not_sign'];
    _linkFileReportProposal = json['link_file_report_proposal'];
    if (json['version'] != null) {
      _version = [];
      json['version'].forEach((v) {
        _version?.add(Version.fromJson(v));
      });
    }
  }

  num? _id;
  String? _nameProposal;
  String? _proposalCode;
  String? _dateCreated;
  String? _signer;
  bool? _status;
  dynamic _linkFileNotSign;
  dynamic _linkFileReportProposal;
  List<Version>? _version;

  Proposal copyWith({
    num? id,
    String? nameProposal,
    String? proposalCode,
    String? dateCreated,
    String? signer,
    bool? status,
    dynamic linkFileNotSign,
    dynamic linkFileReportProposal,
    List<Version>? version,
  }) =>
      Proposal(
        id: id ?? _id,
        nameProposal: nameProposal ?? _nameProposal,
        proposalCode: proposalCode ?? _proposalCode,
        dateCreated: dateCreated ?? _dateCreated,
        signer: signer ?? _signer,
        status: status ?? _status,
        linkFileNotSign: linkFileNotSign ?? _linkFileNotSign,
        linkFileReportProposal: linkFileReportProposal ?? _linkFileReportProposal,
        version: version ?? _version,
      );

  // Getters
  num? get id => _id;
  String? get nameProposal => _nameProposal;
  String? get proposalCode => _proposalCode;
  String? get dateCreated => _dateCreated;
  String? get signer => _signer;
  bool? get status => _status;
  dynamic get linkFileNotSign => _linkFileNotSign;
  dynamic get linkFileReportProposal => _linkFileReportProposal;
  List<Version>? get version => _version;

  // Setters
  set id(num? value) => _id = value;
  set nameProposal(String? value) => _nameProposal = value;
  set proposalCode(String? value) => _proposalCode = value;
  set dateCreated(String? value) => _dateCreated = value;
  set signer(String? value) => _signer = value;
  set status(bool? value) => _status = value;
  set linkFileNotSign(dynamic value) => _linkFileNotSign = value;
  set linkFileReportProposal(dynamic value) => _linkFileReportProposal = value;
  set version(List<Version>? value) => _version = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name_proposal'] = _nameProposal;
    map['proposal_code'] = _proposalCode;
    map['date_created'] = _dateCreated;
    map['signer'] = _signer;
    map['status'] = _status;
    map['link_file_not_sign'] = _linkFileNotSign;
    map['link_file_report_proposal'] = _linkFileReportProposal;
    if (_version != null) {
      map['version'] = _version?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name_version : "v1"
/// proposal_code : "00099999"
/// date_version_created : "13/12/2024"
/// signer_version : "ssss4"
/// fwd : "ff"

class Version {
  Version({
    num? id,
    String? nameVersion,
    String? proposalCode,
    String? dateVersionCreated,
    String? signerVersion,
    String? fwd,
  }) {
    _id = id;
    _nameVersion = nameVersion;
    _proposalCode = proposalCode;
    _dateVersionCreated = dateVersionCreated;
    _signerVersion = signerVersion;
    _fwd = fwd;
  }

  Version.fromJson(dynamic json) {
    _id = json['id'];
    _nameVersion = json['name_version'];
    _proposalCode = json['proposal_code'];
    _dateVersionCreated = json['date_version_created'];
    _signerVersion = json['signer_version'];
    _fwd = json['fwd'];
  }

  num? _id;
  String? _nameVersion;
  String? _proposalCode;
  String? _dateVersionCreated;
  String? _signerVersion;
  String? _fwd;

  Version copyWith({
    num? id,
    String? nameVersion,
    String? proposalCode,
    String? dateVersionCreated,
    String? signerVersion,
    String? fwd,
  }) =>
      Version(
        id: id ?? _id,
        nameVersion: nameVersion ?? _nameVersion,
        proposalCode: proposalCode ?? _proposalCode,
        dateVersionCreated: dateVersionCreated ?? _dateVersionCreated,
        signerVersion: signerVersion ?? _signerVersion,
        fwd: fwd ?? _fwd,
      );

  // Getters
  num? get id => _id;
  String? get nameVersion => _nameVersion;
  String? get proposalCode => _proposalCode;
  String? get dateVersionCreated => _dateVersionCreated;
  String? get signerVersion => _signerVersion;
  String? get fwd => _fwd;

  // Setters
  set id(num? value) => _id = value;
  set nameVersion(String? value) => _nameVersion = value;
  set proposalCode(String? value) => _proposalCode = value;
  set dateVersionCreated(String? value) => _dateVersionCreated = value;
  set signerVersion(String? value) => _signerVersion = value;
  set fwd(String? value) => _fwd = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name_version'] = _nameVersion;
    map['proposal_code'] = _proposalCode;
    map['date_version_created'] = _dateVersionCreated;
    map['signer_version'] = _signerVersion;
    map['fwd'] = _fwd;
    return map;
  }
}