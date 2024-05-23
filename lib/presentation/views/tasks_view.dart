
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_app/presentation/providers/tasks_provider.dart';


class TasksView extends ConsumerStatefulWidget {
  const TasksView({super.key});

   @override
  _TasksViewState createState() => _TasksViewState();

}


class _TasksViewState extends ConsumerState with TickerProviderStateMixin{
   late TasksState tasks;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = ScrollController();
   late TabController _model;
     bool isLoading = false;
    bool isMounted = true;
   @override
  void initState() {
    super.initState();
    
    _model = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));

    Future.microtask(() => fetchTasks('true'));
  }

  

  @override
  void dispose() {
     _model.dispose();
    super.dispose();
  }

  Future<void> fetchTasks(String estado) async {
    try {
      if(estado=='true'){
        ref.read(tasksProvider.notifier).loadTasks('true');
        
      }

      if(estado=='false'){
         ref.read(tasksProvider.notifier).loadTasks('false');
      }
      
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  Future<void> getProx() async {  
    try{
    isLoading = true;
    setState(() {});
    ref.read(tasksProvider.notifier).loadTasks('true');
    await Future.delayed(const Duration(seconds: 3));
    if ( !isMounted ) return;
    isLoading = false;
    setState(() {});
    }catch (e) {
      print('Error fetching tasks: $e');
    }
   
  }

   Future<void> getComp() async {  
    try{
    isLoading = true;
    setState(() {});
    ref.read(tasksProvider.notifier).loadTasks('false');
    await Future.delayed(const Duration(seconds: 3));
    if ( !isMounted ) return;
    isLoading = false;
    setState(() {});
    }catch (e) {
      print('Error fetching tasks: $e');
    }
   
  }

  @override
  Widget build(BuildContext context) {
    final tasksState = ref.watch( tasksProvider );
    final colors = Theme.of(context).colorScheme;
    

    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Tareas'),
        centerTitle: false,
        ),
      body:  SafeArea(
      top: true,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              children: [
              Align(
              alignment: const Alignment(0, 0),
              child: TabBar(
                unselectedLabelColor: colors.primary,
                tabs: const [
                Tab(text: 'Proximas'),
                Tab(text: 'Completadas'),
              ],
              controller: _model,
              onTap: (i) async {
                 [() async {await fetchTasks('true');}, () async {await fetchTasks('false');}][i]();
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _model,
              children:  [
                RefreshIndicator(
                onRefresh: getProx,
                edgeOffset: 10,
                strokeWidth: 2,
                child: ListView.builder(
                  controller: scrollController,
                   itemCount: tasksState.tasks.length,
                  itemBuilder:  (context, index) {
                    final task= tasksState.tasks[index];
                    return  InkWell(
                    onTap: () =>  context.push('/task/${ task.id }'),
                    child: TaskCard(
                      titulo: task.titulo,
                      direccion: task.direccion,
                      estado: task.estado
                    ) 
                    );
                  },
                ),
               ),
                RefreshIndicator(
                onRefresh: getComp,
                edgeOffset: 10,
                strokeWidth: 2,
                child: ListView.builder(
                  controller: scrollController,
                   itemCount: tasksState.tasks.length,
                  itemBuilder:  (context, index) {
                    final task= tasksState.tasks[index];
                    return TaskCard(
                      titulo: task.titulo,
                      direccion: task.direccion,
                      estado: task.estado
                    );
                  },
                ),
               ),
                  
               
              ],
            ),
          )
          ]
          )
          )
        ],
      ),
    ),
    //  floatingActionButton: FloatingActionButton(
    //     onPressed: () {},
    //     child:  const Icon( Icons.add ),
    //   ),
    );
    
   
  }
}


class _Card extends StatelessWidget {

  final String label;
  
  // final VoidCallback onTap;

  const _Card({
    super.key,
    required this.label,
    
    // required this.onTap
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all( Radius.circular(12) ),
        side: BorderSide(
          color: colors.primary
        )
      ),
      elevation: 0.7,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon( Icons.more_vert_outlined),
                onPressed: () {},
              ),
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child: Text('$label - outline'),
            )

          ],
        ),
      ),
    );
  }
}


class _CardType1 extends StatelessWidget {

  final String label;
  // final double elevation;

  const _CardType1({
    required this.label,
    // required this.elevation
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.9,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon( Icons.more_vert_outlined),
                onPressed: () {},
              ),
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child: Text( label ),
            )

          ],
        ),
      ),
    );
  }
}


class TaskCard extends StatelessWidget {
  final String titulo;
  final String direccion;
  final bool estado;

  const TaskCard({super.key, 
    required this.titulo,
    required this.direccion,
    required this.estado,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              direccion,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: estado == true ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    estado==true ? 'Abierto' : 'Cerrado',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

