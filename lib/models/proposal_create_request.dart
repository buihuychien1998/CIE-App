class ProposalCreateRequest {
  ProposalCreateRequest({
    DataCreate? dataCreate,
    List<Version>? version,
  }) {
    _dataCreate = dataCreate;
    _version = version;
  }

  ProposalCreateRequest.fromJson(dynamic json) {
    _dataCreate = json['data_create'] != null
        ? DataCreate.fromJson(json['data_create'])
        : null;
    if (json['version'] != null) {
      _version = [];
      json['version'].forEach((v) {
        _version?.add(Version.fromJson(v));
      });
    }
  }

  DataCreate? _dataCreate;
  List<Version>? _version;

  ProposalCreateRequest copyWith({
    DataCreate? dataCreate,
    List<Version>? version,
  }) =>
      ProposalCreateRequest(
        dataCreate: dataCreate ?? _dataCreate,
        version: version ?? _version,
      );

  DataCreate? get dataCreate => _dataCreate;
  List<Version>? get version => _version;

  set dataCreate(DataCreate? value) => _dataCreate = value;
  set version(List<Version>? value) => _version = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_dataCreate != null) {
      map['data_create'] = _dataCreate?.toJson();
    }
    if (_version != null) {
      map['version'] = _version?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Version {
  Version({
    String? nameVersion,
    String? dateVersionCreated,
    String? signerVersion,
    String? fwd,
  }) {
    _nameVersion = nameVersion;
    _dateVersionCreated = dateVersionCreated;
    _signerVersion = signerVersion;
    _fwd = fwd;
  }

  Version.fromJson(dynamic json) {
    _nameVersion = json['name_version'];
    _dateVersionCreated = json['date_version_created'];
    _signerVersion = json['signer_version'];
    _fwd = json['fwd'];
  }

  String? _nameVersion;
  String? _dateVersionCreated;
  String? _signerVersion;
  String? _fwd;

  Version copyWith({
    String? nameVersion,
    String? dateVersionCreated,
    String? signerVersion,
    String? fwd,
  }) =>
      Version(
        nameVersion: nameVersion ?? _nameVersion,
        dateVersionCreated: dateVersionCreated ?? _dateVersionCreated,
        signerVersion: signerVersion ?? _signerVersion,
        fwd: fwd ?? _fwd,
      );

  String? get nameVersion => _nameVersion;
  String? get dateVersionCreated => _dateVersionCreated;
  String? get signerVersion => _signerVersion;
  String? get fwd => _fwd;

  set nameVersion(String? value) => _nameVersion = value;
  set dateVersionCreated(String? value) => _dateVersionCreated = value;
  set signerVersion(String? value) => _signerVersion = value;
  set fwd(String? value) => _fwd = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name_version'] = _nameVersion;
    map['date_version_created'] = _dateVersionCreated;
    map['signer_version'] = _signerVersion;
    map['fwd'] = _fwd;
    return map;
  }
}

class DataCreate {
  DataCreate({
    String? nameProposal,
    String? proposalCode,
    String? dateCreated,
    String? signer,
    bool? status,
  }) {
    _nameProposal = nameProposal;
    _proposalCode = proposalCode;
    _dateCreated = dateCreated;
    _signer = signer;
    _status = status;
  }

  DataCreate.fromJson(dynamic json) {
    _nameProposal = json['name_proposal'];
    _proposalCode = json['proposal_code'];
    _dateCreated = json['date_created'];
    _signer = json['signer'];
    _status = json['status'];
  }

  String? _nameProposal;
  String? _proposalCode;
  String? _dateCreated;
  String? _signer;
  bool? _status;

  DataCreate copyWith({
    String? nameProposal,
    String? proposalCode,
    String? dateCreated,
    String? signer,
    bool? status,
  }) =>
      DataCreate(
        nameProposal: nameProposal ?? _nameProposal,
        proposalCode: proposalCode ?? _proposalCode,
        dateCreated: dateCreated ?? _dateCreated,
        signer: signer ?? _signer,
        status: status ?? _status,
      );

  String? get nameProposal => _nameProposal;
  String? get proposalCode => _proposalCode;
  String? get dateCreated => _dateCreated;
  String? get signer => _signer;
  bool? get status => _status;

  set nameProposal(String? value) => _nameProposal = value;
  set proposalCode(String? value) => _proposalCode = value;
  set dateCreated(String? value) => _dateCreated = value;
  set signer(String? value) => _signer = value;
  set status(bool? value) => _status = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name_proposal'] = _nameProposal;
    map['proposal_code'] = _proposalCode;
    map['date_created'] = _dateCreated;
    map['signer'] = _signer;
    map['status'] = _status;
    return map;
  }
}
