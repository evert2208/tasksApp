import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/domain/repositories/tasks_repository.dart';
import 'package:tasks_app/infrastructure/datasources/tasks_datasource_impl.dart';
import 'package:tasks_app/infrastructure/repositories/tasks_repository_impl.dart';
import 'package:tasks_app/presentation/providers/auth_provider.dart';


final tasksRepositoryProvider = Provider<TasksRepository>((ref) {
  
  final accessToken = ref.watch( authProvider ).user?.token ?? '';
  final idUser = ref.watch( authProvider ).user?.user.id ?? '';
  
  final tasksRepository = TasksRepositoryImpl(
    TasksDatasourceImpl(accessToken: accessToken, idUser: idUser )
  );

  return tasksRepository;
});

