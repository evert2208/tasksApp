import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/domain/entities/task.dart';
import 'package:tasks_app/domain/repositories/tasks_repository.dart';
import 'tasks_repository_provider.dart';


final tasksProvider = StateNotifierProvider<TasksNotifier, TasksState>((ref) {

  final tasksRepository = ref.watch( tasksRepositoryProvider );
  return TasksNotifier(
    tasksRepository: tasksRepository
  );
  
});





class TasksNotifier extends StateNotifier<TasksState> {
  
  final TasksRepository tasksRepository;

  TasksNotifier({
    required this.tasksRepository
  }): super( TasksState() ) {
    
  }

  Future<bool> createOrUpdateTask( Map<String,dynamic> taskLike ) async {

    try {
      final task = await tasksRepository.createUpdateTask(taskLike);
      final isTaskList = state.tasks.any((element) => element.id == task.id );

      if ( !isTaskList ) {
        state = state.copyWith(
          tasks: [...state.tasks, task]
        );
        return true;
      }

      state = state.copyWith(
        tasks: state.tasks.map(
          (element) => ( element.id == task.id ) ? task : element,
        ).toList()
      );
      return true;

    } catch (e) {
      return false;
    }


  }

  Future loadTasks(String estado) async {

    
    if ( state.isLoading ) return;
    state = state.copyWith( isLoading: true );


    final tasks = await tasksRepository
      .getTasksByEstado(estado);
    
    
    if ( tasks.isEmpty ) {
      state = state.copyWith(
        isLoading: false,
       tasks: []
      );
      return;
    }

    state = state.copyWith(
      isLoading: false,
      tasks: [...tasks ]
    );
   

  }

   Future getTasks() async {
   
    
    if ( state.isLoading ) return;
    state = state.copyWith( isLoading: true );


    final tasks = await tasksRepository
      .getTasks();
    
    
    if ( tasks.isEmpty) {
      state = state.copyWith(
        isLoading: false,
       tasks: state.tasks,
       listTasks: []
      );
      return;
    }

    state = state.copyWith(
      isLoading: false,
      tasks: state.tasks,
      listTasks: [...tasks]
    );
   

  }

}





class TasksState {

  final bool isLoading;
  final List<Task> tasks;
  final List<Tasks> listTasks;

  TasksState({
    this.isLoading = false, 
    this.tasks = const[],
    this.listTasks = const[],
  });

  TasksState copyWith({
    bool? isLoading,
    List<Task>? tasks,
    List<Tasks>? listTasks
  }) => TasksState(
    isLoading: isLoading ?? this.isLoading,
    tasks: tasks ?? this.tasks,
    listTasks: listTasks ?? this.listTasks
  );

}
