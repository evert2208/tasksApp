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
    'estado': state.estado,
    'fechaInicio':  state.fechaInicio.toIso8601String(),
    'fechaFin': state.fechaFin,
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


  void onTitleChanged( String value ) {
    state = state.copyWith(
      titulo: Title.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(value),
        // Date.dirty(state.fechaInicio.value),
          // Date.dirty(state.fechaFin?.value)
      ])
    );
  }

  
  void onComentariosChanged( String comentarios) {
    state = state.copyWith(
      comentarios: comentarios
    );
  }

   void onDescripcionChanged( String descripcion) {
    state = state.copyWith(
      descripcion: descripcion
    );
  }
 void onDireccionChanged( String direccion) {
    state = state.copyWith(
      direccion: direccion
    );
  }
  void onEstadoChanged( bool estado) {
    state = state.copyWith(
      estado: estado
    );
  }
  // void onDateChanged( DateTime value ) {
  //   state = state.copyWith(
  //     fechaFin: Date.dirty(value),
  //      isFormValid: Formz.validate([
  //         Title.dirty(state.titulo.value),
  //       // Date.dirty(state.fechaInicio.value),
  //         Date.dirty(value),
  //       ]),
  //   );
  // }

   void onDateInicioChanged( DateTime value ) {
    state = state.copyWith(
      fechaInicio: value,
     
    );
  }
   void onDateFinalChanged( DateTime value ) {
    state = state.copyWith(
      fechaFin: value,
     
    );
  }

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