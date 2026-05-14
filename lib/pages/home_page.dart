import 'package:flutter/material.dart';
import 'package:message_app_flutter/Services/authentication/auth_service.dart';
import 'package:message_app_flutter/Services/chat/chat_services.dart';
import 'package:message_app_flutter/components/my_drawer.dart';
import 'package:message_app_flutter/pages/chat_page.dart';
import 'package:provider/provider.dart';
import 'package:message_app_flutter/themes/theme_provider.dart';
import 'package:message_app_flutter/global_variables.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../components/user_tile.dart' show UserTile;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final Set<String> _chattedUserIDs = {};

  @override
  void initState() {
    super.initState();
    _loadChattedUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadChattedUsers() async {
    final currentID = _authService.getCurrentUser()!.id;
    final db = Supabase.instance.client;
    final res = await db
        .from('messages')
        .select('sender_id, receiver_id')
        .or('sender_id.eq.$currentID,receiver_id.eq.$currentID');

    setState(() {
      for (final row in res) {
        final sid = row['sender_id'] as String;
        final rid = row['receiver_id'] as String;
        if (sid != currentID) _chattedUserIDs.add(sid);
        if (rid != currentID) _chattedUserIDs.add(rid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "کسی سے بات کرے",
          style: TextStyle(
            fontSize: fontSizeAppBar,
            fontWeight: fontWeightBold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: globalPadding, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "دوسرے لوگوں کو ڈھونڈیں",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
            ),
          ),
          Expanded(child: _buildUserList()),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatServices.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Center(child: Text("Error"));
        final indicator = LoadingAnimationWidget.staggeredDotsWave(color: Theme.of(context).colorScheme.primary,size: 50,);
        if (snapshot.connectionState == ConnectionState.waiting) return Center(child: indicator);
        if (!snapshot.hasData) return const Center(child: Text("No users found"));

        final filtered = snapshot.data!.where((u) {
          if (u["email"] == _authService.getCurrentUser()!.email) return false;
          if (_searchQuery.length >= 4) {
            return (u["email"] as String).toLowerCase().contains(_searchQuery);
          }
          return _chattedUserIDs.contains(u["id"]);
        }).toList();

        if (filtered.isEmpty) {
          return const Center(child: Text("یار کوئی دوست نہیں؟"));
        }

        return ListView(
          children: filtered.map((userData) => _buildUserListItem(userData, context)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
      text: userData["email"],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData["email"],
              receiverID: userData["id"],
            ),
          ),
        );
      },
    );
  }
}