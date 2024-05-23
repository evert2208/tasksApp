import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:tasks_app/config/constants/environment.dart';
import 'package:tasks_app/domain/entities/task.dart';
import 'package:tasks_app/infrastructure/infrastructure.dart';
import 'package:tasks_app/presentation/providers/tasks_provider.dart';



final taskFormProvider = StateNotifierProvider.autoDispose.family<TaskFormNotifier, TaskFormState, Task>(
  (ref, task) {

    final createUpdateCallback = ref.watch( tasksProvider.notifier ).createOrUpdateTask;

    return TaskFormNotifier(
      task: task,
      onSubmitCallback: createUpdateCallback,
    );
  }
);





class TaskFormNotifier extends StateNotifier<TaskFormState> {

  final Future<bool> Function( Map<String,dynamic> taskLike )? onSubmitCallback;

  TaskFormNotifier({
    this.onSubmitCallback,
    required Task task,
  }): super(
    TaskFormState(
      id: task.id,
      titulo: Title.dirty(task.titulo),
      descripcion: task.descripcion,
      estado: task.estado,
      fechaInicio: task.fechaInicio,
      fechaFin: task.fechaFin,
      comentarios: task.comentarios ?? '',
      evidencia: task.evidencia,
    )
  );

  Future<bool> onFormSubmit() async {
    _touchedEverything();
    if ( !state.isFormValid ) return false;

    // TODO: regresar
    if ( onSubmitCallback == null ) return false;

    final taskLike = {
      'id': (state.id == 'new') ? null : state.id,
    'titulo': state.titulo.value,
    'descripcion': state.descripcion,
    'direccion' : state.direccion,
    'estado': state.estado ? 'abierto' : 'cerrado',
    'fechaInicio': state.fechaInicio.toIso8601String(),
    'fechaFin': state.fechaFin?.toIso8601String(),
    'comentarios': state.comentarios,
    // 'evidencia': state.evidencia,
      'evidencia': state.evidencia.map(
        (image) => image.replaceAll('${ Environment.apiUrl }/files/task/', '')
      ).toList()
    };

    try {
      return await onSubmitCallback!( taskLike );
    } catch (e) {
      return false;
    }

  }


  void _touchedEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Title.dirty(state.titulo.value),
      ]),
    );
  }

  void updateProductImage( String path ) {
    state = state.copyWith(
      evidencia: [...state.evidencia, path ]
    );
  }


  // void onTitleChanged( String value ) {
  //   state = state.copyWith(
  //     title: Title.dirty(value),
  //     isFormValid: Formz.validate([
  //       Title.dirty(value),
  //       Slug.dirty(state.slug.value),
  //       Price.dirty(state.price.value),
  //       Stock.dirty(state.inStock.value),
  //     ])
  //   );
  // }

  // void onSlugChanged( String value ) {
  //   state = state.copyWith(
  //     slug: Slug.dirty(value),
  //     isFormValid: Formz.validate([
  //       Title.dirty(state.title.value),
  //       Slug.dirty(value),
  //       Price.dirty(state.price.value),
  //       Stock.dirty(state.inStock.value),
  //     ])
  //   );
  // }

  // void onPriceChanged( double value ) {
  //   state = state.copyWith(
  //     price: Price.dirty(value),
  //     isFormValid: Formz.validate([
  //       Title.dirty(state.title.value),
  //       Slug.dirty(state.slug.value),
  //       Price.dirty(value),
  //       Stock.dirty(state.inStock.value),
  //     ])
  //   );
  // }

  // void onStockChanged( int value ) {
  //   state = state.copyWith(
  //     inStock: Stock.dirty(value),
  //     isFormValid: Formz.validate([
  //       Title.dirty(state.title.value),
  //       Slug.dirty(state.slug.value),
  //       Price.dirty(state.price.value),
  //       Stock.dirty(value),
  //     ])
  //   );
  // }

  // void onSizeChanged( List<String> sizes ) {
  //   state = state.copyWith(
  //     sizes: sizes
  //   );
  // }

  // void onGenderChanged( String gender ) {
  //   state = state.copyWith(
  //     gender: gender
  //   );
  // }

  // void onDescriptionChanged( String description ) {
  //   state = state.copyWith(
  //     description: description
  //   );
  // }

  // void onTagsChanged( String tags ) {
  //   state = state.copyWith(
  //     tags: tags
  //   );
  // }

}





class TaskFormState {

  final bool isFormValid;
  final String? id;
  final Title titulo;
  final String descripcion;
  final String direccion;
  final String comentarios;
  final bool estado;
  final DateTime fechaInicio;
  final DateTime? fechaFin;
  final List<String> evidencia;

  TaskFormState({
    this.isFormValid = false, 
    this.id, 
    this.titulo = const Title.dirty(''),  
    this.descripcion = '',
    this.direccion = '', 
    this.comentarios = '',  
    this.estado=true,
    DateTime? fechaInicio,
    DateTime? fechaFin, 
     List<String>? evidencia,
  }): fechaInicio = fechaInicio ?? DateTime.now(),
      fechaFin = fechaFin ?? DateTime.now(),
      evidencia = evidencia ?? [];

  TaskFormState copyWith({
    bool? isFormValid,
    String? id,
    Title? titulo,
    String? descripcion,
    String? direccion,
    String? comentarios,
    bool? estado,
    DateTime? fechaInicio,
    DateTime? fechaFin,
    List<String>? evidencia,
  }) => TaskFormState(
    
    isFormValid: isFormValid ?? this.isFormValid,
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      direccion: direccion ?? this.direccion,
      comentarios: comentarios ?? this.comentarios,
      estado: estado ?? this.estado,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFin: fechaFin ?? this.fechaFin,
      evidencia: evidencia ?? this.evidencia,
  );


}