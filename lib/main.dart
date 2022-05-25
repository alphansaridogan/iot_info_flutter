
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
  List<IotInfoModelFeeds?>? infos= [];  //---


  @override
  void initState() {
    super.initState();
    _service.fetchInfo().then((value) {
     if(value!=null && value.feeds!=null) {
       setState ((){
         infos = value.feeds;
       });
     }
    });
  }


  @override
  Widget build(BuildContext context) {
    //TODO indexsiz kullanmak lazım
    String OrtamSicakik = '%${infos![0]!.field1}';
    String OrtamNem = '%${infos![0]!.field2}';
    String ToprakNem = '%${infos![0]!.field3}';
    String Saat= '${infos![0]!.acc}';
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
                            Text(OrtamSicakik),
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
                            Text(OrtamNem),
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
                        Text(ToprakNem),
                      ],
                    )
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(Saat,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      //TODO refresh yapması lazım
                    });
                  }, child: Text('asd'),
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