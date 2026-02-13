import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

/// -------------------- LOGIN PAGE --------------------
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Back ✈️",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),

              /// Email
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter your email" : null,
                onChanged: (value) => email = value,
              ),
              SizedBox(height: 15),

              /// Password
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.length < 6 ? "Password must be 6+ chars" : null,
                onChanged: (value) => password = value,
              ),
              SizedBox(height: 20),

              /// Login Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {

  // After successful login (Firebase later)
  Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => HomePage(
      userEmail: email,
      joinedDate: DateTime.now().toString().split(" ")[0],
    ),
  ),
);

                  }
                },
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),

              SizedBox(height: 15),

              /// Navigate to Sign Up
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Text("Don't have an account? Sign Up"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// -------------------- SIGN UP PAGE --------------------
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Account")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 20),

              /// Name
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter your name" : null,
                onChanged: (value) => name = value,
              ),
              SizedBox(height: 15),

              /// Email
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter your email" : null,
                onChanged: (value) => email = value,
              ),
              SizedBox(height: 15),

              /// Password
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.length < 6 ? "Password must be 6+ chars" : null,
                onChanged: (value) => password = value,
              ),
              SizedBox(height: 20),

              /// Sign Up Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Account Created!")),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text("Sign Up"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class HomePage extends StatefulWidget {
  final String userEmail;
  final String joinedDate;

  HomePage({required this.userEmail, required this.joinedDate});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    List<Widget> pages = [
      HomeTab(),
      AddPostTab(),
      MessagesTab(),
      ProfileTab(
        email: widget.userEmail,
        joinedDate: widget.joinedDate,
      ),
    ];

    return Scaffold(

      /// 🔹 AppBar only for Home tab
      appBar: _selectedIndex == 0
          ? AppBar(
              title: Text("Travel Explorer 🌍"),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search destinations...",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,  // 👈 removes AppBar from other tabs

      body: pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {

  final List<Map<String, String>> posts = [
    {
      "username": "Aisha",
      "destination": "Munnar, Kerala",
      "caption": "Beautiful misty mountains 🌿",
      "image":
          "https://images.unsplash.com/photo-1501785888041-af3ef285b470"
    },
    {
      "username": "Rahul",
      "destination": "Goa",
      "caption": "Sunset vibes at the beach 🌅",
      "image":
          "https://images.unsplash.com/photo-1507525428034-b723cf961d3e"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];

        return Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔹 User Info Row
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Profile Icon
                    CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.person),
                    ),

                    SizedBox(width: 10),

                    /// Username + Destination
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post["username"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          post["destination"]!,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// 🔹 Post Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  post["image"]!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// 🔹 Action Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  children: [
                    Icon(Icons.favorite_border),
                    SizedBox(width: 15),
                    Icon(Icons.comment),
                  ],
                ),
              ),

              /// 🔹 Caption
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Text(
                  post["caption"]!,
                  style: TextStyle(fontSize: 14),
                ),
              ),

              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}


class AddPostTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [

          /// 🔹 Big Main Add Tab
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Text(
                "Add",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),

          SizedBox(height: 25),

          /// 🔹 Three Small Tabs Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              /// 📷 Camera Tab
              Expanded(
                child: _smallTab(
                  icon: Icons.camera_alt,
                  label: "Camera",
                ),
              ),

              SizedBox(width: 10),

              /// 🖼 Gallery Tab
              Expanded(
                child: _smallTab(
                  icon: Icons.image,
                  label: "Gallery",
                ),
              ),

              SizedBox(width: 10),

              /// 🔤 Text Tab
              Expanded(
                child: _smallTab(
                  icon: Icons.title,
                  label: "Text",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 Reusable Small Tab Widget
  Widget _smallTab({required IconData icon, required String label}) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}


class MessagesTab extends StatelessWidget {

  final List<Map<String, dynamic>> messages = [
    {
      "name": "Aisha",
      "lastMessage": "Hey! How was your trip?",
      "count": 2
    },
    {
      "name": "Rahul",
      "lastMessage": "Can you share the hotel details?",
      "count": 5
    },
    {
      "name": "Zara",
      "lastMessage": "Let's plan a trip soon ✈️",
      "count": 1
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [

          /// 🔹 Heading
          Center(
            child: Text(
              "CONNECTIONS",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 20),

          /// 🔹 Search Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search connections...",
                border: InputBorder.none,
                icon: Icon(Icons.search),
              ),
            ),
          ),

          SizedBox(height: 20),

          /// 🔹 Messages List
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [

                      /// Profile Icon
                      CircleAvatar(
                        radius: 25,
                        child: Icon(Icons.person),
                      ),

                      SizedBox(width: 12),

                      /// Name + Last Message
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message["name"],
                              style: TextStyle(
                                fontWeight: FontWeight.w600, // light bold
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              message["lastMessage"],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      /// Message Count Badge
                      if (message["count"] > 0)
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue, // sky blue
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            message["count"].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  final String email;
  final String joinedDate;

  ProfileTab({required this.email, required this.joinedDate});

  final String username = "Aisha Khan";
  final String bio = "Passionate traveler ✈️ | Nature lover 🌿 | Exploring the world one trip at a time.";
  final List<String> destinations = [
    "Munnar",
    "Goa",
    "Ooty",
    "Manali"
  ];

  final List<String> posts = [
    "https://images.unsplash.com/photo-1501785888041-af3ef285b470",
    "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
    "https://images.unsplash.com/photo-1470770841072-f978cf4d019e",
    "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔹 Top Heading
              Center(
                child: Text(
                  "PROFILE",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 20),

              /// 🔹 Profile Info Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CircleAvatar(
                    radius: 35,
                    child: Icon(Icons.person, size: 35),
                  ),

                  SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          email,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        SizedBox(height: 10),

                        /// Destinations
                        Text(
                          "Destinations: ${destinations.join(", ")}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              SizedBox(height: 20),

              /// 🔹 Bio
              Text(
                "Bio",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                bio,
                style: TextStyle(fontSize: 14),
              ),

              SizedBox(height: 25),

              /// 🔹 Posts Grid (4 Squares)
              Text(
                "Posts",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 10),

              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      posts[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),

              SizedBox(height: 25),

              /// 🔹 Joined Date
              Text(
                "Joined on: $joinedDate",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),

              SizedBox(height: 30),

              /// 🔹 Logout Button (Light Blue Bar)
              Center(
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "LOGOUT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

