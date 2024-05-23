import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/infrastructure/infrastructure.dart';



final keyValueStorageServiceProvider  = Provider<StorageNotifier>((ref) {

  
  final keyValueStorageService = KeyValueStorageServiceImpl();


  return StorageNotifier(
    
    keyValueStorageService: keyValueStorageService
  );
});



class StorageNotifier extends StateNotifier {

  
  final KeyValueStorageService keyValueStorageService;

  StorageNotifier({
    
    required this.keyValueStorageService,
  }) : super(null) {
    
  }
  

  Future getStorageNombre( ) async {
    
   return await keyValueStorageService.getValue('nombre');

  }


}


