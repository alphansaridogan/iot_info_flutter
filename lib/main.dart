
import 'dart:async';
import 'package:get/get.dart';

import 'iot_informations/iot_info_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/iot_informations/iot_info_service.dart';
import 'iot_informations/iot_info_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final IotService _service= IotService();   //---
  List<IotInfoModelFeeds?>? infos;  //---

  var OrtamSicakik ="".obs;
  var OrtamNem = "".obs;
  var ToprakNem = "".obs;
  var Saat= "".obs;
  var OrtamNemDouble;
  var OrtamNemInt;
  var OrtamSicaklikDouble;
  var OrtamSicaklikInt;
  var ToprakNemInt;

  @override
  void initState() {
    getir();
    _service.fetchInfo();
    Timer.periodic(const Duration(seconds: 10), (timer) => getir());
    super.initState();
  }

  void getir(){
    _service.fetchInfo().then((value) {
      if(value!=null && value.feeds!=null) {
        print(value);
        setState ((){
          infos = value.feeds;
          //var t = infos?[0];
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    //TODO indexsiz kullanmak lazım



    if (infos != null ){
      OrtamSicakik.value = '${infos?[0]?.field1 ?? ""}';
      OrtamNem.value = '${infos?[0]?.field2 ?? ""}';
      ToprakNem.value = '${infos?[0]?.field3 ?? ""}';
      Saat.value = '${infos?[0]?.acc ?? ""}';
    }
    if (OrtamNem.value != "" && OrtamNem.value != null) {
      OrtamNemDouble = double.parse(OrtamNem.value);
      OrtamNemInt = OrtamNemDouble.toInt();
    }
    if (OrtamSicakik.value != "" && OrtamSicakik.value != null) {
      OrtamSicaklikDouble = double.parse(OrtamSicakik.value);
      OrtamSicaklikInt = OrtamSicaklikDouble.toInt();
    }
    if (ToprakNem.value != "" && ToprakNem.value != null) {
      ToprakNemInt = int.parse(ToprakNem.value);
    }


    return MaterialApp(
      title: 'Sıcaklık ve Nem Ölçer',
      home: Center(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Sıcaklık ve Nem Ölçer'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 200,
                    width: 150,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Ortam Sıcaklığı',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text('$OrtamSicaklikInt°C',
                              style: TextStyle(
                                fontSize: 30,
                              ),),
                          ],
                        )
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: 150,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Ortam Nemi',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text('%$OrtamNemInt',
                              style: TextStyle(
                                fontSize: 30,
                              ),),
                          ],
                        )
                    ),
                  ),

                ],
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 200,
                width: 150,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Toprak Nemi',
                          style:  TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text('%$ToprakNemInt',
                        style: TextStyle(
                          fontSize: 30,
                        ),),
                      ],
                    )
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(Saat.value,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

}


/*ListView.builder(
itemCount: infos!.length,
itemBuilder: (context, index) {
return ListTile(
title:  Text('Ortam Sıcaklığı',
style: TextStyle(
fontSize: 50, fontWeight: FontWeight.bold),
),
Text(' %${infos![0]!.field2}',
style: TextStyle(
fontSize: 50, fontWeight: FontWeight.bold),
),
Text(' %${infos![0]!.field3}',
style: TextStyle(
fontSize: 50, fontWeight: FontWeight.bold),
),
Text('${infos![0]!.acc}',
textAlign: TextAlign.center),
subtitle: Text(' %${infos![0]!.field1}',
style: TextStyle(
fontSize: 0, fontWeight: FontWeight.bold),
),
);
}
)

 */