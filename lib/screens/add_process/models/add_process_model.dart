

import 'package:intl/intl.dart';
import 'package:sy/constants/constans.dart';
import 'package:sy/screens/settings/settings.dart';

class AddProcessModel {
  int id = 0;
  String? aLIAS;
  String? pUSERNAME;
  int? pZCITYID;
  int? pZTOWNID;
  dynamic pZSIDEID;
  int? pZPROCESSID;
  String? pFNAME;
  String? pLNAME;
  String? pFATHER;
  String? pMOTHER;
  int? pCOPIES;
  String? pSYRIAID;
  String? pBIRTHPLACE;
  String? pBIRTHDATE;
  String? pREGISTNO;
  String? pIDDOCNO;
  int? pCENTERID;
  String? pMOBILE;
  String? pTEL;
  dynamic pADDRGENERAL;
  String? pDMETHOD;
  dynamic pDADDRESS;
  int? pADDZCITYID;
  int? pADDZTOWNID;
  String? pADDAREA;
  String? pADDNAH;
  String? pADDVILLAGE;
  dynamic pADDPOSTOFFICE;
  dynamic pLEGALID;
  String? pPASSPORTTYPE;
  int? pMATECOUNT;
  String? pPASSPORTKIND;

  AddProcessModel({
    required this.id,
    this.aLIAS,
    this.pUSERNAME,
    this.pZCITYID,
    this.pZTOWNID,
    this.pZSIDEID,
    this.pZPROCESSID,
    this.pFNAME,
    this.pLNAME,
    this.pFATHER,
    this.pMOTHER,
    this.pCOPIES,
    this.pSYRIAID,
    this.pBIRTHPLACE,
    this.pBIRTHDATE,
    this.pREGISTNO,
    this.pIDDOCNO,
    this.pCENTERID,
    this.pMOBILE,
    this.pTEL,
    this.pADDRGENERAL,
    this.pDMETHOD,
    this.pDADDRESS,
    this.pADDZCITYID,
    this.pADDZTOWNID,
    this.pADDAREA,
    this.pADDNAH,
    this.pADDVILLAGE,
    this.pADDPOSTOFFICE,
    this.pLEGALID,
    this.pPASSPORTTYPE,
    this.pMATECOUNT,
    this.pPASSPORTKIND,
  });

  AddProcessModel.fromJson(Map<String, dynamic> json) {
    id = (json['id'] as int?)!;
    aLIAS = json['ALIAS'] as String?;
    pUSERNAME = json['P_USERNAME'] as String?;
    pZCITYID = json['P_ZCITYID'] as int?;
    pZTOWNID = json['P_ZTOWNID'] as int?;
    pZSIDEID = json['P_ZSIDEID'];
    pZPROCESSID = json['P_ZPROCESSID'] as int?;
    pFNAME = json['P_FNAME'] as String?;
    pLNAME = json['P_LNAME'] as String?;
    pFATHER = json['P_FATHER'] as String?;
    pMOTHER = json['P_MOTHER'] as String?;
    pCOPIES = json['P_COPIES'] as int?;
    pSYRIAID = json['P_SYRIAID'] as String?;
    pBIRTHPLACE = json['P_BIRTH_PLACE'] as String?;
    pBIRTHDATE = json['P_BIRTH_DATE'] as String?;
    pREGISTNO = json['P_REGISTNO'] as String?;
    pIDDOCNO = json['P_IDDOCNO'] as String?;
    pCENTERID = json['P_CENTERID'] as int?;
    pMOBILE = json['P_MOBILE'] as String?;
    pTEL = json['P_TEL'] as String?;
    pADDRGENERAL = json['P_ADDR_GENERAL'];
    pDMETHOD = json['P_D_METHOD'] as String?;
    pDADDRESS = json['P_D_ADDRESS'];
    pADDZCITYID = json['P_ADD_ZCITYID'] as int?;
    pADDZTOWNID = json['P_ADD_ZTOWNID'] as int?;
    pADDAREA = json['P_ADD_AREA'] as String?;
    pADDNAH = json['P_ADD_NAH'] as String?;
    pADDVILLAGE = json['P_ADD_VILLAGE'] as String?;
    pADDPOSTOFFICE = json['P_ADD_POST_OFFICE'];
    pLEGALID = json['P_LEGALID'];
    pPASSPORTTYPE = json['P_PASSPORT_TYPE'] as String?;
    pMATECOUNT = json['P_MATE_COUNT'] as int?;
    pPASSPORTKIND = json['P_PASSPORT_KIND'] as String?;
  }

  Map<String, dynamic> toJson() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(SettingsData.getUser!.pPROFILERESULT!.bIRTHDATE!));
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ALIAS'] = "OPHRUHvKso";
    json['P_USERNAME'] = "WebSite";
    json['P_ZCITYID'] = syriaLocations['$id']?['cityId'];
    json['P_ZTOWNID'] = syriaLocations['$id']?['townId'];
    json['P_ZSIDEID'] = null;
    json['P_ZPROCESSID'] = 18123129;
    json['P_FNAME'] = SettingsData.getUser!.pPROFILERESULT!.fIRSTNAME ?? '';
    json['P_LNAME'] = SettingsData.getUser!.pPROFILERESULT!.lASTNAME ?? '';
    json['P_FATHER'] = SettingsData.getUser!.pPROFILERESULT!.fATHERNAME ?? '';
    json['P_MOTHER'] = SettingsData.getUser!.pPROFILERESULT!.mOTHERNAME ?? '';
    json['P_COPIES'] = 1;
    json['P_SYRIAID'] = SettingsData.getUser!.pPROFILERESULT!.nID ?? '';
    json['P_BIRTH_PLACE'] = SettingsData.getUser!.pPROFILERESULT!.bIRTHPLACE ?? '';
    json['P_BIRTH_DATE'] =  formattedDate;
    json['P_REGISTNO'] = SettingsData.getUser!.pPROFILERESULT!.kAIDNO ?? '';
    json['P_IDDOCNO'] = "";
    json['P_CENTERID'] = syriaLocations['$id']?['centerId'];
    json['P_MOBILE'] = SettingsData.getUser!.pPROFILERESULT!.mOBILE ?? '';
    json['P_TEL'] = SettingsData.getUser!.pPROFILERESULT!.mOBILE ?? '';
    json['P_ADDR_GENERAL'] = null;
    json['P_D_METHOD'] = "1";
    json['P_D_ADDRESS'] = null;
    json['P_ADD_ZCITYID'] = syriaLocations['$id']?['cityId'];
    json['P_ADD_ZTOWNID'] = syriaLocations['$id']?['townId'];
    json['P_ADD_AREA'] = "";
    json['P_ADD_NAH'] = "";
    json['P_ADD_VILLAGE'] = "";
    json['P_ADD_POST_OFFICE'] = null;
    json['P_LEGALID'] = null;
    json['P_PASSPORT_TYPE'] = pPASSPORTTYPE; // 1 slow 2 fast
    json['P_MATE_COUNT'] = pMATECOUNT; //morafaka
    json['P_PASSPORT_KIND'] = "10";
    return json;
  }
}
