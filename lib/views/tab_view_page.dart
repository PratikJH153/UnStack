import 'package:dailytodo/views/calendar_page.dart';
import 'package:dailytodo/views/home.dart';
import 'package:dailytodo/views/timeline_page.dart';
import 'package:dailytodo/views/todo_list_page.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TabViewPage extends StatelessWidget {
  static const id = '/tabview';

  final String _formattedTime =
      DateFormat('EEEE, d MMMM').format(DateTime.now());
  final String? displayName;

  TabViewPage(this.displayName);

  void launchMail() async {
    final url =
        "mailto:pratik.jh2017@gmail.com?subject=${Uri.encodeFull('UnStack Feedback')}";
    if (await canLaunch(url)) {
      launch(url);
    }
  }

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
                  top: 20,
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
                                fontSize: 15,
                              ),
                            ),
                            TextSpan(
                              text: "Hey, $displayName",
                              style: kIntroTextStyle.copyWith(
                                fontSize: 18,
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
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            context: context,
                            builder: (ctx) {
                              return Container(
                                padding: EdgeInsets.only(
                                  left: 24,
                                  right: 24,
                                  top: 35,
                                  bottom: 5,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "About the app",
                                      style: kTextFieldHintTextStyle.copyWith(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "UnStack app gives us the power to trick our brain to make progress step by step 🚵. Prioritize your tasks and then complete it one by one.",
                                      style: kDesTextStyle.copyWith(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Credits for making use of beautiful images: ",
                                      style: kHintTextFieldTextStyle.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                      child: new Text(
                                        'https://icons8.com',
                                        style: kTextFieldHintTextStyle.copyWith(
                                          fontSize: 16,
                                        ),
                                      ),
                                      onTap: () => launch('https://icons8.com'),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    TextButton.icon(
                                      onPressed: () => launch(
                                          "https://www.freeprivacypolicy.com/live/038436fe-2858-4447-a915-6ac86b1e849a"),
                                      style: TextButton.styleFrom(),
                                      icon: Icon(Icons.privacy_tip_outlined),
                                      label: Text("Privacy Policy"),
                                    ),
                                    TextButton.icon(
                                      onPressed: launchMail,
                                      style: TextButton.styleFrom(),
                                      icon: Icon(
                                          CupertinoIcons.conversation_bubble),
                                      label: Text("Contact Developer"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }),
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
