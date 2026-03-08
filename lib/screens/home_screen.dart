import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/time_entry.dart';
import '../models/project.dart';
import '../models/task.dart';
import '../services/storage_service.dart';
import 'add_entry_screen.dart';
import 'project_management_screen.dart';
import 'task_management_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final StorageService _storage = StorageService();
  List<TimeEntry> _entries = [];
  late TabController _tabController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadEntries();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadEntries() async {
    setState(() => _isLoading = true);
    final entries = await _storage.getTimeEntries();
    setState(() {
      _entries = entries;
      _isLoading = false;
    });
  }

  Future<void> _deleteEntry(String id) async {
    await _storage.deleteTimeEntry(id);
    _loadEntries();
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.access_time, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAllEntriesTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_entries.isEmpty) {
      return _buildEmptyState('No time entries yet.\nTap + to add your first entry!');
    }

    return ListView.builder(
      itemCount: _entries.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final entry = _entries[index];
        return _buildEntryCard(entry);
      },
    );
  }

  Widget _buildProjectsTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_entries.isEmpty) {
      return _buildEmptyState('No time entries yet.\nTap + to add your first entry!');
    }

    // Group entries by project
    Map<String, List<TimeEntry>> groupedEntries = {};
    for (var entry in _entries) {
      if (!groupedEntries.containsKey(entry.projectName)) {
        groupedEntries[entry.projectName] = [];
      }
      groupedEntries[entry.projectName]!.add(entry);
    }

    return ListView.builder(
      itemCount: groupedEntries.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final projectName = groupedEntries.keys.elementAt(index);
        final projectEntries = groupedEntries[projectName]!;
        final totalTime = projectEntries.fold(0.0, (sum, entry) => sum + entry.totalTime);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: ExpansionTile(
            title: Text(
              projectName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text('Total: ${totalTime.toStringAsFixed(2)} hours'),
            children: projectEntries.map((entry) => _buildEntryCard(entry, compact: true)).toList(),
          ),
        );
      },
    );
  }

  Widget _buildEntryCard(TimeEntry entry, {bool compact = false}) {
    return Dismissible(
      key: Key(entry.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        _deleteEntry(entry.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Time entry deleted')),
        );
      },
      child: Card(
        margin: compact 
            ? const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
            : const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              entry.totalTime.toStringAsFixed(1),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          title: Text(
            entry.projectName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Task: ${entry.taskName}'),
              if (entry.notes.isNotEmpty) Text('Notes: ${entry.notes}'),
              Text(
                DateFormat('MMM dd, yyyy').format(entry.date),
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _deleteEntry(entry.id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Time entry deleted')),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracker'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All Entries'),
            Tab(text: 'Projects'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.access_time, size: 40, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'Time Tracker',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Projects'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProjectManagementScreen()),
                ).then((_) => _loadEntries());
              },
            ),
            ListTile(
              leading: const Icon(Icons.task),
              title: const Text('Tasks'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TaskManagementScreen()),
                ).then((_) => _loadEntries());
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAllEntriesTab(),
          _buildProjectsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEntryScreen()),
          ).then((_) => _loadEntries());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
