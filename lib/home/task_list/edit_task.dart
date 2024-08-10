import 'package:flutter/material.dart';
import 'package:todo/model/task.dart';
import 'package:todo/app_colors.dart';// Ensure this is correctly defined
import 'package:intl/intl.dart'; // For date formatting

class EditTaskPage extends StatefulWidget {
  final Task task;
  EditTaskPage({required this.task});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _selectedDate = widget.task.dateTime;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTask() {
    setState(() {
      widget.task.title = _titleController.text;
      widget.task.description = _descriptionController.text;
      widget.task.dateTime = _selectedDate;
    });
    Navigator.pop(context, widget.task); // Return the updated task
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1847133758,
        title: Text('ToDoList',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          margin: EdgeInsets.all(18),
          decoration: BoxDecoration(
              color: AppColors.whiteCoLor,
              borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Adjusted for alignment
              children: [
                Center(
                  child: Text(
                    'Edit Task',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), // Increased font size for emphasis
                  ),
                ),
                SizedBox(height: 20), // Added spacing for better UI
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select date'),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center( // Centered the button for better alignment
                  child: ElevatedButton(
                    onPressed: _saveTask,
                    child: Text('Save Changes'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}