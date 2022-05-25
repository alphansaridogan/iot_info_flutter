import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'iot_info_model.dart';
import 'iot_info_service.dart';

class InfoRepository extends ChangeNotifier {
  List<IotInfoModelFeeds?>? infos= [];  //---

  final IotService service;
  InfoRepository(this.service);

  Future<void> indir() async {
    IotInfoModelFeeds Infolar= (await service.fetchInfo()) as IotInfoModelFeeds;


    infos!= Infolar;
    notifyListeners();
  }
}


final IotIndirmeProvider = Provider((ref){
  return InfoRepository(ref.watch(IotServiceProvider));
});
