import 'package:tasks_app/domain/entities/task.dart';

abstract class TasksDatasource {

  
  Future<List<Task>> getTasksByEstado(String estado);
   Future<Task> getTaskById(String id);
  Future<List<Task>> searchProductByTerm( String term );
  
  Future<Task> createUpdateTask( Map<String,dynamic> taskLike );


}

