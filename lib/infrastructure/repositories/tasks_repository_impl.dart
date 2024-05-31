import 'package:tasks_app/domain/datasources/tasks_datasource.dart';
import 'package:tasks_app/domain/entities/task.dart';
import 'package:tasks_app/domain/repositories/tasks_repository.dart';




class TasksRepositoryImpl extends TasksRepository {

  final TasksDatasource datasource;

  TasksRepositoryImpl(this.datasource);


  @override
  Future<Task> createUpdateTask(Map<String, dynamic> taskLike) {
    return datasource.createUpdateTask(taskLike);
  }

 

  @override
  Future<List<Task>> searchProductByTerm(String term) {
    return datasource.searchProductByTerm(term);
  }
  
  
  @override
  Future<Task> getTaskById(String id) {
    return datasource.getTaskById(id);
  }
  
  @override
  Future<List<Task>> getTasksByEstado(String estado) {
    return datasource.getTasksByEstado(estado);
  }
  
  @override
  Future<String> getAnswerGemini() {
    return datasource.getAnswerGemini();
  }
  
  @override
  Future<List<Tasks>> getTasks() {
    return datasource.getTasks();
  }
  
  
}