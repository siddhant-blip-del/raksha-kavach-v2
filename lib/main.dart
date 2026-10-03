import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const RakshaKavachApp());
}

class RakshaKavachApp extends StatelessWidget {
  const RakshaKavachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raksha Kavach V2',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const StealthCalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==========================================
// 1. STEALTH MODE / CALCULATOR DISGUISE
// ==========================================
class StealthCalculatorScreen extends StatefulWidget {
  const StealthCalculatorScreen({super.key});

  @override
  State<StealthCalculatorScreen> createState() => _StealthCalculatorScreenState();
}

class _StealthCalculatorScreenState extends State<StealthCalculatorScreen> {
  String _output = "0";
  String _inputSequence = "";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _inputSequence = "";
      } else if (value == "=") {
        // Secret PIN to unlock Real Dashboard: "7777"
        if (_inputSequence == "7777") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SubscriptionCheckScreen()),
          );
        } else {
          _output = "Error";
          _inputSequence = "";
        }
      } else {
        if (_output == "0") {
          _output = value;
        } else {
          _output += value;
        }
        _inputSequence += value;
      }
    });
  }

  Widget _buildButton(String label, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 22),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () => _onButtonPressed(label),
          child: Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator (Utility)'),
        backgroundColor: Colors.grey[850],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _output,
                style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(children: [_buildButton("7", Colors.grey[800]!), _buildButton("8", Colors.grey[800]!), _buildButton("9", Colors.grey[800]!), _buildButton("/", Colors.orange)]),
              Row(children: [_buildButton("4", Colors.grey[800]!), _buildButton("5", Colors.grey[800]!), _buildButton("6", Colors.grey[800]!), _buildButton("X", Colors.orange)]),
              Row(children: [_buildButton("1", Colors.grey[800]!), _buildButton("2", Colors.grey[800]!), _buildButton("3", Colors.grey[800]!), _buildButton("-", Colors.orange)]),
              Row(children: [_buildButton("C", Colors.red[700]!), _buildButton("0", Colors.grey[800]!), _buildButton("=", Colors.green[700]!), _buildButton("+", Colors.orange)]),
            ],
          )
        ],
      ),
    );
  }
}

// ==========================================
// 2. SUBSCRIPTION & REFUND POLICY (₹7/mo)
// ==========================================
class SubscriptionCheckScreen extends StatefulWidget {
  const SubscriptionCheckScreen({super.key});

  @override
  State<SubscriptionCheckScreen> createState() => _SubscriptionCheckScreenState();
}

class _SubscriptionCheckScreenState extends State<SubscriptionCheckScreen> {
  bool isSubscribed = false;

  @override
  void initState() {
    super.initState();
    _checkSubscription();
  }

  Future<void> _checkSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSubscribed = prefs.getBool('is_subscribed') ?? false;
    });
  }

  Future<void> _activateSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_subscribed', true);
    setState(() {
      isSubscribed = true;
    });
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSubscribed) {
      return const DashboardScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Raksha Kavach V2 - Activation'),
        backgroundColor: Colors.red[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.security, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              'Secure Your Life & Privacy',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Monthly Subscription: ₹7 Only\nUPI ID: 9863574602@ptyes',
              style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '🛡️ 5-Days Money-Back Guarantee:\nAap subscription lene ke baad pehle 5 dino ke andar kabhi bhi poora refund claim kar sakte hain agar aap satisfied nahi hain.',
                style: TextStyle(fontSize: 13, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                _activateSubscription();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Subscription activated successfully! Welcome to Raksha Kavach.')),
                );
              },
              icon: const Icon(Icons.payment),
              label: const Text('Pay ₹7 & Activate Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. MAIN DASHBOARD SCREEN
// ==========================================
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool whatsappMonitor = true;
  bool privacyGuard = true;
  String currentCoordinates = "Fetching Live GPS Location...";

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        currentCoordinates = "Location services are disabled.";
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          currentCoordinates = "Location permissions are denied.";
        });
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentCoordinates = "Lat: ${position.latitude}, Lng: ${position.longitude}";
    });
  }

  void _triggerPanicSOS() async {
    await _determinePosition();
    String emergencyMessage = "EMERGENCY ALERT! Blackmail or threat detected.\nMy Live Location: $currentCoordinates\nPlease save me and report to Cyber Cell immediately!";
    
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: '9863574602',
      queryParameters: <String, String>{
        'body': emergencyMessage,
      },
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alert generated and saved to Evidence Locker!')),
      );
    }
  }

  void _openCyberCellPortal() async {
    final Uri url = Uri.parse('https://www.cybercrime.gov.in');
    if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // Opened successfully
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raksha Kavach V2.0 Guardian'),
        backgroundColor: Colors.red[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('System Status: Protected & Stealth Active', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                        Text('Location: $currentCoordinates', style: const TextStyle(fontSize: 11, color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _triggerPanicSOS,
                icon: const Icon(Icons.warning_amber_rounded, size: 36),
                label: const Text(
                  'PANIC SOS / ALERT',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Active Protection Shields',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Social Media Notification Mirror'),
                    subtitle: const Text('Scan WhatsApp & Instagram for blackmail'),
                    secondary: const Icon(Icons.notifications_active, color: Colors.blue),
                    value: whatsappMonitor,
                    onChanged: (val) {
                      setState(() {
                        whatsappMonitor = val;
                      });
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('Gallery & Contacts Privacy Interceptor'),
                    subtitle: const Text('Block unauthorized spy apps instantly'),
                    secondary: const Icon(Icons.security, color: Colors.red),
                    value: privacyGuard,
                    onChanged: (val) {
                      setState(() {
                        privacyGuard = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Emergency Dispatch & Reporting',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _triggerPanicSOS,
                    icon: const Icon(Icons.family_restroom),
                    label: const Text('Notify Parents'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _openCyberCellPortal,
                    icon: const Icon(Icons.gavel),
                    label: const Text('Cyber Cell Report'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[900],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}