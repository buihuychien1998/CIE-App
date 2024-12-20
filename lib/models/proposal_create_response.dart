/// proposal : {"id":6,"name_proposal":"44444","proposal_code":"0007777778","date_created":"12-12-2024","signer":"tao","status":false,"link_file_not_sign":null,"link_file_report_proposal":null}
/// error : null

class ProposalCreateResponse {
  ProposalCreateResponse({
      Proposal? proposal, 
      dynamic error,}){
    _proposal = proposal;
    _error = error;
}

  ProposalCreateResponse.fromJson(dynamic json) {
    _proposal = json['proposal'] != null ? Proposal.fromJson(json['proposal']) : null;
    _error = json['error'];
  }
  Proposal? _proposal;
  dynamic _error;
ProposalCreateResponse copyWith({  Proposal? proposal,
  dynamic error,
}) => ProposalCreateResponse(  proposal: proposal ?? _proposal,
  error: error ?? _error,
);
  Proposal? get proposal => _proposal;
  dynamic get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_proposal != null) {
      map['proposal'] = _proposal?.toJson();
    }
    map['error'] = _error;
    return map;
  }

}

/// id : 6
/// name_proposal : "44444"
/// proposal_code : "0007777778"
/// date_created : "12-12-2024"
/// signer : "tao"
/// status : false
/// link_file_not_sign : null
/// link_file_report_proposal : null

class Proposal {
  Proposal({
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

  Proposal.fromJson(dynamic json) {
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
Proposal copyWith({  num? id,
  String? nameProposal,
  String? proposalCode,
  String? dateCreated,
  String? signer,
  bool? status,
  dynamic linkFileNotSign,
  dynamic linkFileReportProposal,
}) => Proposal(  id: id ?? _id,
  nameProposal: nameProposal ?? _nameProposal,
  proposalCode: proposalCode ?? _proposalCode,
  dateCreated: dateCreated ?? _dateCreated,
  signer: signer ?? _signer,
  status: status ?? _status,
  linkFileNotSign: linkFileNotSign ?? _linkFileNotSign,
  linkFileReportProposal: linkFileReportProposal ?? _linkFileReportProposal,
);
  num? get id => _id;
  String? get nameProposal => _nameProposal;
  String? get proposalCode => _proposalCode;
  String? get dateCreated => _dateCreated;
  String? get signer => _signer;
  bool? get status => _status;
  dynamic get linkFileNotSign => _linkFileNotSign;
  dynamic get linkFileReportProposal => _linkFileReportProposal;

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