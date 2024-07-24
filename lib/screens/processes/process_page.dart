


import 'package:flutter/material.dart';
import 'package:sy/screens/add_process/add_process_screen.dart';
import 'package:sy/screens/auto/auto_screen.dart';
import 'package:sy/screens/login/login_page.dart';
import 'package:sy/screens/processes/widgets/row_info_widget.dart';
import 'package:sy/screens/settings/settings.dart';
import 'package:sy/screens/two_process/two_process_screen.dart';
import 'package:sy/utils/keys.dart';
import 'package:sy/utils/utils.dart';


class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key,this.isWithUpdate = false});

  final bool isWithUpdate;

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}


class _ProcessScreenState extends State<ProcessScreen> with AutomaticKeepAliveClientMixin {

  bool isLoadingRefresh = false;
  bool isLoadingDelete = false;


  @override
  void initState() {
    super.initState();
    getProcesses();
  }

  getProcesses() async {
    if(widget.isWithUpdate){
      await Utils.getMyProcesses();
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Overlay(
        key: Keys.overlayKey,
        initialEntries: [
          OverlayEntry(
            builder: (context) => Padding(
              padding: const EdgeInsets.only(bottom: 65.0),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                      SettingsData.getProcesses!.pRECORDCOUNT!,
                          (index) => Container(
                        width: width,
                        padding: const EdgeInsets.only(top: 16,right: 8,left: 8,bottom: 16),
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                spreadRadius: 0.001,
                                blurRadius: 1
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            rowInfo(name: 'رقم المعاملة', data: SettingsData.getProcesses!.pRESULT![index].pROCESSNO ?? ''),
                            getDivider(),
                            rowInfo(name: 'نوع المعاملة', data: SettingsData.getProcesses!.pRESULT![index].zPROCESSNAME ?? ''),
                            getDivider(),
                            rowInfo(name: 'صاحب العلاقة', data: SettingsData.getProcesses!.pRESULT![index].pPOWNER ?? ''),
                            getDivider(),
                            rowInfo(name: 'مركز التسليم', data: SettingsData.getProcesses!.pRESULT![index].zCENTERNAME ?? ''),
                            getDivider(),
                            rowInfo(name: 'حالة المعاملة', data: SettingsData.getProcesses!.pRESULT![index].zSTATUSNAME ?? ''),
                            getDivider(),
                            rowInfo(name: 'ملاحظات', data: SettingsData.getProcesses!.pRESULT![index].zSTATUSNOTE ?? ''),
                            getDivider(),
                            const SizedBox(height: 10,),
                            ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  isLoadingDelete = true;
                                });
                                await Utils.deleteProcess(SettingsData.getProcesses!.pRESULT![index].pROCESSID!);
                                await Utils.getMyProcesses();
                                setState(() {
                                  isLoadingDelete = false;
                                });
                              },
                              child: isLoadingDelete
                                  ? const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text('Loading...'),
                                ],
                              )
                                  : const Text('حذف'),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '0',
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddProcessScreen()));
            },
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10,),
          FloatingActionButton(
            heroTag: '1',
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const AutoPage()));
            },
            backgroundColor: Colors.grey,
            child: const Icon(
              Icons.punch_clock_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10,),
          FloatingActionButton(
            heroTag: '2',
            onPressed: () async {
              setState(() {
                isLoadingRefresh = true;
              });
              await Utils.getMyProcesses();
              setState(() {
                isLoadingRefresh = false;
              });
            },
            backgroundColor: Colors.blue,
            child: isLoadingRefresh
                ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
                : const Icon(
              Icons.refresh_outlined,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10,),
          FloatingActionButton(
            heroTag: '3',
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const TwoWorkPage()));
            },
            backgroundColor: Colors.cyan,
            child: const Icon(
              Icons.account_tree_outlined,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10,),
          FloatingActionButton(
            heroTag: '4',
            onPressed: () async {
              await SettingsData.logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
            },
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }


  Container getDivider(){
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: 1,
      color: Colors.black26,
    );
  }


  @override
  bool get wantKeepAlive => true;
}
