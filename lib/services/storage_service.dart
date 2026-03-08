import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/time_entry.dart';
import '../models/project.dart';
import '../models/task.dart';

class StorageService {
  static const String _timeEntriesKey = 'time_entries';
  static const String _projectsKey = 'projects';
  static const String _tasksKey = 'tasks';

  // Time Entries
  Future<List<TimeEntry>> getTimeEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final String? entriesJson = prefs.getString(_timeEntriesKey);
    if (entriesJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(entriesJson);
    return decoded.map((e) => TimeEntry.fromJson(e)).toList();
  }

  Future<void> saveTimeEntries(List<TimeEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(entries.map((e) => e.toJson()).toList());
    await prefs.setString(_timeEntriesKey, encoded);
  }

  Future<void> addTimeEntry(TimeEntry entry) async {
    final entries = await getTimeEntries();
    entries.insert(0, entry);
    await saveTimeEntries(entries);
  }

  Future<void> deleteTimeEntry(String id) async {
    final entries = await getTimeEntries();
    entries.removeWhere((e) => e.id == id);
    await saveTimeEntries(entries);
  }

  // Projects
  Future<List<Project>> getProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final String? projectsJson = prefs.getString(_projectsKey);
    if (projectsJson == null) return _getDefaultProjects();
    
    final List<dynamic> decoded = jsonDecode(projectsJson);
    return decoded.map((e) => Project.fromJson(e)).toList();
  }

  List<Project> _getDefaultProjects() {
    return [
      Project(id: '1', name: 'Mobile App Development'),
      Project(id: '2', name: 'Web Development'),
      Project(id: '3', name: 'Backend API'),
    ];
  }

  Future<void> saveProjects(List<Project> projects) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(projects.map((e) => e.toJson()).toList());
    await prefs.setString(_projectsKey, encoded);
  }

  Future<void> addProject(Project project) async {
    final projects = await getProjects();
    projects.add(project);
    await saveProjects(projects);
  }

  // Tasks
  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksJson = prefs.getString(_tasksKey);
    if (tasksJson == null) return _getDefaultTasks();
    
    final List<dynamic> decoded = jsonDecode(tasksJson);
    return decoded.map((e) => Task.fromJson(e)).toList();
  }

  List<Task> _getDefaultTasks() {
    return [
      Task(id: '1', name: 'Design'),
      Task(id: '2', name: 'Development'),
      Task(id: '3', name: 'Testing'),
      Task(id: '4', name: 'Documentation'),
    ];
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(tasks.map((e) => e.toJson()).toList());
    await prefs.setString(_tasksKey, encoded);
  }

  Future<void> addTask(Task task) async {
    final tasks = await getTasks();
    tasks.add(task);
    await saveTasks(tasks);
  }
}
