import 'package:get_it/get_it.dart';

import '../data_layer/data_layer.dart';



final getIt = GetIt.instance;

Future<void> setup() async{
  getIt.registerSingleton<DataLayer>(DataLayer());


}
