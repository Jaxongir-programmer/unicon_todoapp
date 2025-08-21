import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/core/config/app_colors.dart';
import 'package:todoapp/core/util/extensions/extensions.dart';
import 'package:todoapp/features/common/presentation/widgets/custom_button.dart';
import 'package:todoapp/features/common/presentation/widgets/custom_text_field.dart';
import 'package:todoapp/features/main/data/models/task_model.dart';
import 'package:todoapp/features/main/presentation/bloc/task_bloc.dart';
import 'package:workmanager/workmanager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late final TabController tabController;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App", style: context.textTheme.displaySmall),
        actions: [
          IconButton(onPressed: () async {
            await Workmanager().registerOneOffTask(
              "testTaskUnique", // uniqueName
              "testTaskSimple", // simpleName
              initialDelay: const Duration(seconds: 5),
            );
          }, icon: Icon(Icons.check_rounded,color: Colors.black,))
        ],
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state.addTaskStatus == FormzSubmissionStatus.success) {
            // context.showSnackBar("Vazifa muvaffaqiyatli qo'shildi");
          }
        },
        builder: (BuildContext context, state) {
          final allTask = state.tasks;
          final doneTask = allTask.where((t) => t.isDone).toList();
          final notDoneTask = allTask.where((t) => !t.isDone).toList();

          if (state.status == FormzSubmissionStatus.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              SizedBox(
                height: 56,
                child: TabBar(
                  controller: tabController,
                  tabs: [
                    Tab(text: "All (${allTask.length})"),
                    Tab(text: "Not Done (${notDoneTask.length})"),
                    Tab(text: "Done (${doneTask.length})"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    _taskList(context, allTask),
                    _taskList(context, notDoneTask),
                    _taskList(context, doneTask),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showAddDiolog();
        },
      ),
    );
  }

  Widget _taskList(BuildContext context, List<TaskModel> list) {
    if (list.isEmpty) {
      return const Center(child: Text("Vazifalar yo‘q"));
    }

    return ListView.builder(
      itemCount: list.length,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
      ),
      itemBuilder: (context, index) {
        final task = list[index];
        return ListTile(
          title: Text("${dateFormatter(task.createdAt)} \n${task.title}", style: context.textTheme.headlineMedium),
          subtitle: Text(task.description ?? "", style: context.textTheme.bodyMedium),
          trailing: Checkbox(
            value: task.isDone,
            onChanged: (value) {
              context.read<TaskBloc>().add(
                UpdateTask(task.copyWith(isDone: value ?? false)),
              );
            },
          ),
        );
      },
    );
  }

  void showAddDiolog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Yangi vazifa qo'shish",
                style: context.textTheme.headlineLarge,
              ),
              SizedBox(
                height: 16,
              ),
              CustomTextField(
                  controller: titleController, onChanged: (String value) {}, labelText: "Title", hintText: "Title kiriting"),
              SizedBox(
                height: 16,
              ),
              CustomTextField(
                  controller: descriptionController, onChanged: (String value) {}, labelText: "Izoh", hintText: "Izoh kiriting"),
            ],
          ),
          actions: <Widget>[
            CustomButton(
              color: AppColors.dark70,
              text: "Bekor qilish",
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              height: 8,
            ),
            CustomButton(
              text: "Qoshish",
              onTap: () {
                context.read<TaskBloc>().add(
                      AddTask(
                        TaskModel(
                          id: UniqueKey().toString(),
                            title: titleController.text, description: descriptionController.text, createdAt: DateTime.now()),
                      ),
                    );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    ).then((_) {
      titleController.clear();
      descriptionController.clear();
    });
  }

  String dateFormatter(DateTime selectTime) {
    var formatter = DateFormat('MM-dd-yyyy (HH:mm:ss)');
    String formattedDate = formatter.format(selectTime);
    return formattedDate;
  }
}
