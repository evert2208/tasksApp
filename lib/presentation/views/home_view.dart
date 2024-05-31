import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_app/domain/entities/task.dart';
import 'package:tasks_app/presentation/providers/tasks_provider.dart';
import 'package:tasks_app/presentation/shared/widgets/custom_appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/presentation/shared/widgets/widgets.dart';
import 'package:tasks_app/presentation/views/tasks_view.dart';



class HomeView extends ConsumerStatefulWidget {
  const HomeView({ super.key });

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> with AutomaticKeepAliveClientMixin{
    late TasksState tasks;
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = ScrollController();
     bool isLoading = false;
    bool isMounted = true;

@override
  void initState() {
    super.initState();
    Future.microtask(() => fetchTasks());
  }

    @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchTasks() async {
    try {
    ref.read(tasksProvider.notifier).getTasks();
      
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

   void openDialog( BuildContext context, Tasks task ) {
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(task.titulo, style: const TextStyle(
                fontWeight: FontWeight.bold,
              )),
        content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text('Descripcion', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            Text(
              task.descripcion,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Ubicacion', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            Text(
              task.direccion,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
             const SizedBox(height: 8),
              const Text('Asignado', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            Text(
                    task.user.nombre,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
            const SizedBox(height: 8),
            const Text('Fecha de Inicio', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
               Text(
                    task.fechaInicio.toIso8601String().split('T').first,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
               const Text('Fecha Final', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
              Text( task.fechaFin!=null ?
                    task.fechaFin.toString().split('T').first
                    : '',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                const SizedBox(height: 8),
                 const Text('Comentarios', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            Text( task.comentarios ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                   const Text('Estado', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
               Text( task.estado ? 'Abierto':'Cerrado',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
          ],
        ),
        ),
        actions: [
          FilledButton( onPressed: ()=> context.pop(), child: const Text('Aceptar')),
        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final tasksState = ref.watch( tasksProvider );
    final colors = Theme.of(context).colorScheme;
       

     return CustomScrollView(

      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final task= tasksState.listTasks[index]; 
                 return InkWell(
                  onTap: () => openDialog(context, task),
                 child: TaskCard(
                      titulo: task.titulo,
                      direccion: task.direccion,
                      estado: task.estado,
                      asignado: task.user.nombre,
                    ),
                    );
              },
              childCount: tasksState.listTasks.length, 
            ),
          )
        
      ],
    );
    
    
    // RefreshIndicator(
    //             onRefresh: fetchTasks,
    //             edgeOffset: 10,
    //             strokeWidth: 2,
    //             child: ListView.builder(
    //               controller: scrollController,
    //                itemCount: tasksState.listTasks.length,
    //               itemBuilder:  (context, index) {
    //                 final task= tasksState.listTasks[index];
    //                 // return  InkWell(
    //                 // onTap: () =>  context.push('/task/${ task.id }'),
    //                 return TaskCard(
    //                   titulo: task.titulo,
    //                   direccion: task.direccion,
    //                   estado: task.estado
    //                 // ) 
    //                 );
    //               },
    //             ),
    //            );


  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return  Text('hola');
  }


}