import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final VoidCallback onLogout;
  final bool isDarkMode;
  final VoidCallback toggleDarkMode;

  const HomePage({
    Key? key,
    required this.userName,
    required this.onLogout,
    required this.isDarkMode,
    required this.toggleDarkMode,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, String> roomData = {
    '1101': 'Ladies Toilet, ECE Block Ground Floor',
    '1102': 'Electro.M.lab, ECE Block Ground Floor',
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
    // Add more rooms here
  };

  final List<Map<String, String>> clubs = const [
    {"name": "Coding Club", "room": "C-101"},
    {"name": "Robotics Club", "room": "D-202"},
    {"name": "Photography Club", "room": "E-303"},
    {"name": "Literary Club", "room": "F-404"},
  ];

  final List<String> organizations = const [
    "IEEE Student Branch",
    "NSS",
    "Entrepreneurship Cell",
    "Rotaract Club",
  ];

  final List<String> departments = const [
    "Computer Science",
    "Electronics and Communication",
    "Mechanical Engineering",
    "Civil Engineering",
    "Business Administration",
  ];

  final List<Map<String, String>> events = const [
    {"title": "Tech Symposium", "date": "2025-05-10", "location": "Auditorium"},
    {"title": "Robotics Workshop", "date": "2025-06-01", "location": "Lab D"},
    {"title": "Photography Contest", "date": "2025-06-15", "location": "Open Grounds"},
    {"title": "Literary Fest", "date": "2025-07-01", "location": "Seminar Hall"},
  ];

  String _searchQuery = "";
  List<String> _searchResults = [];

  void _searchRooms(String query) {
    setState(() {
      _searchQuery = query.trim();
      _searchResults = _searchQuery.isEmpty
          ? []
          : roomData.entries
          .where((entry) =>
      entry.key.contains(_searchQuery) ||
          entry.value.toLowerCase().contains(_searchQuery.toLowerCase()))
          .map((entry) => "${entry.key} - ${entry.value}")
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sreenidhi Navigation'),
        backgroundColor: const Color(0xFF2a5298),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Toggle Dark Mode',
            onPressed: widget.toggleDarkMode,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: widget.onLogout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${widget.userName}!',
              style: theme.textTheme.titleLarge?.copyWith(
                color: const Color(0xFF2a5298),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Search bar
            TextField(
              onChanged: _searchRooms,
              decoration: InputDecoration(
                labelText: 'Search Rooms',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),

            // Search results
            if (_searchQuery.isNotEmpty)
              _searchResults.isEmpty
                  ? const Text('No matching rooms found.')
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.room),
                  title: Text(_searchResults[index]),
                ),
              ),

            if (_searchQuery.isEmpty) ...[
              _SectionTitle("Clubs & Rooms"),
              SizedBox(
                height: 130,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: clubs.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) => _InfoCard(
                    icon: Icons.group,
                    title: clubs[index]["name"]!,
                    subtitle: "Room: ${clubs[index]["room"]!}",
                    color: Colors.blue[100]!,
                  ),
                ),
              ),

              const SizedBox(height: 32),
              _SectionTitle("Organizations"),
              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: organizations.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) => _InfoCard(
                    icon: Icons.apartment,
                    title: organizations[index],
                    color: Colors.green[100]!,
                  ),
                ),
              ),

              const SizedBox(height: 32),
              _SectionTitle("Departments"),
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: departments
                    .map((dept) => Chip(
                  label: Text(dept),
                  backgroundColor: Colors.orange[100],
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ))
                    .toList(),
              ),

              const SizedBox(height: 32),
              _SectionTitle("Upcoming Events"),
              Column(
                children: events
                    .map((event) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.event, color: Color(0xFF2a5298)),
                    title: Text(event["title"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      "${event["date"]!} • ${event["location"]!}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2a5298),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: const Color(0xFF2a5298)),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
        ],
      ),
    );
  }
}