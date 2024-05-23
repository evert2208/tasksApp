import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/domain/entities/task.dart';
import 'package:tasks_app/domain/repositories/tasks_repository.dart';
import 'package:tasks_app/presentation/providers/tasks_repository_provider.dart';



final taskProvider = StateNotifierProvider.autoDispose.family<TaskNotifier, TaskState, String>(
  (ref, taskId ) {
    
    final tasksRepository = ref.watch(tasksRepositoryProvider);
  
    return TaskNotifier(
      tasksRepository: tasksRepository, 
      taskId: taskId
    );
});



class TaskNotifier extends StateNotifier<TaskState> {

  final TasksRepository tasksRepository;


  TaskNotifier({
    required this.tasksRepository,
    required String taskId,
  }): super(TaskState(id: taskId )) {
    loadtask();
  }




  Future<void> loadtask() async {

    try {

      final task = await tasksRepository.getTaskById(state.id);

      state = state.copyWith(
        isLoading: false,
        task: task
      );

    } catch (e) {
      // 404 product not found
      print(e);
    }

  }

}




class TaskState {

  final String id;
  final Task? task;
  final bool isLoading;
  final bool isSaving;

  TaskState({
    required this.id, 
    this.task, 
    this.isLoading = true, 
    this.isSaving = false,
  });

  TaskState copyWith({
    String? id,
    Task? task,
    bool? isLoading,
    bool? isSaving,
  }) => TaskState(
    id: id ?? this.id,
    task: task ?? this.task,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );
  
}

