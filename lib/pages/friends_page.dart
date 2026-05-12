import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message_app_flutter/Services/authentication/auth_service.dart';
import 'package:message_app_flutter/pages/chat_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final _db = Supabase.instance.client;
  final _authService = AuthService();
  final TextEditingController _contactKeyController = TextEditingController();
  String? _myContactKey;
  List<Map<String, dynamic>> _friends = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _contactKeyController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final userID = _authService.getCurrentUser()!.id;

    final userRes = await _db
        .from('users')
        .select('contact_key')
        .eq('id', userID)
        .single();

    _myContactKey = userRes['contact_key'] as String?;

    final friendsRes = await _db
        .from('friends')
        .select('user2')
        .eq('user1', _myContactKey!);

    final friendsRes2 = await _db
        .from('friends')
        .select('user1')
        .eq('user2', _myContactKey!);

    final allKeys = [
      ...friendsRes.map((r) => r['user2'] as String),
      ...friendsRes2.map((r) => r['user1'] as String),
    ];

    if (allKeys.isEmpty) {
      setState(() { _friends = []; _loading = false; });
      return;
    }

    final usersRes = await _db
        .from('users')
        .select('id, email, contact_key')
        .inFilter('contact_key', allKeys);

    setState(() {
      _friends = List<Map<String, dynamic>>.from(usersRes);
      _loading = false;
    });
  }

  Future<void> _addFriend() async {
    final key = _contactKeyController.text.trim();
    if (key.isEmpty || key == _myContactKey) return;

    final exists = await _db
        .from('users')
        .select('contact_key')
        .eq('contact_key', key)
        .maybeSingle();

    if (exists == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("دوست نہیں ملا")));
      return;
    }

    await _db.from('friends').insert({'user1': _myContactKey, 'user2': key});
    _contactKeyController.clear();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("دوست"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: ListTile(
                      title: const Text("آپ کا اپنا رابطہ نمبر"),
                      subtitle: Text(_myContactKey ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: _myContactKey ?? ''));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("کاپی ہوگئی")),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _contactKeyController,
                          decoration: InputDecoration(
                            hintText: "دوست کا رابطہ نمبر",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.person_add),
                        onPressed: _addFriend,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text("دوست", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _friends.isEmpty
                        ? const Center(child: Text("کوئی دوست نہیں"))
                        : ListView.builder(
                            itemCount: _friends.length,
                            itemBuilder: (context, i) => ListTile(
                              leading: const Icon(Icons.person),
                              title: Text(_friends[i]['email'] ?? ''),
                              subtitle: Text(_friends[i]['contact_key'] ?? ''),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                      receiverEmail: _friends[i]['email'] ?? '',
                                      receiverID: _friends[i]['id'] ?? '',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}