import 'package:dailytodo/views/calendar_page.dart';
import 'package:dailytodo/views/challenge_page.dart';
import 'package:dailytodo/views/home.dart';
import 'package:dailytodo/views/info_page.dart';
import 'package:dailytodo/views/plan_goals_page.dart';
import 'package:dailytodo/views/timeline_page.dart';
import 'package:dailytodo/views/todo_list_page.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TabViewPage extends StatelessWidget {
  static const id = '/tabview';

  final String _formattedTime =
      DateFormat('EEEE, d MMMM').format(DateTime.now());
  final String? displayName;

  TabViewPage(this.displayName);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          primary: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(136),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.06),
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(
                  left: 22,
                  right: 22,
                  top: 15,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 240,
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "$_formattedTime\n",
                              style: kHintTextFieldTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: "Hey, $displayName",
                              style: kIntroTextStyle.copyWith(
                                fontSize: 20,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.info,
                        size: 20,
                        color: const Color(0xFF616161),
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => InfoPage(
                            isInfo: true,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(CupertinoIcons.layers_alt),
                      onPressed: () =>
                          Navigator.pushNamed(context, TodoListPage.id),
                    )
                  ],
                ),
              ),
              bottom: TabBar(
                indicatorColor: kaccentColor,
                tabs: const [
                  const Tab(icon: Icon(CupertinoIcons.rocket)),
                  const Tab(icon: Icon(CupertinoIcons.timer)),
                  // const Tab(icon: Icon(CupertinoIcons.bolt_horizontal)),
                  const Tab(icon: Icon(CupertinoIcons.calendar)),
                  // const Tab(icon: Icon(CupertinoIcons.loop)),
                ],
              ),
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              TimelinePage(),
              // PlanGoalsPage(),
              CalendarPage(),
              // ChallengePage(),
            ],
          ),
        ),
      ),
    );
  }
}
