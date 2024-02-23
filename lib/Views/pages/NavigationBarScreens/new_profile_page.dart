import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techwise_pub/Models/user_properties.dart';
import 'package:techwise_pub/services/authenticaiton_services.dart';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({super.key});

  @override
  State<NewProfilePage> createState() => _NewProfilePageState();
}

List<Map> options = [
  {'iconData': Icons.menu, 'title': 'My Orders', 'value': Options.myOrder},
  {
    'iconData': Icons.card_giftcard,
    'title': 'Vouchers',
    'value': Options.vouchers
  },
  {
    'iconData': Icons.replay_outlined,
    'title': 'Recently Viewed',
    'value': Options.recentlyViewed
  },
  {'iconData': Icons.email_outlined, 'title': 'Inbox', 'value': Options.inbox},
];


class _NewProfilePageState extends State<NewProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProperties>(context);
    AuthenticationServices services = AuthenticationServices();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              tooltip: 'Dark mode',
              onPressed: () {},
              icon: Icon(
                Icons.sunny,
                color: Colors.black,
              ))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 52,
                        backgroundColor:user.photoUrl == null ? Colors.grey[300] : Theme.of(context).colorScheme.secondary,
                        backgroundImage: user.photoUrl == null ? null : NetworkImage(user.photoUrl!),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.fullName ?? 'User Name',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            user.email ?? 'User Email',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          OutlinedButton(
                              onPressed: () {}, child: Text('EDIT PROFILE'))
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Material(
                    clipBehavior: Clip.hardEdge,
                    elevation: 2,
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {},
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              leading: Icon(options[index]['iconData']),
                              title: Text(options[index]['title']),
                              trailing:
                                  Icon(Icons.keyboard_arrow_right_rounded),
                            ),
                            if (index != options.length - 1)
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.15,
                                    right: 20),
                                child: Divider(
                                  height: 1,
                                ),
                              )
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  await services.logout();
                },
                icon: const Icon(Icons.logout),
                label: Text(
                  'Sign Out',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum Options { myOrder, vouchers, recentlyViewed, inbox }
