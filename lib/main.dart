import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: AnimatedListDemo(),
    ),
  );
}

class UserModel {
  UserModel({this.firstName, this.lastName, this.profileImageUrl});
  String firstName;
  String lastName;
  String profileImageUrl;
}

List<UserModel> listData = [
  UserModel(
    firstName: "Nash",
    lastName: "Ramdial",
    profileImageUrl:
        "https://pbs.twimg.com/profile_images/1035253589894197256/qNuF8w6e_400x400.jpg",
  ),
  UserModel(
    firstName: "Scott",
    lastName: "Stoll",
    profileImageUrl:
        "https://pbs.twimg.com/profile_images/997431887286030336/QinQPXjS_400x400.jpg",
  ),
  UserModel(
    firstName: "Simon",
    lastName: "Lightfoot",
    profileImageUrl:
        "https://pbs.twimg.com/profile_images/1017532253394624513/LgFqlJ4U_400x400.jpg",
  ),
  UserModel(
    firstName: "Jay",
    lastName: "Meijer",
    profileImageUrl:
        "https://pbs.twimg.com/profile_images/1000361976361611264/Ty8LbTKx_400x400.jpg",
  ),
  UserModel(
    firstName: "Mariano",
    lastName: "Zorrilla",
    profileImageUrl:
        "https://ca.slack-edge.com/TADUGCD9D-UC5F6HJ6T-gfbe5883d03f-1024",
  ),
];

class AnimatedListDemo extends StatefulWidget {
  _AnimatedListDemoState createState() => _AnimatedListDemoState();
}

class _AnimatedListDemoState extends State<AnimatedListDemo> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  void addUser() {
    int index = listData.length;
    listData.add(
      UserModel(
        firstName: "Norbert",
        lastName: "Kozsir",
        profileImageUrl:
            "https://pbs.twimg.com/profile_images/970033173013958656/Oz3SLVat_400x400.jpg",
      ),
    );
    _listKey.currentState
        .insertItem(index, duration: Duration(milliseconds: 500));
  }

  void deleteUser(int index) {
    var user = listData.removeAt(index);
    _listKey.currentState.removeItem(
      index,
      (BuildContext context, Animation<double> animation) {
        return FadeTransition(
          opacity:
              CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
          child: SizeTransition(
            sizeFactor:
                CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
            axisAlignment: 0.0,
            child: _buildItem(user),
          ),
        );
      },
      duration: Duration(milliseconds: 600),
    );
  }

  Widget _buildItem(UserModel user, [int index]) {
    return ListTile(
      key: ValueKey<int>(index),
      title: Text(user.firstName),
      subtitle: Text(user.lastName),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.profileImageUrl),
      ),
      onLongPress: index != null ? () => deleteUser(index) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated List Demo"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: addUser,
        ),
      ),
      body: SafeArea(
        child: AnimatedList(
          key: _listKey,
          initialItemCount: listData.length,
          itemBuilder: (BuildContext context, int index, Animation animation) {
            return FadeTransition(
              opacity: animation,
              child: _buildItem(listData[index], index),
            );
          },
        ),
      ),
    );
  }
}
