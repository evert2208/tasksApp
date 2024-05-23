import 'package:dio/dio.dart';
import 'package:tasks_app/config/constants/environment.dart';
import 'package:tasks_app/domain/datasources/tasks_datasource.dart';
import 'package:tasks_app/domain/entities/task.dart';
import '../errors/task_errors.dart';
import '../mappers/task_mapper.dart';


class TasksDatasourceImpl extends TasksDatasource {

  late final Dio dio;
  final String accessToken;
  final String idUser;

  TasksDatasourceImpl({
    required this.accessToken,
    required this.idUser
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    )
  );


  Future<String> _uploadFile( String path ) async {

    try {

      final fileName = path.split('/').last;
      final FormData data = FormData.fromMap({
        'file': MultipartFile.fromFileSync(path, filename: fileName)
      });

      final respose = await dio.post('/files/product', data: data );

      return respose.data['image'];

    } catch (e) {
      throw Exception();
    }


  }


  Future<List<String>> _uploadPhotos( List<String> photos ) async {
    
    final photosToUpload = photos.where((element) => element.contains('/') ).toList();
    final photosToIgnore = photos.where((element) => !element.contains('/') ).toList();

    //Todo: crear una serie de Futures de carga de imágenes
    final List<Future<String>> uploadJob = photosToUpload.map(_uploadFile).toList();

    final newImages = await Future.wait(uploadJob);
    
    return [...photosToIgnore, ...newImages ];
  }


  @override
  Future<Task> createUpdateTask(Map<String, dynamic> productLike) async {
    
    try {
      
      final String? productId = productLike['id'];
      final String method = (productId == null) ? 'POST' : 'PATCH';
      final String url = (productId == null) ? '/products' : '/products/$productId';

      productLike.remove('id');
      productLike['images'] = await _uploadPhotos( productLike['images'] );


      final response = await dio.request(
        url,
        data: productLike,
        options: Options(
          method: method
        )
      );

      final task = TaskMapper.jsonToEntity(response.data);
      return task;

    } catch (e) {
      throw Exception();
    }


  }

  @override
  Future<List<Task>> getTasksByEstado(String estado) async {
    
    try {
    
      final response = await dio.get<List>('/tasks/byStatusUser/$idUser/$estado');
      final List<Task> tasks = [];
      
     for (final task in response.data ?? [] ) {
     
      tasks.add(  TaskMapper.jsonToEntity(task)  );
    }
    
      return tasks;

    } on DioException catch (e) {
      if ( e.response!.statusCode == 404 ) throw TaskNotFound();
      throw Exception();

    }catch (e) {
      
      throw Exception();
    }

  }

 

  @override
  Future<List<Task>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
  
  @override
  Future<Task> getTaskById(String id) async{
    try {
      
      final response = await dio.get('/tasks/$id');
      final task = TaskMapper.jsonToEntity(response.data);
      return task;

    } on DioException catch (e) {
      if ( e.response!.statusCode == 404 ) throw TaskNotFound();
      throw Exception();

    }catch (e) {
      throw Exception();
    }
  }

}