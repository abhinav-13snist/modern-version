import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'login.dart';
import 'register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SreenidhiApp());
}

class SreenidhiApp extends StatefulWidget {
  const SreenidhiApp({super.key});

  @override
  State<SreenidhiApp> createState() => _SreenidhiAppState();
}

class _SreenidhiAppState extends State<SreenidhiApp> {
  bool isDarkMode = true; // Default to dark mode
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
      theme:
          isDarkMode
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
      routes: {
        '/register':
            (context) => RegisterScreen(
              onLogin: () {
                Navigator.pop(context);
              },
            ),
        '/login':
            (context) => LoginPage(
              onRegister: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
        '/home':
            (context) => HomePage(
              userName: user?.email ?? 'User',
              onLogout: _onLogout,
              isDarkMode: isDarkMode,
              onToggleDarkMode: _toggleDarkMode,
            ),
      },
      home: Builder(
        builder: (BuildContext context) {
          return user == null
              ? LoginPage(
                onRegister: () {
                  Navigator.pushNamed(context, '/register');
                },
              )
              : HomePage(
                userName: user!.email ?? 'User',
                onLogout: _onLogout,
                isDarkMode: isDarkMode,
                onToggleDarkMode: _toggleDarkMode,
              );
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String userName;
  final VoidCallback onLogout;
  final bool isDarkMode;
  final ValueChanged<bool> onToggleDarkMode;

  const HomePage({
    Key? key,
    required this.userName,
    required this.onLogout,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final Set<String> favoriteClubs = {};

  final Map<String, String> roomData = {
    '1101': 'Ladies Toilet, ECE Block Ground Floor',
    '1102': 'Electro.M.lab, ECE Block Ground Floor',
    '10102':
        'Web Technologies Lab & Object-Oriented Programming through Java Lab, Opposite Basketball Ground',
    '9101':
        'Java Programming Lab, Projects Lab, Linux Programming Lab, Python Programming Lab, Information Security Lab, Opposite Basketball Ground',
    '10103': 'Basic Workshop Laboratory, Opposite Basketball Ground',
    '9102': 'Metrology Lab, Opposite Basketball Ground',
    '9103': 'Fuels & Lubricants Laboratory, Opposite Basketball Ground',
    '9116': 'Metallurgy Laboratory, Opposite Basketball Ground',
    '6003':
        'Fluid Mechanics & Hydraulics Machinery Lab, Opposite Cricket Ground',
    '6002': 'Strength of Materials Lab, Opposite Cricket Ground',
    '6008A': 'Manufacturing Processes Laboratory, Opposite Cricket Ground',
    '6001': 'Machine Tools Lab, Opposite Cricket Ground',
    '6005': 'Heat Transfer Lab, Opposite Cricket Ground',
    '6004': 'Thermal Engineering Lab, Opposite Cricket Ground',
    '5205': 'Examination Branch, Admin Block 1st Floor',
    '5201':
        'Internet of Things, Python Programming Lab, Web Technologies Lab, Cyber Security and Machine Learning Lab, Cloud Computing and IoT Lab, CN&OS Lab, Programming using Linux Lab, Admin Block 1st Floor',
    '5201A':
        'Internet of Things, Python Programming Lab, Web Technologies Lab, Cyber Security and Machine Learning Lab, Cloud Computing and IoT Lab, CN&OS Lab, Programming using Linux Lab, Admin Block 1st Floor',
    '5105': 'Administrative Office, Admin Block Ground Floor',
    '5101': 'Principal Office, Admin Block Ground Floor',
    '1104': 'Faculty Room (HOD and EEE Staff), ECE Block Ground Floor',
    '1103': 'Power Systems Lab, ECE Block Ground Floor',
    '1101A': 'Electrical Machines Lab 1, ECE Block Ground Floor',
    '1101B': 'Electrical Machines Lab 2, ECE Block Ground Floor',
    '1109': 'BEEE Lab, ECE Block Ground Floor',
    '1108': 'Lecture Hall, ECE Block Ground Floor',
    '1107':
        'Simulation Lab, Microprocessor and Microcontroller Lab, ECE Block Ground Floor',
    '1106': 'Lecture Hall, ECE Block Ground Floor',
    '1105': 'Lecture Hall, ECE Block Ground Floor',
    '1111': 'Measurements and Instrumentation Lab, ECE Block Ground Floor',
    '1112':
        'Control Systems and Simulation Lab -1 & Power Electronics and Simulation Lab -1, ECE Block Ground Floor',
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
    '1307':
        'OOPS through Java Lab, Python and Information Security Lab, Computer Organization and Computer Networks Lab, Database Management Systems Lab, ECE Block 2nd Floor',
    '1308': 'English Language Communication Skills Lab, ECE Block 2nd Floor',
    '1309': 'Faculty Room, ECE Block 2nd Floor',
    '1310': 'Lecture Hall, ECE Block 2nd Floor',
    '1311':
        'Electrical Circuits and Networks Analysis Lab -1, ECE Block 2nd Floor',
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
    '1410':
        'Microprocessor and Microcontroller Lab 1 & Computer Organization Lab, ECE Block 3rd Floor',
    '1411': 'Gents Toilet, ECE Block 3rd Floor',
    '1412': 'Internet of Things and Applications Lab -1, ECE Block 3rd Floor',
    '1413':
        'Basic Simulation and Digital Logic Design Lab -2, ECE Block 3rd Floor',
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
    '2410':
        'Linux Programming Lab and Operating Systems and ML Lab, CSE Block 3rd Floor',
    '2411':
        'Design and Analysis of Algorithms Lab and Data Analytics Lab, CSE Block 3rd Floor',
    '2412':
        'Computer Networks and Design and Analysis of Algorithms Lab, Data Analytics Lab, Compiler Design Lab, Computer Networks Lab, CSE Block 3rd Floor',
    '2413': 'Ladies Toilet, CSE Block 3rd Floor',
    '2414': 'DWDM Lab, CSE Block 3rd Floor',
    '2414A': 'DWDM Lab, CSE Block 3rd Floor',
    '2414B': 'DWDM Lab, CSE Block 3rd Floor',
    '2414C': 'DWDM Lab, CSE Block 3rd Floor',
    '2301': 'Gents Toilet, CSE Block 2nd Floor',
    '2302':
        'Data Warehousing and Data Mining Lab and Web Technologies Lab, CSE Block 2nd Floor',
    '2302A':
        'Data Warehousing and Data Mining Lab and Web Technologies Lab, CSE Block 2nd Floor',
    '2303': 'Lecture Hall, CSE Block 2nd Floor',
    '2304': 'Lecture Hall, CSE Block 2nd Floor',
    '2305': 'Lecture Hall, CSE Block 2nd Floor',
    '2306': 'Lecture Hall, CSE Block 2nd Floor',
    '2307': 'Lecture Hall, CSE Block 2nd Floor',
    '2308':
        'Android Application Development Lab and Database Management Systems Lab, CSE Block 2nd Floor',
    '2308A':
        'Android Application Development Lab and Database Management Systems Lab, CSE Block 2nd Floor',
    '2309': 'Ladies Toilet, CSE Block 2nd Floor',
    '2310': 'Faculty Room, CSE Block 2nd Floor',
    '2310A': 'Faculty Room, CSE Block 2nd Floor',
    '2310B': 'Faculty Room, CSE Block 2nd Floor',
    '2310C': 'Faculty Room, CSE Block 2nd Floor',
    '2201': 'Gents Toilet, CSE Block 1st Floor',
    '2202': 'Server Room, CSE Block 1st Floor',
    '2203':
        'Python Programming Lab and Computer Networks and Design and Analysis of Algorithm Lab, CSE Block 1st Floor',
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
    '4213':
        'Department of CSE (Cyber Security) Staff Room, First Year Block 1st Floor',
    '4214':
        'Analog and Digital Communication Lab 1, First Year Block 1st Floor',
    '4214A':
        'Analog and Digital Communication Lab 2, First Year Block 1st Floor',
    '4215': 'PSUC and DS Lab, First Year Block 1st Floor',
    '4216': 'Gents Toilet, First Year Block 1st Floor',
    '4302': 'Analog Circuits Lab 1, First Year Block 2nd Floor',
    '4303':
        'Big Data Analytics Lab, Data Warehousing and Data Mining Lab, Web Technologies Lab, First Year Block 2nd Floor',
    '4304': 'Lecture Hall, First Year Block 2nd Floor',
    '4305': 'Lecture Hall, First Year Block 2nd Floor',
    '4306': 'Lecture Hall, First Year Block 2nd Floor',
    '4307': 'Lecture Hall, First Year Block 2nd Floor',
    '4308': 'Lecture Hall, First Year Block 2nd Floor',
    '4309':
        'AI and Cloud Computing Lab, Computer Networks and Data Visualization Lab, Machine Learning & Compiler Design Lab, First Year Block 2nd Floor',
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
    '8201':
        'Oral Communication Lab and Language Laboratory 5, Biotech Block 1st Floor',
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
    '8307':
        'Department of Civil Engineering - Faculty Room, Biotech Block 2nd Floor',
    '8401': 'Lecture Hall, Biotech Block 3rd Floor',
    '8402': 'Lecture Hall, Biotech Block 3rd Floor',
    '8403': 'Lecture Hall, Biotech Block 3rd Floor',
    '8404': 'Lecture Hall, Biotech Block 3rd Floor',
    '8405': 'Lecture Hall, Biotech Block 3rd Floor',
    '8406': 'Gents Toilet, Biotech Block 3rd Floor',
    '11104':
        'Web Technologies and Information Security Lab, Data Warehousing and Mining Lab, Operating System Lab, Ethical Hacking and Compiler Design Lab, Digital Forensics, Software Engineering Lab, Blockchain Technologies and Artificial Intelligence Lab, Vulnerability Assessment and Penetration Testing Lab',
    '9108':
        'AI Lab, Deep Learning Lab, Big Data Analytics Lab, DevOps Lab, Ethical Hacking Lab, Scripting Languages Lab, Agile Software Development Lab',
    '11102C': 'Web Technologies Lab',
    '11102B': 'Artificial Intelligence Lab & Data Mining Lab',
    '11102A':
        'Software Engineering Lab & Computer Networks Lab, Machine Learning Lab & Compiler Design Lab',
    '10106':
        'Object-Oriented Programming through Java Lab, Software Engineering Lab',
    '11101': 'Analog Circuits Lab-2',
    '11103': 'Digital Logic Design Lab-2',
    '11106A': 'Java Programming Lab, Database Management Systems Lab',
    '11106B':
        'IT Workshop and R Programming Lab, Python Programming Lab, Design and Analysis of Algorithms and Computer Organization Lab',
    '11106C':
        'Python Programming Lab, Operating Systems Lab, OOPS through Java Lab, Operating Systems & Computer Networks Lab, Embedded Systems using RTOS and DAA Lab, Programming using Linux Lab, DevOps Lab, Database Systems Lab, DAA Lab, Machine Learning & Cyber Forensics Lab',
    '11105':
        'Design and Analysis of Algorithms Lab, Data Warehousing and Mining Lab, Operating Systems Lab, Cyber Security and Web Technologies Lab',
  };

  final List<MapEntry<String, String>> clubs = const [
    MapEntry(
      'IEEE Student Branch',
      'Technical innovation hub for electrical and electronics',
    ),
    MapEntry('Robotics Club', 'Automation, AI, and robotics projects'),
    MapEntry(
      'CodeChef Chapter',
      'Competitive programming and coding challenges',
    ),
    MapEntry('Eco Club', 'Environmental sustainability initiatives'),
    MapEntry('Literary Club', 'Debates, creative writing, and public speaking'),
    MapEntry('Music Club', 'Instrumental performances and vocal training'),
    MapEntry('Dance Club', 'Various dance forms and choreography workshops'),
    MapEntry(
      'Photography Club',
      'Visual storytelling and photography techniques',
    ),
    MapEntry(
      'Entrepreneurship Cell',
      'Startup incubation and business mentoring',
    ),
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

  String? expandedMenu;
  List<String> searchResults = [];

  @override
  void initState() {
    super.initState();
    if (!widget.isDarkMode) {
      widget.onToggleDarkMode(true);
    }
  }

  void _toggleMenu(String menu) {
    setState(() {
      expandedMenu = expandedMenu == menu ? null : menu;
    });
  }

  void _searchRooms(String query) {
    setState(() {
      if (query.isEmpty) {
        searchResults = [];
        return;
      }
      searchResults =
          roomData.entries
              .where((entry) => entry.key.startsWith(query))
              .map((entry) => "${entry.key} - ${entry.value}")
              .toList();
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Confirm Exit'),
                content: const Text('Are you sure you want to exit the app?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes'),
                  ),
                ],
              ),
        )) ??
        false;
  }

  Widget _buildExpandableMenu(
    String title,
    List<MapEntry<String, String>> items,
  ) {
    final isExpanded = expandedMenu == title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
          onTap: () => _toggleMenu(title),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children:
                  items.map((item) {
                    return ListTile(
                      title: Text(item.key),
                      subtitle: Text(item.value),
                      trailing:
                          title == 'Clubs'
                              ? IconButton(
                                icon: Icon(
                                  favoriteClubs.contains(item.key)
                                      ? Icons.star
                                      : Icons.star_border,
                                  color:
                                      favoriteClubs.contains(item.key)
                                          ? Colors.amber
                                          : null,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (favoriteClubs.contains(item.key)) {
                                      favoriteClubs.remove(item.key);
                                    } else {
                                      favoriteClubs.add(item.key);
                                    }
                                  });
                                },
                              )
                              : null,
                      onTap:
                          title == 'Clubs' && item.key == 'Robotics Club'
                              ? () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => const RoboticsClubGalleryPage(),
                                ),
                              )
                              : title == 'Events' && item.key == 'Sreevision'
                              ? () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SreevisionGalleryPage(),
                                ),
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
    print('Building HomePage with isDarkMode: ${widget.isDarkMode}');
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sreenidhi Navigation',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const Spacer(),
                    Text(
                      'Welcome, ${widget.userName}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                onTap: () {
                  // Handle notifications
                },
              ),
              _buildExpandableMenu('Departments', departments),
              _buildExpandableMenu('Events', events),
              _buildExpandableMenu('Organizations', organizations),
              _buildExpandableMenu('Clubs', clubs),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: widget.onLogout,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          title: const Text('Sreenidhi Navigation'),
          actions: [
            Switch(
              value: widget.isDarkMode,
              onChanged: widget.onToggleDarkMode,
              activeColor: Colors.amber,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Robotics Club',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          _GalleryImage(
                            'images/assets/WhatsApp Image 2025-05-04 at 23.23.14_6dc02be8.jpg',
                          ),
                          _GalleryImage(
                            'images/assets/WhatsApp Image 2025-05-04 at 23.23.14_9788e0c7.jpg',
                          ),
                          _GalleryImage(
                            'images/assets/WhatsApp Image 2025-05-04 at 23.23.14_ed782e36.jpg',
                          ),
                          _GalleryImage(
                            'images/assets/WhatsApp Image 2025-05-04 at 23.23.15_cad3fa3d.jpg',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sreevision',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          _GalleryImage(
                            'images/assets/WhatsApp Image 2025-05-04 at 22.28.38_1329c385.jpg',
                          ),
                          _GalleryImage(
                            'images/assets/WhatsApp Image 2025-05-04 at 22.28.39_42666499.jpg',
                          ),
                          _GalleryImage(
                            'images/assets/WhatsApp Image 2025-05-04 at 22.28.39_dbdb6aca.jpg',
                          ),
                          _GalleryImage(
                            'images/assets/WhatsApp Image 2025-05-04 at 22.28.39_ea540aef.jpg',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Clubs',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: clubs.length,
                      itemBuilder: (context, index) {
                        final club = clubs[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(club.key),
                            subtitle: Text(club.value),
                            trailing: IconButton(
                              icon: Icon(
                                favoriteClubs.contains(club.key)
                                    ? Icons.star
                                    : Icons.star_border,
                                color:
                                    favoriteClubs.contains(club.key)
                                        ? Colors.amber
                                        : null,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (favoriteClubs.contains(club.key)) {
                                    favoriteClubs.remove(club.key);
                                  } else {
                                    favoriteClubs.add(club.key);
                                  }
                                });
                              },
                            ),
                            onTap:
                                club.key == 'Robotics Club'
                                    ? () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) =>
                                                const RoboticsClubGalleryPage(),
                                      ),
                                    )
                                    : null,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: _searchRooms,
                  decoration: InputDecoration(
                    labelText: 'Search Rooms (e.g., 8101)',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor:
                        widget.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  ),
                ),
              ),
              if (searchResults.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(title: Text(searchResults[index])),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GalleryImage extends StatelessWidget {
  final String imagePath;

  const _GalleryImage(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          width: 150,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
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
        padding: const EdgeInsets.all(8),
        children:
            imagePaths
                .map(
                  (path) => ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(path, fit: BoxFit.cover),
                  ),
                )
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
        padding: const EdgeInsets.all(8),
        children:
            imagePaths
                .map(
                  (path) => ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(path, fit: BoxFit.cover),
                  ),
                )
                .toList(),
      ),
    );
  }
}
