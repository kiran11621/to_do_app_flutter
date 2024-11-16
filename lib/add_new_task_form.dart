import 'package:flutter/material.dart';
import 'package:to_do_app/to_do_model.dart';
import 'package:intl/intl.dart';

class AddNewTaskForm extends StatefulWidget {
  AddNewTaskForm({
    super.key,
    required this.onTaskAdded,
  });

  final Function(ToDoModel) onTaskAdded;

  @override
  State<AddNewTaskForm> createState() => _AddNewTaskFormState();
}

class _AddNewTaskFormState extends State<AddNewTaskForm> {
  TextEditingController descriptionController = TextEditingController();

  List<String> priorityItems = [
    "LOW",
    "MEDIUM",
    "HIGH",
  ];
  String selectedPriority = "LOW";
  String selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        selectedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  Priority getPriority(String selectedPriority) {
    switch (selectedPriority) {
      case "LOW":
        return Priority.low;
      case "MEDIUM":
        return Priority.medium;
      case "HIGH":
        return Priority.high;
      default:
        return Priority.low;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 40.0,
        horizontal: 30.0,
      ),
      child: Column(
        children: [
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: "Task Description",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            items: priorityItems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              selectedPriority = value!;
            },
            value: selectedPriority,
            decoration: const InputDecoration(
              labelText: "Priority",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            readOnly: true,
            onTap: () {
              _selectDate(context);
            },
            decoration: const InputDecoration(
              labelText: 'Date',
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(
              text: selectedDate,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  ToDoModel newTask = ToDoModel(
                    description: descriptionController.text,
                    priority: getPriority(selectedPriority),
                    date: selectedDate,
                  );

                  widget.onTaskAdded(newTask);

                  Navigator.of(context).pop(priorityItems);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Add",
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
