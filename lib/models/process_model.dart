


class ProcessModel {
  int? pRECORDCOUNT;
  List<PRESULT>? pRESULT;

  ProcessModel({
    this.pRECORDCOUNT,
    this.pRESULT,
  });

  ProcessModel.fromJson(Map<String, dynamic> json) {
    pRECORDCOUNT = json['P_RECORD_COUNT'] as int?;
    pRESULT = (json['P_RESULT'] as List?)?.map((dynamic e) => PRESULT.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['P_RECORD_COUNT'] = pRECORDCOUNT;
    json['P_RESULT'] = pRESULT?.map((e) => e.toJson()).toList();
    return json;
  }
}

class PRESULT {
  int? pROCESSID;
  int? cOPIES;
  String? pROCESSNO;
  String? pPOWNER;
  String? zPROCESSNAME;
  String? zCENTERNAME;
  String? zSTATUSNAME;
  String? zSTATUSNOTE;

  PRESULT({
    this.pROCESSID,
    this.cOPIES,
    this.pROCESSNO,
    this.pPOWNER,
    this.zPROCESSNAME,
    this.zCENTERNAME,
    this.zSTATUSNAME,
    this.zSTATUSNOTE,
  });

  PRESULT.fromJson(Map<String, dynamic> json) {
    pROCESSID = json['PROCESS_ID'] as int?;
    cOPIES = json['COPIES'] as int?;
    pROCESSNO = json['PROCESS_NO'] as String?;
    pPOWNER = json['PPOWNER'] as String?;
    zPROCESSNAME = json['ZPROCESS_NAME'] as String?;
    zCENTERNAME = json['ZCENTER_NAME'] as String?;
    zSTATUSNAME = json['ZSTATUS_NAME'] as String?;
    zSTATUSNOTE = json['ZSTATUS_NOTE'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['PROCESS_ID'] = pROCESSID;
    json['COPIES'] = cOPIES;
    json['PROCESS_NO'] = pROCESSNO;
    json['PPOWNER'] = pPOWNER;
    json['ZPROCESS_NAME'] = zPROCESSNAME;
    json['ZCENTER_NAME'] = zCENTERNAME;
    json['ZSTATUS_NAME'] = zSTATUSNAME;
    json['ZSTATUS_NOTE'] = zSTATUSNOTE;
    return json;
  }
}