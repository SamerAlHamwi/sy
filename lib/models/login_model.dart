


class LoginModel {
  PPROFILERESULT? pPROFILERESULT;

  LoginModel({
    this.pPROFILERESULT,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    pPROFILERESULT = (json['P_PROFILE_RESULT'] as Map<String,dynamic>?) != null ? PPROFILERESULT.fromJson(json['P_PROFILE_RESULT'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['P_PROFILE_RESULT'] = pPROFILERESULT?.toJson();
    return json;
  }
}

class PPROFILERESULT {
  String? fIRSTNAME;
  String? lASTNAME;
  String? mOBILE;
  String? iSCOMPLETE;
  String? fULLNAME;
  int? nATIONID;
  String? nID;
  String? bIRTHDATE;
  String? fATHERNAME;
  String? mOTHERNAME;
  dynamic aMANH;
  int? zCENTERID;
  int? zTOWNID;
  int? zPOSTOFFICEID;
  int? gOVID;
  String? kAIDNO;
  String? kAID;
  String? gENDER;
  String? aDDRESS;
  String? tEMPADDRESS;
  String? bIRTHPLACE;
  String? pHONE;
  int? zCITYID;
  String? cARDNO;
  dynamic lEGALID;
  dynamic lEGALNAME;

  PPROFILERESULT({
    this.fIRSTNAME,
    this.lASTNAME,
    this.mOBILE,
    this.iSCOMPLETE,
    this.fULLNAME,
    this.nATIONID,
    this.nID,
    this.bIRTHDATE,
    this.fATHERNAME,
    this.mOTHERNAME,
    this.aMANH,
    this.zCENTERID,
    this.zTOWNID,
    this.zPOSTOFFICEID,
    this.gOVID,
    this.kAIDNO,
    this.kAID,
    this.gENDER,
    this.aDDRESS,
    this.tEMPADDRESS,
    this.bIRTHPLACE,
    this.pHONE,
    this.zCITYID,
    this.cARDNO,
    this.lEGALID,
    this.lEGALNAME,
  });

  PPROFILERESULT.fromJson(Map<String, dynamic> json) {
    fIRSTNAME = json['FIRST_NAME'] as String?;
    lASTNAME = json['LAST_NAME'] as String?;
    mOBILE = json['MOBILE'] as String?;
    iSCOMPLETE = json['IS_COMPLETE'] as String?;
    fULLNAME = json['FULLNAME'] as String?;
    nATIONID = json['NATIONID'] as int?;
    nID = json['NID'] as String?;
    bIRTHDATE = json['BIRTH_DATE'] as String?;
    fATHERNAME = json['FATHER_NAME'] as String?;
    mOTHERNAME = json['MOTHER_NAME'] as String?;
    aMANH = json['AMANH'];
    zCENTERID = json['ZCENTERID'] as int?;
    zTOWNID = json['ZTOWNID'] as int?;
    zPOSTOFFICEID = json['ZPOST_OFFICEID'] as int?;
    gOVID = json['GOVID'] as int?;
    kAIDNO = json['KAID_NO'] as String?;
    kAID = json['KAID'] as String?;
    gENDER = json['GENDER'] as String?;
    aDDRESS = json['ADDRESS'] as String?;
    tEMPADDRESS = json['TEMP_ADDRESS'] as String?;
    bIRTHPLACE = json['BIRTH_PLACE'] as String?;
    pHONE = json['PHONE'] as String?;
    zCITYID = json['ZCITYID'] as int?;
    cARDNO = json['CARD_NO'] as String?;
    lEGALID = json['LEGALID'];
    lEGALNAME = json['LEGAL_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['FIRST_NAME'] = fIRSTNAME;
    json['LAST_NAME'] = lASTNAME;
    json['MOBILE'] = mOBILE;
    json['IS_COMPLETE'] = iSCOMPLETE;
    json['FULLNAME'] = fULLNAME;
    json['NATIONID'] = nATIONID;
    json['NID'] = nID;
    json['BIRTH_DATE'] = bIRTHDATE;
    json['FATHER_NAME'] = fATHERNAME;
    json['MOTHER_NAME'] = mOTHERNAME;
    json['AMANH'] = aMANH;
    json['ZCENTERID'] = zCENTERID;
    json['ZTOWNID'] = zTOWNID;
    json['ZPOST_OFFICEID'] = zPOSTOFFICEID;
    json['GOVID'] = gOVID;
    json['KAID_NO'] = kAIDNO;
    json['KAID'] = kAID;
    json['GENDER'] = gENDER;
    json['ADDRESS'] = aDDRESS;
    json['TEMP_ADDRESS'] = tEMPADDRESS;
    json['BIRTH_PLACE'] = bIRTHPLACE;
    json['PHONE'] = pHONE;
    json['ZCITYID'] = zCITYID;
    json['CARD_NO'] = cARDNO;
    json['LEGALID'] = lEGALID;
    json['LEGAL_NAME'] = lEGALNAME;
    return json;
  }
}