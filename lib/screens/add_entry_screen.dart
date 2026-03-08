import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/time_entry.dart';
import '../models/project.dart';
import '../models/task.dart';
import '../services/storage_service.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final StorageService _storage = StorageService();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  
  List<Project> _projects = [];
  List<Task> _tasks = [];
  Project? _selectedProject;
  Task? _selectedTask;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _timeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final projects = await _storage.getProjects();
    final tasks = await _storage.getTasks();
    setState(() {
      _projects = projects;
      _tasks = tasks;
      _isLoading = false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveEntry() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedProject == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a project')),
        );
        return;
      }
      if (_selectedTask == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a task')),
        );
        return;
      }

      final entry = TimeEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        totalTime: double.parse(_timeController.text),
        projectId: _selectedProject!.id,
        projectName: _selectedProject!.name,
        taskId: _selectedTask!.id,
        taskName: _selectedTask!.name,
        notes: _notesController.text,
        date: _selectedDate,
      );

      await _storage.addTimeEntry(entry);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Time entry saved')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Time Entry'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Total Time (hours)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.timer),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter time';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Project>(
              decoration: const InputDecoration(
                labelText: 'Project',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.folder),
              ),
              value: _selectedProject,
              items: _projects.map((project) {
                return DropdownMenuItem(
                  value: project,
                  child: Text(project.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedProject = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a project';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Task>(
              decoration: const InputDecoration(
                labelText: 'Task',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.task),
              ),
              value: _selectedTask,
              items: _tasks.map((task) {
                return DropdownMenuItem(
                  value: task,
                  child: Text(task.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTask = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a task';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  DateFormat('MMM dd, yyyy').format(_selectedDate),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveEntry,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Save Time Entry', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
