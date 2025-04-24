import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/chatlistcubit.dart';
import 'package:grad_app/models/chatlistcontact.dart';
import 'package:grad_app/widgets/chatitems.dart';
import 'package:grad_app/widgets/custombottomnavbar.dart';
import 'package:grad_app/widgets/custompostappbar.dart';

class ChatListPage extends StatefulWidget {
  final bool isDoctor;
  const ChatListPage({super.key, required this.isDoctor});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  String filter = "All";

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ChatListCubit>();
    widget.isDoctor ? cubit.loadChatsForDoctor() : cubit.loadChatsForPatient();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomtoAppBar(title: "Massages"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search",
                filled: true,
                fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                FilterChip(
                  label: const Text("All"),
                  selected: filter == "All",
                  onSelected: (_) => setState(() => filter = "All"),
                  selectedColor: Colors.teal,
                   backgroundColor: Colors.grey[200],
                   side: const BorderSide(color : Color.fromARGB(255, 202, 202, 202)),
                ),
                const SizedBox(width: 12),
                FilterChip(
                  label: const Text("Unread"),
                  selected: filter == "Unread",
                  onSelected: (_) => setState(() => filter = "Unread"),
                  selectedColor: Colors.teal,
                  backgroundColor: Colors.grey[200],
                  side: const BorderSide(color : Color.fromARGB(255, 202, 202, 202)),


                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<ChatListCubit, List<ChatContactModel>>(
                builder: (context, chats) {
                  final visibleChats = filter == "All" ? chats : [];
                  return ListView.builder(
                    itemCount: visibleChats.length,
                    itemBuilder: (_, index) =>
                        ChatItem(chat: visibleChats[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
    );
  }
}
