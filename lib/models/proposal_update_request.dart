class ProposalUpdateRequest {
  ProposalUpdateRequest({
    String? proposalCode,
    DataUpdate? dataUpdate,
    Version? version,}){
    _proposalCode = proposalCode;
    _dataUpdate = dataUpdate;
    _version = version;
  }

  ProposalUpdateRequest.fromJson(dynamic json) {
    _proposalCode = json['proposal_code'];
    _dataUpdate = json['data_update'] != null ? DataUpdate.fromJson(json['data_update']) : null;
    _version = json['version'] != null ? Version.fromJson(json['version']) : null;
  }

  String? _proposalCode;
  DataUpdate? _dataUpdate;
  Version? _version;

  ProposalUpdateRequest copyWith({  String? proposalCode,
    DataUpdate? dataUpdate,
    Version? version,}) => ProposalUpdateRequest(  proposalCode: proposalCode ?? _proposalCode,
    dataUpdate: dataUpdate ?? _dataUpdate,
    version: version ?? _version,);

  String? get proposalCode => _proposalCode;
  set proposalCode(String? value) => _proposalCode = value;

  DataUpdate? get dataUpdate => _dataUpdate;
  set dataUpdate(DataUpdate? value) => _dataUpdate = value;

  Version? get version => _version;
  set version(Version? value) => _version = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['proposal_code'] = _proposalCode;
    if (_dataUpdate != null) {
      map['data_update'] = _dataUpdate?.toJson();
    }
    if (_version != null) {
      map['version'] = _version?.toJson();
    }
    return map;
  }
}

class Version {
  Version({
    num? id,
    String? nameVersion,
    String? proposalCode,
    String? dateVersionCreated,
    String? signerVersion,
    String? fwd,}){
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

  Version copyWith({  num? id,
    String? nameVersion,
    String? proposalCode,
    String? dateVersionCreated,
    String? signerVersion,
    String? fwd,}) => Version(  id: id ?? _id,
    nameVersion: nameVersion ?? _nameVersion,
    proposalCode: proposalCode ?? _proposalCode,
    dateVersionCreated: dateVersionCreated ?? _dateVersionCreated,
    signerVersion: signerVersion ?? _signerVersion,
    fwd: fwd ?? _fwd,);

  num? get id => _id;
  set id(num? value) => _id = value;

  String? get nameVersion => _nameVersion;
  set nameVersion(String? value) => _nameVersion = value;

  String? get proposalCode => _proposalCode;
  set proposalCode(String? value) => _proposalCode = value;

  String? get dateVersionCreated => _dateVersionCreated;
  set dateVersionCreated(String? value) => _dateVersionCreated = value;

  String? get signerVersion => _signerVersion;
  set signerVersion(String? value) => _signerVersion = value;

  String? get fwd => _fwd;
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

class DataUpdate {
  DataUpdate({
    num? id,
    String? nameProposal,
    String? proposalCode,
    String? dateCreated,
    String? signer,
    bool? status,
    dynamic linkFileNotSign,
    dynamic linkFileReportProposal,}){
    _id = id;
    _nameProposal = nameProposal;
    _proposalCode = proposalCode;
    _dateCreated = dateCreated;
    _signer = signer;
    _status = status;
    _linkFileNotSign = linkFileNotSign;
    _linkFileReportProposal = linkFileReportProposal;
  }

  DataUpdate.fromJson(dynamic json) {
    _id = json['id'];
    _nameProposal = json['name_proposal'];
    _proposalCode = json['proposal_code'];
    _dateCreated = json['date_created'];
    _signer = json['signer'];
    _status = json['status'];
    _linkFileNotSign = json['link_file_not_sign'];
    _linkFileReportProposal = json['link_file_report_proposal'];
  }

  num? _id;
  String? _nameProposal;
  String? _proposalCode;
  String? _dateCreated;
  String? _signer;
  bool? _status;
  dynamic _linkFileNotSign;
  dynamic _linkFileReportProposal;

  DataUpdate copyWith({  num? id,
    String? nameProposal,
    String? proposalCode,
    String? dateCreated,
    String? signer,
    bool? status,
    dynamic linkFileNotSign,
    dynamic linkFileReportProposal,}) => DataUpdate(  id: id ?? _id,
    nameProposal: nameProposal ?? _nameProposal,
    proposalCode: proposalCode ?? _proposalCode,
    dateCreated: dateCreated ?? _dateCreated,
    signer: signer ?? _signer,
    status: status ?? _status,
    linkFileNotSign: linkFileNotSign ?? _linkFileNotSign,
    linkFileReportProposal: linkFileReportProposal ?? _linkFileReportProposal,);

  num? get id => _id;
  set id(num? value) => _id = value;

  String? get nameProposal => _nameProposal;
  set nameProposal(String? value) => _nameProposal = value;

  String? get proposalCode => _proposalCode;
  set proposalCode(String? value) => _proposalCode = value;

  String? get dateCreated => _dateCreated;
  set dateCreated(String? value) => _dateCreated = value;

  String? get signer => _signer;
  set signer(String? value) => _signer = value;

  bool? get status => _status;
  set status(bool? value) => _status = value;

  dynamic get linkFileNotSign => _linkFileNotSign;
  set linkFileNotSign(dynamic value) => _linkFileNotSign = value;

  dynamic get linkFileReportProposal => _linkFileReportProposal;
  set linkFileReportProposal(dynamic value) => _linkFileReportProposal = value;

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
    return map;
  }
}
