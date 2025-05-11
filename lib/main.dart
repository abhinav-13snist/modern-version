// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'login.dart';
import 'register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SreenidhiApp());
}

class SreenidhiApp extends StatefulWidget {
  const SreenidhiApp({super.key});

  @override
  State<SreenidhiApp> createState() => _SreenidhiAppState();
}

class _SreenidhiAppState extends State<SreenidhiApp> {
  bool isDarkMode = false;
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      setState(() {
        user = newUser;
      });
    });
  }

  void _onLogout() {
    FirebaseAuth.instance.signOut();
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sreenidhi Navigation',
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueGrey,
          secondary: Colors.blueGrey,
        ),
      )
          : ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFf6faff),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2a5298),
          secondary: Color(0xFF1e3c72),
        ),
      ),
      home: user == null
          ? LoginPage(
        onRegister: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RegisterScreen(
                onLogin: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
      )
          : HomePage(
        userName: user!.email ?? 'User',
        onLogout: _onLogout,
        isDarkMode: isDarkMode,
        onToggleDarkMode: _toggleDarkMode,
      ),
      routes: {
        '/register': (context) => RegisterScreen(
          onLogin: () {
            Navigator.pushNamed(context, '/login');
          },
        ),
        '/login': (context) => LoginPage(
          onRegister: () {
            Navigator.pushNamed(context, '/register');
          },
        ),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  final String userName;
  final VoidCallback onLogout;
  final bool isDarkMode;
  final void Function(bool) onToggleDarkMode;

  const HomePage({
    super.key,
    required this.userName,
    required this.onLogout,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Set<String> favouriteClubs = {};
  final TextEditingController _searchController = TextEditingController();

  final Map<String, String> roomData = {
    '1101': 'Ladies Toilet, ECE Block Ground Floor',
    '1102': 'Electro.M.lab, ECE Block Ground Floor',
    '1103': 'Lecture Hall, ECE Block Ground Floor',
    '10102': 'Web Technologies Lab & Object-Oriented Programming through Java Lab, Opposite Basketball Ground',
    '9101': 'Java Programming Lab, Projects Lab, Linux Programming Lab, Python Programming Lab, Information Security Lab, Opposite Basketball Ground',
    '10103': 'Basic Workshop Laboratory, Opposite Basketball Ground',
    '9102': 'Metrology Lab, Opposite Basketball Ground',
    '9103': 'Fuels & Lubricants Laboratory, Opposite Basketball Ground',
    '9116': 'Metallurgy Laboratory, Opposite Basketball Ground',
    '6003': 'Fluid Mechanics & Hydraulics Machinery Lab, Opposite Cricket Ground',
    '6002': 'Strength of Materials Lab, Opposite Cricket Ground',
    '6008A': 'Manufacturing Processes Laboratory, Opposite Cricket Ground',
    '6001': 'Machine Tools Lab, Opposite Cricket Ground',
    '6005': 'Heat Transfer Lab, Opposite Cricket Ground',
    '6004': 'Thermal Engineering Lab, Opposite Cricket Ground',
    '5205': 'Examination Branch, Admin Block 1st Floor',
    '5201': 'Internet of Things, Python Programming Lab, Web Technologies Lab, Cyber Security and Machine Learning Lab, Cloud Computing and IoT Lab, CN&OS Lab, Programming using Linux Lab, Admin Block 1st Floor',
    '5201A': 'Internet of Things, Python Programming Lab, Web Technologies Lab, Cyber Security and Machine Learning Lab, Cloud Computing and IoT Lab, CN&OS Lab, Programming using Linux Lab, Admin Block 1st Floor',
    '5105': 'Administrative Office, Admin Block Ground Floor',
    '5101': 'Principal Office, Admin Block Ground Floor',
    '1104': 'Faculty Room (HOD and EEE Staff), ECE Block Ground Floor',
    '1103': 'Power Systems Lab, ECE Block Ground Floor',
    '1101A': 'Electrical Machines Lab 1, ECE Block Ground Floor',
    '1101B': 'Electrical Machines Lab 2, ECE Block Ground Floor',
    '1109': 'BEEE Lab, ECE Block Ground Floor',
    '1108': 'Lecture Hall, ECE Block Ground Floor',
    '1107': 'Simulation Lab, Microprocessor and Microcontroller Lab, ECE Block Ground Floor',
    '1106': 'Lecture Hall, ECE Block Ground Floor',
    '1105': 'Lecture Hall, ECE Block Ground Floor',
    '1111': 'Measurements and Instrumentation Lab, ECE Block Ground Floor',
    '1112': 'Control Systems and Simulation Lab -1 & Power Electronics and Simulation Lab -1, ECE Block Ground Floor',
    '1110': 'Boys Toilet, ECE Block Ground Floor',
    '1201': 'Ladies Toilet, ECE Block 1st Floor',
    '1202A': 'Electronic Devices and Circuits Lab 2, ECE Block 1st Floor',
    '1202': 'Electronic Devices and Circuits Lab -1, ECE Block 1st Floor',
    '1203': 'Lecture Hall, ECE Block 1st Floor',
    '1204': 'Lecture Hall, ECE Block 1st Floor',
    '1205': 'Lecture Hall, ECE Block 1st Floor',
    '1206': 'ECE Staff Room -5, ECE Block 1st Floor',
    '1207': 'ECE Staff Room -4, ECE Block 1st Floor',
    '1213': 'Faculty Room, ECE Block 1st Floor',
    '1208': 'Lecture Hall, ECE Block 1st Floor',
    '1209': 'Lecture Hall, ECE Block 1st Floor',
    '1210': 'Antenna Simulation Lab -1, ECE Block 1st Floor',
    '1211': 'Internet of Things Lab, ECE Block 1st Floor',
    '1211A': 'Computer Organization Lab, ECE Block 1st Floor',
    '1212': 'Gents Toilet, ECE Block 1st Floor',
    '1301': 'Ladies Toilet, ECE Block 2nd Floor',
    '1302': 'Lecture Hall, ECE Block 2nd Floor',
    '1303': 'VLSITD Lab -2, ECE Block 2nd Floor',
    '1304': 'Lecture Hall, ECE Block 2nd Floor',
    '1305': 'ECE Library & Conference Room, ECE Block 2nd Floor',
    '1306': 'Lecture Hall, ECE Block 2nd Floor',
    '1307': 'OOPS through Java Lab, Python and Information Security Lab, Computer Organization and Computer Networks Lab, Database Management Systems Lab, ECE Block 2nd Floor',
    '1308': 'English Language Communication Skills Lab, ECE Block 2nd Floor',
    '1309': 'Faculty Room, ECE Block 2nd Floor',
    '1310': 'Lecture Hall, ECE Block 2nd Floor',
    '1311': 'Electrical Circuits and Networks Analysis Lab -1, ECE Block 2nd Floor',
    '1312': 'Electrical Circuits and Simulation Lab -2, ECE Block 2nd Floor',
    '1313': 'Digital Signal Processing Lab -1, ECE Block 2nd Floor',
    '1314': 'Basic Simulation Lab -1, ECE Block 2nd Floor',
    '1315': 'Gents Toilet, ECE Block 2nd Floor',
    '1316': 'Faculty Room, ECE Block 2nd Floor',
    '1316A': 'Faculty Room, ECE Block 2nd Floor',
    '1401': 'Ladies Toilet, ECE Block 3rd Floor',
    '1402': 'Advanced Communications and Networks Lab, ECE Block 3rd Floor',
    '1402A': 'Microwave and Optical Communication Lab, ECE Block 3rd Floor',
    '1403': 'Lecture Hall, ECE Block 3rd Floor',
    '1404': 'Lecture Hall, ECE Block 3rd Floor',
    '1405': 'VLSI Lab, ECE Block 3rd Floor',
    '1406': 'Embedded Systems using RTOS Lab, ECE Block 3rd Floor',
    '1407': 'Lecture Hall, ECE Block 3rd Floor',
    '1408': 'Lecture Hall, ECE Block 3rd Floor',
    '1409': 'Digital Logic Design Lab, ECE Block 3rd Floor',
    '1410': 'Microprocessor and Microcontroller Lab 1 & Computer Organization Lab, ECE Block 3rd Floor',
    '1411': 'Gents Toilet, ECE Block 3rd Floor',
    '1412': 'Internet of Things and Applications Lab -1, ECE Block 3rd Floor',
    '1413': 'Basic Simulation and Digital Logic Design Lab -2, ECE Block 3rd Floor',
    '1414': 'VLSI Design Lab -2, ECE Block 3rd Floor',
    '2401': 'Gents Toilet, CSE Block 3rd Floor',
    '2402': 'Lecture Hall, CSE Block 3rd Floor',
    '2403': 'Lecture Hall, CSE Block 3rd Floor',
    '2404': 'Lecture Hall, CSE Block 3rd Floor',
    '2405': 'Lecture Hall, CSE Block 3rd Floor',
    '2406': 'Lecture Hall, CSE Block 3rd Floor',
    '2407': 'Lecture Hall, CSE Block 3rd Floor',
    '2408': 'Lecture Hall, CSE Block 3rd Floor',
    '2409': 'Lecture Hall, CSE Block 3rd Floor',
    '2410': 'Linux Programming Lab and Operating Systems and ML Lab, CSE Block 3rd Floor',
    '2411': 'Design and Analysis of Algorithms Lab and Data Analytics Lab, CSE Block 3rd Floor',
    '2412': 'Computer Networks and Design and Analysis of Algorithms Lab, Data Analytics Lab, Compiler Design Lab, Computer Networks Lab, CSE Block 3rd Floor',
    '2413': 'Ladies Toilet, CSE Block 3rd Floor',
    '2414': 'DWDM Lab, CSE Block 3rd Floor',
    '2414A': 'DWDM Lab, CSE Block 3rd Floor',
    '2414B': 'DWDM Lab, CSE Block 3rd Floor',
    '2414C': 'DWDM Lab, CSE Block 3rd Floor',
    '2301': 'Gents Toilet, CSE Block 2nd Floor',
    '2302': 'Data Warehousing and Data Mining Lab and Web Technologies Lab, CSE Block 2nd Floor',
    '2302A': 'Data Warehousing and Data Mining Lab and Web Technologies Lab, CSE Block 2nd Floor',
    '2303': 'Lecture Hall, CSE Block 2nd Floor',
    '2304': 'Lecture Hall, CSE Block 2nd Floor',
    '2305': 'Lecture Hall, CSE Block 2nd Floor',
    '2306': 'Lecture Hall, CSE Block 2nd Floor',
    '2307': 'Lecture Hall, CSE Block 2nd Floor',
    '2308': 'Android Application Development Lab and Database Management Systems Lab, CSE Block 2nd Floor',
    '2308A': 'Android Application Development Lab and Database Management Systems Lab, CSE Block 2nd Floor',
    '2309': 'Ladies Toilet, CSE Block 2nd Floor',
    '2310': 'Faculty Room, CSE Block 2nd Floor',
    '2310A': 'Faculty Room, CSE Block 2nd Floor',
    '2310B': 'Faculty Room, CSE Block 2nd Floor',
    '2310C': 'Faculty Room, CSE Block 2nd Floor',
    '2201': 'Gents Toilet, CSE Block 1st Floor',
    '2202': 'Server Room, CSE Block 1st Floor',
    '2203': 'Python Programming Lab and Computer Networks and Design and Analysis of Algorithm Lab, CSE Block 1st Floor',
    '2204': 'Lecture Hall, CSE Block 1st Floor',
    '2205': 'Lecture Hall, CSE Block 1st Floor',
    '2206': 'Lecture Hall, CSE Block 1st Floor',
    '2207': 'Lecture Hall, CSE Block 1st Floor',
    '2208': 'Lecture Hall, CSE Block 1st Floor',
    '2209': 'Compiler Design Lab and IT Lab, CSE Block 1st Floor',
    '2214': 'Operating Systems and ML Lab and IT Lab, CSE Block 1st Floor',
    'IQAC': 'Internal Quality Assurance Cell (IQAC), CSE Block Ground Floor',
    '4113': 'Seminar Hall, First Year Block Ground Floor',
    '4114A': 'LPE Lab, First Year Block Ground Floor',
    '4114B': 'LPE Lab, First Year Block Ground Floor',
    '4109A': 'Lab, First Year Block Ground Floor',
    '4108': 'Biotech Ground Floor, First Year Block Ground Floor',
    '4201': 'Lecture Hall, First Year Block 1st Floor',
    '4202': 'Lecture Hall, First Year Block 1st Floor',
    '4203': 'Lecture Hall, First Year Block 1st Floor',
    '4204': 'Lecture Hall, First Year Block 1st Floor',
    '4205': 'Lecture Hall, First Year Block 1st Floor',
    '4206': 'Lecture Hall, First Year Block 1st Floor',
    '4207': 'Lecture Hall, First Year Block 1st Floor',
    '4208': 'Language Laboratory 4 (OCL), First Year Block 1st Floor',
    '4209': 'Engineering Physics Lab 1, First Year Block 1st Floor',
    '4209A': 'Engineering Physics Lab 1, First Year Block 1st Floor',
    '4210': 'Ladies Toilet, First Year Block 1st Floor',
    '4211': 'Applied Physics Lab, First Year Block 1st Floor',
    '4212': 'Career Development Centre, First Year Block 1st Floor',
    '4213': 'Department of CSE (Cyber Security) Staff Room, First Year Block 1st Floor',
    '4214': 'Analog and Digital Communication Lab 1, First Year Block 1st Floor',
    '4214A': 'Analog and Digital Communication Lab 2, First Year Block 1st Floor',
    '4215': 'PSUC and DS Lab, First Year Block 1st Floor',
    '4216': 'Gents Toilet, First Year Block 1st Floor',
    '4302': 'Analog Circuits Lab 1, First Year Block 2nd Floor',
    '4303': 'Big Data Analytics Lab, Data Warehousing and Data Mining Lab, Web Technologies Lab, First Year Block 2nd Floor',
    '4304': 'Lecture Hall, First Year Block 2nd Floor',
    '4305': 'Lecture Hall, First Year Block 2nd Floor',
    '4306': 'Lecture Hall, First Year Block 2nd Floor',
    '4307': 'Lecture Hall, First Year Block 2nd Floor',
    '4308': 'Lecture Hall, First Year Block 2nd Floor',
    '4309': 'AI and Cloud Computing Lab, Computer Networks and Data Visualization Lab, Machine Learning & Compiler Design Lab, First Year Block 2nd Floor',
    '4311': 'Faculty Room, First Year Block 2nd Floor',
    '4311Y': 'Centre for Writing and Communication, First Year Block 2nd Floor',
    '4313': 'Engineering Chemistry Lab 1, First Year Block 2nd Floor',
    '4313A': 'Engineering Chemistry Lab 2, First Year Block 2nd Floor',
    '4314': 'Engineering Chemistry Lab 3, First Year Block 2nd Floor',
    '4315': 'Engineering Chemistry Lab 4, First Year Block 2nd Floor',
    '8101': 'Biotech Block Ground Floor',
    '8102': 'Biotech Block Ground Floor',
    '8103': 'Biotech Block Ground Floor',
    '8104': 'Biotech Block Ground Floor',
    '8105': 'Biotech Block Ground Floor',
    '8106': 'Biotech Block Ground Floor',
    '8107': 'Seminar Hall, Biotech Block Ground Floor',
    '8108': 'Gents Toilet, Biotech Block Ground Floor',
    '8109': 'Ladies Toilet, Biotech Block Ground Floor',
    '8201': 'Oral Communication Lab and Language Laboratory 5, Biotech Block 1st Floor',
    '8202': 'Lecture Hall, Biotech Block 1st Floor',
    '8203': 'Lecture Hall, Biotech Block 1st Floor',
    '8204': 'Lecture Hall, Biotech Block 1st Floor',
    '8205': 'Lecture Hall, Biotech Block 1st Floor',
    '8206': 'Lecture Hall, Biotech Block 1st Floor',
    '8207': 'School of Management Studies (MBA), Biotech Block 1st Floor',
    '8301': 'Biotech Block 2nd Floor',
    '8302': 'Biotech Block 2nd Floor',
    '8303': 'Biotech Block 2nd Floor',
    '8304': 'Biotech Block 2nd Floor',
    '8305': 'Biotech Block 2nd Floor',
    '8306': 'Biotech Block 2nd Floor',
    '8307': 'Department of Civil Engineering - Faculty Room, Biotech Block 2nd Floor',
    '8401': 'Lecture Hall, Biotech Block 3rd Floor',
    '8402': 'Lecture Hall, Biotech Block 3rd Floor',
    '8403': 'Lecture Hall, Biotech Block 3rd Floor',
    '8404': 'Lecture Hall, Biotech Block 3rd Floor',
    '8405': 'Lecture Hall, Biotech Block 3rd Floor',
    '8406': 'Gents Toilet, Biotech Block 3rd Floor',
    '11104': 'Web Technologies and Information Security Lab, Data Warehousing and Mining Lab, Operating System Lab, Ethical Hacking and Compiler Design Lab, Digital Forensics, Software Engineering Lab, Blockchain Technologies and Artificial Intelligence Lab, Vulnerability Assessment and Penetration Testing Lab',
    '9108': 'AI Lab, Deep Learning Lab, Big Data Analytics Lab, DevOps Lab, Ethical Hacking Lab, Scripting Languages Lab, Agile Software Development Lab',
    '11102C': 'Web Technologies Lab',
    '11102B': 'Artificial Intelligence Lab & Data Mining Lab',
    '11102A': 'Software Engineering Lab & Computer Networks Lab, Machine Learning Lab & Compiler Design Lab',
    '10106': 'Object-Oriented Programming through Java Lab, Software Engineering Lab',
    '11101': 'Analog Circuits Lab-2',
    '11103': 'Digital Logic Design Lab-2',
    '11106A': 'Java Programming Lab, Database Management Systems Lab',
    '11106B': 'IT Workshop and R Programming Lab, Python Programming Lab, Design and Analysis of Algorithms and Computer Organization Lab',
    '11106C': 'Python Programming Lab, Operating Systems Lab, OOPS through Java Lab, Operating Systems & Computer Networks Lab, Embedded Systems using RTOS and DAA Lab, Programming using Linux Lab, DevOps Lab, Database Systems Lab, DAA Lab, Machine Learning & Cyber Forensics Lab',
    '11105': 'Design and Analysis of Algorithms Lab, Data Warehousing and Mining Lab, Operating Systems Lab, Cyber Security and Web Technologies Lab'
  };

  final List<MapEntry<String, String>> clubs = const [
    MapEntry('IEEE Student Branch',
        'Technical innovation hub for electrical and electronics'),
    MapEntry('Robotics Club', 'Automation, AI, and robotics projects'),
    MapEntry('CodeChef Chapter', 'Competitive programming and coding challenges'),
    MapEntry('Eco Club', 'Environmental sustainability initiatives'),
    MapEntry('Literary Club', 'Debates, creative writing, and public speaking'),
    MapEntry('Music Club', 'Instrumental performances and vocal training'),
    MapEntry('Dance Club', 'Various dance forms and choreography workshops'),
    MapEntry(
        'Photography Club', 'Visual storytelling and photography techniques'),
    MapEntry('Entrepreneurship Cell', 'Startup incubation and business mentoring'),
    MapEntry('Sports Club', 'Organizes athletic activities and tournaments'),
    MapEntry('Quiz Club', 'Hosts inter-department competitions'),
    MapEntry('Theatre Club', 'Drama productions and stage performances'),
  ];

  final List<MapEntry<String, String>> organizations = const [
    MapEntry('NCC Unit', 'National Cadet Corps training programs'),
    MapEntry('NSS Chapter', 'Community service and social programs'),
    MapEntry('ISTE Chapter', 'Technical skill development workshops'),
  ];

  final List<MapEntry<String, String>> events = const [
    MapEntry('Rigolade', 'Annual technical festival with competitions'),
    MapEntry('Sreevision', 'Cultural fest with performances and shows'),
    MapEntry('Sreenovate', 'Innovation challenge and project expo'),
    MapEntry('Sports Week', 'Inter-department sports competitions'),
    MapEntry('Freshers Party', 'Welcome event for new students'),
    MapEntry('Alumni Meet', 'Networking event with graduates'),
    MapEntry('Tech Talks', 'Sessions with industry experts'),
    MapEntry('Workshop Series', 'Technical skill development workshops'),
    MapEntry('Hackathon', '24-hour coding competition'),
    MapEntry('Project Expo', 'Showcase of student innovations'),
    MapEntry('Career Fair', 'Recruitment drive with top companies'),
    MapEntry('Science Fest', 'Inter-college science competitions'),
  ];

  final List<MapEntry<String, String>> departments = const [
    MapEntry('CSE', 'Computer Science & Engineering'),
    MapEntry('AI & ML', 'Artificial Intelligence & Machine Learning'),
    MapEntry('ECE', 'Electronics & Communication Engineering'),
    MapEntry('EEE', 'Electrical & Electronics Engineering'),
    MapEntry('MECH', 'Mechanical Engineering'),
    MapEntry('CIVIL', 'Civil Engineering'),
    MapEntry('IT', 'Information Technology'),
    MapEntry('H&S', 'Humanities & Sciences'),
    MapEntry('MBA', 'Master of Business Administration'),
    MapEntry('Pharmacy', 'Pharmaceutical Sciences'),
    MapEntry('Bio-Tech', 'Biotechnology Engineering'),
  ];

  void _toggleMenu(String menu) {
    setState(() {
      expandedMenu = expandedMenu == menu ? null : menu;
    });
  }

  String? expandedMenu;

  Widget _buildClubsMenu() {
    return _buildExpandableMenu(
      'Clubs',
      clubs,
      specialHandling: (MapEntry<String, String> e) => e.key == 'Robotics Club',
    );
  }

  Widget _buildExpandableMenu(
      String title,
      List<MapEntry<String, String>> items, {
        bool Function(MapEntry<String, String>)? specialHandling,
      }) {
    final isExpanded = expandedMenu == title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
          onTap: () => _toggleMenu(title),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Column(
              children: items.map((e) {
                if (specialHandling?.call(e) ?? false) {
                  return ListTile(
                    title: Text(e.key),
                    subtitle: Text(e.value),
                    dense: true,
                    trailing: IconButton(
                      icon: Icon(
                        favouriteClubs.contains(e.key)
                            ? Icons.star
                            : Icons.star_border,
                        color: favouriteClubs.contains(e.key)
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      onPressed: () => setState(() {
                        favouriteClubs.contains(e.key)
                            ? favouriteClubs.remove(e.key)
                            : favouriteClubs.add(e.key);
                      }),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RoboticsClubGalleryPage(),
                      ),
                    ),
                  );
                }
                return ListTile(
                  title: Text(e.key),
                  subtitle: Text(e.value),
                  dense: true,
                  trailing: title == 'Clubs'
                      ? IconButton(
                    icon: Icon(
                      favouriteClubs.contains(e.key)
                          ? Icons.star
                          : Icons.star_border,
                      color: favouriteClubs.contains(e.key)
                          ? Colors.amber
                          : Colors.grey,
                    ),
                    onPressed: () => setState(() {
                      favouriteClubs.contains(e.key)
                          ? favouriteClubs.remove(e.key)
                          : favouriteClubs.add(e.key);
                    }),
                  )
                      : null,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Welcome, ${widget.userName}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            _buildClubsMenu(),
            _buildExpandableMenu('Organizations', organizations),
            _buildExpandableMenu('Departments', departments),
            _buildExpandableMenu('Events', events,
                specialHandling: (e) => e.key == 'Sreevision'),
            const Divider(),
            ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: widget.isDarkMode,
                onChanged: widget.onToggleDarkMode,
              ),
            ),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: widget.onLogout,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Sreenidhi Navigation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: RoomSearchDelegate(roomData),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: roomData.length,
        itemBuilder: (context, index) {
          final entry = roomData.entries.elementAt(index);
          return ListTile(
            title: Text('Room ${entry.key}'),
            subtitle: Text(entry.value),
          );
        },
      ),
    );
  }
}

class RoomSearchDelegate extends SearchDelegate {
  final Map<String, String> roomData;

  RoomSearchDelegate(this.roomData);

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () => query = '',
    ),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults();

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults();

  Widget _buildSearchResults() {
    final results = query.isEmpty
        ? roomData.entries.toList()
        : roomData.entries
        .where((e) => e.key.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final entry = results[index];
        return ListTile(
          title: Text(entry.key),
          subtitle: Text(entry.value),
          onTap: () => close(context, entry),
        );
      },
    );
  }
}

class RoboticsClubGalleryPage extends StatelessWidget {
  const RoboticsClubGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    const imagePaths = [
      'images/assets/WhatsApp Image 2025-05-04 at 23.23.14_6dc02be8.jpg',
      'images/assets/WhatsApp Image 2025-05-04 at 23.23.14_9788e0c7.jpg',
      'images/assets/WhatsApp Image 2025-05-04 at 23.23.14_ed782e36.jpg',
      'images/assets/WhatsApp Image 2025-05-04 at 23.23.15_cad3fa3d.jpg',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Robotics Club Gallery')),
      body: GridView.count(
        crossAxisCount: 2,
        children: imagePaths
            .asMap()
            .entries
            .map((entry) => Image(
          image: AssetImage(entry.value),
          fit: BoxFit.cover,
        ))
            .toList(),
      ),
    );
  }
}

class SreevisionGalleryPage extends StatelessWidget {
  const SreevisionGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    const imagePaths = [
      'images/assets/WhatsApp Image 2025-05-04 at 22.28.38_1329c385.jpg',
      'images/assets/WhatsApp Image 2025-05-04 at 22.28.39_42666499.jpg',
      'images/assets/WhatsApp Image 2025-05-04 at 22.28.39_dbdb6aca.jpg',
      'images/assets/WhatsApp Image 2025-05-04 at 22.28.39_ea540aef.jpg',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Sreevision Gallery')),
      body: GridView.count(
        crossAxisCount: 2,
        children: imagePaths
            .asMap()
            .entries
            .map((entry) => Image(
          image: AssetImage(entry.value),
          fit: BoxFit.cover,
        ))
            .toList(),
      ),
    );
  }
}