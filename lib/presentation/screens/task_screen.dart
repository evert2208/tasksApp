import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/domain/entities/task.dart';
import 'package:tasks_app/infrastructure/infrastructure.dart';
import 'package:tasks_app/presentation/providers/forms/task_form_provider.dart';
import 'package:tasks_app/presentation/providers/task_provider.dart';
import 'package:tasks_app/presentation/shared/widgets/full_screen_loader.dart';
import 'package:tasks_app/presentation/shared/widgets/widgets.dart';




class TaskScreen extends ConsumerWidget {
  final String taskId;

  const TaskScreen({super.key, required this.taskId});

  void showSnackbar( BuildContext context ) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tarea Actualizada'))
    );
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final taskState = ref.watch( taskProvider(taskId) );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('tarea'),
          actions: [

            taskId!='new' ? IconButton(onPressed: () async {
              final photoPath = await CameraGalleryServiceImpl().selectPhoto();
              if ( photoPath == null ) return;

              ref.read( taskFormProvider(taskState.task!).notifier )
                .updateProductImage(photoPath);
    
            }, 
            icon: const Icon( Icons.photo_library_outlined )
            ): const SizedBox(),

            taskId!='new' ? IconButton(onPressed: () async{
              final photoPath = await CameraGalleryServiceImpl().takePhoto();
              if ( photoPath == null ) return;

              ref.read( taskFormProvider(taskState.task!).notifier )
                .updateProductImage(photoPath);
            }, 
            icon: const Icon( Icons.camera_alt_outlined )
            ): const SizedBox(),

          ],
        ),
    
        body: taskState.isLoading 
          ? const FullScreenLoader()
          : _TaskView(task: taskState.task!, taskId: taskId ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if ( taskState.task == null ) return;
    
            ref.read(
              taskFormProvider(taskState.task!).notifier
            ).onFormSubmit()
              .then((value) {
                if ( !value ) return;
                showSnackbar(context);
              });
    
            
          },
          child: const Icon( Icons.save_as_outlined ),
        ),
      ),
    );
  }
}


class _TaskView extends ConsumerWidget {
  final String taskId;
  final Task task;

  const _TaskView({required this.task, required this.taskId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final taskForm = ref.watch( taskFormProvider(task) );


    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [

          const SizedBox( height: 10 ),
          Center(
            child: Text( taskId !='new'?
              taskForm.titulo.value : 'Nueva tarea', 
              style: textStyles.titleSmall,
              textAlign: TextAlign.center,
            )
          ),
          const SizedBox( height: 10 ),
          _TaskInformation( task: task, taskId: taskId ),
          
        ],
    );
  }
}


class _TaskInformation extends ConsumerWidget {
  final Task task;
  final String taskId;
  const _TaskInformation({required this.task, required this.taskId});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final taskForm = ref.watch( taskFormProvider(task) );


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Apertura', style: TextStyle(
            fontSize: 18,
           )),
          const SizedBox(height: 15 ),
          CustomTaskField( 
            isTopField: true,
            label: 'Titulo',
            initialValue: taskForm.titulo.value,
            enabled: taskId=='new' ? true : false,
            icon: taskId=='new' ? false : true,
            onChanged: ref.read( taskFormProvider(task).notifier).onTitleChanged,
          ),

         CustomTaskField(
           isTopField: true,
            maxLines: 3,
            label: 'Descripción',
            keyboardType: TextInputType.multiline,
            initialValue: task.descripcion,
           enabled: taskId=='new' ? true : false,
            icon: taskId=='new' ? false : true,
            onChanged: ref.read( taskFormProvider(task).notifier).onDescripcionChanged,
          ),

          CustomTaskField( 
            isTopField: true,
            maxLines: 2,
            label: 'Direccion',
            keyboardType: TextInputType.multiline,
            initialValue: task.direccion,
            enabled: taskId=='new' ? true : false,
           icon: taskId=='new' ? false : true,
           onChanged: ref.read( taskFormProvider(task).notifier).onDireccionChanged,
          ),

          //   CustomTaskField( 
          //   isTopField: true,
          //   label: 'Fecha de inicio',
          //   initialValue: taskForm.fechaInicio.toIso8601String().split('T').first,
          //   enabled: taskId=='new' ? true : false,
          //   icon: taskId=='new' ? false : true
          // ),
          CustomDateField( 
            isTopField: true,
            // isBottomField: true,
            label: 'Fecha de inicio',
            initialValue: taskForm.fechaInicio,
            fechaInicio: taskForm.fechaInicio,
             enabled: taskId=='new' ? true : false,
            icon: taskId=='new' ? false : true, 
            onChanged: ref.read( taskFormProvider(task).notifier).onDateInicioChanged,
          ),

          const SizedBox(height: 15 ),
          const Text('Seguimiento', style: TextStyle(
            fontSize: 18,
           )),
          const SizedBox(height: 15 ),
           CustomDateField( 
            isTopField: true,
            // isBottomField: true,
            label: 'Fecha final',
            initialValue: taskForm.fechaFin,
            fechaInicio: taskForm.fechaInicio,
            enabled: taskId=='new' ? false : true,
            icon: false, 
            onChanged: ref.read( taskFormProvider(task).notifier).onDateFinalChanged,
          ),
          CustomTaskField( 
            isTopField: true,
            isBottomField: true,
            // maxLines: 2,
            label: 'Comentarios',
             keyboardType: TextInputType.multiline,
            initialValue: task.comentarios,
            enabled: taskId=='new' ? false : true,
            icon: false,
            onChanged: ref.read( taskFormProvider(task).notifier).onComentariosChanged,
          ),
          const SizedBox(height: 15 ),
           const Text('Evidencia', style: TextStyle(
            fontSize: 18,
           )),
            const SizedBox(height: 15 ),
          taskId!='new' ? SizedBox(
            height: 250,
            width: 400,
            child: _ImageGallery(images: taskForm.evidencia ),
          ) : const Text('sin evidencia'),
          const SizedBox(height: 40 ),
           const Text('Cierre', style: TextStyle(
            fontSize: 18,
           )),
            const SizedBox(height: 15 ),
            OpenClosedCheckbox(estado: task.estado, 
            taskId: taskId, 
            onChanged: ref.read( taskFormProvider(task).notifier).onEstadoChanged,
            ),
            const SizedBox(height: 100 ),
        ],
      ),
    );
  }
}


class _ImageGallery extends StatelessWidget {
  final List<String> images;
  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {

    if ( images.isEmpty ) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Image.asset('assets/images/no-image.jpg', fit: BoxFit.cover )
      );
    }


    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(
        viewportFraction: 0.7
      ),
      children: images.map((image){
          
        late ImageProvider imageProvider;
        if ( image.startsWith('http') ) {
          imageProvider = NetworkImage(image);
        } else {
          imageProvider = FileImage( File(image) );
        }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: FadeInImage(
                fit: BoxFit.cover,
                image: imageProvider,
                placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
              )
            ),
          );


      }).toList(),
    );
  }
}