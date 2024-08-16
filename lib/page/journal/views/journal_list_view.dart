import 'package:flutter/material.dart';
import 'package:heyseries_dev/page/journal/model/journal_model.dart';
import 'package:heyseries_dev/page/journal/widgets/journal_action_buttons.dart';
import 'package:heyseries_dev/page/journal/widgets/journal_list_content.dart';
import 'package:heyseries_dev/widgets/custom_sliver_app_bar.dart'; 

class JournalListView extends StatelessWidget {
  final List<Journal> diaries;
  final VoidCallback onAddNew;
  final Function(Journal) onViewJournal;
  final Function(Journal) onDeleteJournal;

  const JournalListView({
    Key? key,
    required this.diaries,
    required this.onAddNew,
    required this.onViewJournal,
    required this.onDeleteJournal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(title: 'Journal'),
          SliverToBoxAdapter(
            child: JournalActionButtons(
              buttonConfigs: [
                ActionButtonConfig(
                  icon: Icons.add,
                  label: '新增日誌',
                  onPressed: onAddNew,
                  color: Theme.of(context).primaryColor,
                ),
                ActionButtonConfig(
                  icon: Icons.summarize,
                  label: '每週摘要',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('每週摘要功能即將推出，敬請期待！')),
                    );
                  },
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            child: JournalListContent(
              diaries: diaries,
              onViewJournal: onViewJournal,
              onDeleteJournal: onDeleteJournal,
            ),
          ),
        ],
      ),
    );
  }
}