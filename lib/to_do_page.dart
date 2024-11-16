import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/add_new_task_form.dart';
import 'package:to_do_app/task_card.dart';
import 'package:to_do_app/to_do_model.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  List<ToDoModel> toDoTaskList = [];

  final List<Map<String, dynamic>> _cardColor = [
    {
      "priority": "low",
      "color": const [
        Color(0xFF81C784),
        Color(0xFF388E3C),
      ],
    },
    {
      "priority": "medium",
      "color": const [
        Color(0xFFB3E5FC),
        Color(0xFF81D4FA),
      ],
    },
    {
      "priority": "high",
      "color": const [
        Color(0xFFE57373),
        Color(0xFFC62828),
      ],
    },
  ];

  void _updateTaskList(ToDoModel newTask) {
    setState(() {
      toDoTaskList.add(newTask);
    });
  }

  List<Color> _getPriorityColors(Priority priority) {
    return _cardColor.firstWhere(
        (e) => e['priority'] == priority.toString().split('.').last)['color'];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: _cardColor[0]['color'],
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              toDoTaskList
                                  .where((e) =>
                                      e.priority.toString().split('.').last ==
                                      Priority.low.toString().split('.').last)
                                  .length
                                  .toString(),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'LOW',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: _cardColor[1]['color'],
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              toDoTaskList
                                  .where((e) =>
                                      e.priority.toString().split('.').last ==
                                      Priority.medium
                                          .toString()
                                          .split('.')
                                          .last)
                                  .length
                                  .toString(),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "MEDIUM",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: _cardColor[2]['color'],
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              toDoTaskList
                                  .where((e) =>
                                      e.priority.toString().split('.').last ==
                                      Priority.high.toString().split('.').last)
                                  .length
                                  .toString(),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "HIGH",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            toDoTaskList.sort((a, b) {
                              var dateA =
                                  DateFormat('dd-MM-yyyy').parse(a.date);
                              var dateB =
                                  DateFormat('dd-MM-yyyy').parse(b.date);
                              return dateA.compareTo(dateB);
                            });
                          });
                        },
                        icon: const Icon(Icons.sort),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: ListView.builder(
                itemCount: toDoTaskList.length,
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Dismissible(
                      key: Key(toDoTaskList[index].id),
                      onDismissed: (direction) {
                        setState(() {
                          toDoTaskList.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Task deleted")),
                        );
                      },
                      child: taskCard(
                        context,
                        index,
                        toDoTaskList[index].description,
                        toDoTaskList[index].priority.toString(),
                        toDoTaskList[index].date,
                        _getPriorityColors(toDoTaskList[index].priority),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                isScrollControlled: true,
                builder: (context) {
                  return FractionallySizedBox(
                    heightFactor:
                        0.8, // Set the height factor as per your requirement
                    child: AddNewTaskForm(
                      onTaskAdded: _updateTaskList,
                    ),
                  );
                },
              );
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
      ],
    );
  }
}
