import 'package:flutter/material.dart';
import 'package:message_app_flutter/Services/authentication/auth_service.dart';
import 'package:message_app_flutter/Services/chat/chat_services.dart';
import 'package:message_app_flutter/components/chat_bubble.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:message_app_flutter/themes/theme_provider.dart';

class ChatPage extends StatefulWidget {

  final String receiverEmail;
  final String receiverID;

  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _messageController =
  TextEditingController();

  final ChatServices _chatService = ChatServices();

  final AuthService _authService = AuthService();

  final FocusNode _focusNode = FocusNode();

  final ScrollController _scrollController =
  ScrollController();

  @override
  void initState() {

    super.initState();

    _focusNode.addListener(() {

      if (_focusNode.hasFocus) {

        Future.delayed(
          const Duration(milliseconds: 400),
          scrollDown,
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 400),
      scrollDown,
    );
  }

  @override
  void dispose() {

    _focusNode.dispose();
    _messageController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  void scrollDown() {

    if (_scrollController.hasClients) {

      _scrollController.animateTo(

        _scrollController.position.maxScrollExtent,

        duration: const Duration(milliseconds: 400),

        curve: Curves.easeOut,
      );
    }
  }

  Future<void> sendMessage() async {

    if (_messageController.text.trim().isEmpty) return;

    await _chatService.sendMessage(
      widget.receiverID,
      _messageController.text.trim(),
    );

    _messageController.clear();

    Future.delayed(
      const Duration(milliseconds: 100),
      scrollDown,
    );
  }

  @override
  Widget build(BuildContext context) {

    final theme = context.watch<ThemeProvider>();

    final background = theme.wallpaper;

    return Stack(

      children: [

        // =====================================================
        // WALLPAPER
        // =====================================================

        if (background != null)

          Positioned.fill(

            child: Image.asset(
              background,
              fit: BoxFit.cover,
            ),
          ),

        // =====================================================
        // DARK OVERLAY
        // =====================================================

        if (background != null && theme.isDarkMode)

          Positioned.fill(

            child: Container(
              color: Colors.black.withOpacity(0.45),
            ),
          ),

        // =====================================================
        // MAIN UI
        // =====================================================

        Scaffold(

          backgroundColor:
          background == null
              ? Theme.of(context).colorScheme.surface
              : Colors.transparent,

          appBar: AppBar(

            title: Text(widget.receiverEmail),

            backgroundColor:
            background != null
                ? Theme.of(context)
                .colorScheme
                .surface
                .withOpacity(0.85)
                : Theme.of(context)
                .colorScheme
                .surface,
          ),

          body: Column(

            children: [

              Expanded(
                child: _buildMessageList(),
              ),

              _buildUserInput(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageList() {

    final senderID =
        _authService.getCurrentUser()?.id ?? '';

    return StreamBuilder<List<Map<String, dynamic>>>(

      stream: _chatService.getMessages(
        widget.receiverID,
        senderID,
      ),

      builder: (context, snapshot) {

        if (snapshot.hasError) {

          return const Center(
            child: Text("Error loading messages"),
          );
        }

        if (snapshot.connectionState ==
            ConnectionState.waiting) {

          return Center(

            child:
            LoadingAnimationWidget.staggeredDotsWave(

              color:
              Theme.of(context).colorScheme.primary,

              size: 50,
            ),
          );
        }

        final messages = snapshot.data ?? [];

        if (messages.isEmpty) {

          return const Center(
            child: Text("No messages yet"),
          );
        }

        WidgetsBinding.instance
            .addPostFrameCallback((_) => scrollDown());

        return ListView.builder(

          controller: _scrollController,

          itemCount: messages.length,

          itemBuilder: (context, index) {

            return _buildMessageItem(messages[index]);
          },
        );
      },
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> data) {

    final currentUserID =
        _authService.getCurrentUser()?.id ?? '';

    final isCurrentUser =
        data['sender_id'] == currentUserID;

    return Container(

      alignment:
      isCurrentUser
          ? Alignment.centerRight
          : Alignment.centerLeft,

      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),

      child: ChatBubble(
        message: data['message'] ?? '',
        isCurrentUser: isCurrentUser,
      ),
    );
  }

  Widget _buildUserInput() {

    return Padding(

      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 20,
      ),

      child: Row(

        children: [

          Expanded(

            child: TextField(

              controller: _messageController,

              focusNode: _focusNode,

              decoration: const InputDecoration(
                hintText: "اپنا پیغام پہنچائیں",
              ),

              onSubmitted: (_) => sendMessage(),
            ),
          ),

          const SizedBox(width: 12),

          Container(

            decoration: BoxDecoration(

              color:
              Theme.of(context).colorScheme.primary,

              shape: BoxShape.circle,
            ),

            child: IconButton(

              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),

              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}