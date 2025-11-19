/// Test file to verify UserProvider and SharedPreferences work correctly
/// Run this to debug any issues with user data saving

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/user_provider.dart';
import 'models/user_model.dart';

class TestUserProviderScreen extends StatefulWidget {
  const TestUserProviderScreen({Key? key}) : super(key: key);

  @override
  State<TestUserProviderScreen> createState() => _TestUserProviderScreenState();
}

class _TestUserProviderScreenState extends State<TestUserProviderScreen> {
  String _testResults = 'Click buttons to run tests';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test User Provider')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _testResults,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _testSharedPreferences,
              child: const Text('Test 1: SharedPreferences'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _testProviderAccess,
              child: const Text('Test 2: Provider Access'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _testUserCreation,
              child: const Text('Test 3: Create User'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _testSaveUser,
              child: const Text('Test 4: Save User'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _testLoadUser,
              child: const Text('Test 5: Load User'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _runAllTests,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Run All Tests'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _testSharedPreferences() async {
    setState(() => _testResults = 'Testing SharedPreferences...');
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('test_key', 'test_value');
      final value = prefs.getString('test_key');
      
      if (value == 'test_value') {
        setState(() => _testResults = '✅ Test 1 PASSED: SharedPreferences works!\nValue: $value');
      } else {
        setState(() => _testResults = '❌ Test 1 FAILED: Value mismatch\nExpected: test_value\nGot: $value');
      }
    } catch (e) {
      setState(() => _testResults = '❌ Test 1 FAILED: $e');
    }
  }

  Future<void> _testProviderAccess() async {
    setState(() => _testResults = 'Testing Provider access...');
    
    try {
      final userProvider = context.read<UserProvider>();
      setState(() => _testResults = '✅ Test 2 PASSED: Provider accessible!\nProvider: ${userProvider.runtimeType}');
    } catch (e) {
      setState(() => _testResults = '❌ Test 2 FAILED: $e');
    }
  }

  Future<void> _testUserCreation() async {
    setState(() => _testResults = 'Testing User creation...');
    
    try {
      final user = User(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        phoneNumber: '1234567890',
        city: 'Test City',
        gender: 'Male',
      );
      
      final json = user.toJson();
      final userFromJson = User.fromJson(json);
      
      if (userFromJson.name == 'Test User' && userFromJson.email == 'test@example.com') {
        setState(() => _testResults = '✅ Test 3 PASSED: User creation works!\nUser: ${user.name}\nJSON: $json');
      } else {
        setState(() => _testResults = '❌ Test 3 FAILED: User data mismatch');
      }
    } catch (e) {
      setState(() => _testResults = '❌ Test 3 FAILED: $e');
    }
  }

  Future<void> _testSaveUser() async {
    setState(() => _testResults = 'Testing save user...');
    
    try {
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'Test User',
        email: 'test@example.com',
        phoneNumber: '1234567890',
        city: 'Test City',
        gender: 'Male',
      );
      
      final userProvider = context.read<UserProvider>();
      await userProvider.loginUser(user);
      
      if (userProvider.isLoggedIn && userProvider.user != null) {
        setState(() => _testResults = '✅ Test 4 PASSED: User saved!\nName: ${userProvider.user!.name}\nEmail: ${userProvider.user!.email}');
      } else {
        setState(() => _testResults = '❌ Test 4 FAILED: User not saved properly');
      }
    } catch (e, stack) {
      setState(() => _testResults = '❌ Test 4 FAILED: $e\n\nStack: $stack');
    }
  }

  Future<void> _testLoadUser() async {
    setState(() => _testResults = 'Testing load user...');
    
    try {
      final userProvider = context.read<UserProvider>();
      
      if (userProvider.isLoggedIn && userProvider.user != null) {
        setState(() => _testResults = '✅ Test 5 PASSED: User loaded!\nName: ${userProvider.user!.name}\nEmail: ${userProvider.user!.email}\nCity: ${userProvider.user!.city}');
      } else {
        setState(() => _testResults = '⚠️ Test 5: No user data found\nPlease run Test 4 first');
      }
    } catch (e) {
      setState(() => _testResults = '❌ Test 5 FAILED: $e');
    }
  }

  Future<void> _runAllTests() async {
    String results = 'Running all tests...\n\n';
    setState(() => _testResults = results);
    
    // Test 1
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('test_key', 'test_value');
      final value = prefs.getString('test_key');
      results += value == 'test_value' ? '✅ Test 1: SharedPreferences\n' : '❌ Test 1: SharedPreferences\n';
    } catch (e) {
      results += '❌ Test 1: SharedPreferences - $e\n';
    }
    setState(() => _testResults = results);
    
    // Test 2
    try {
      final userProvider = context.read<UserProvider>();
      results += userProvider != null ? '✅ Test 2: Provider Access\n' : '❌ Test 2: Provider Access\n';
    } catch (e) {
      results += '❌ Test 2: Provider Access - $e\n';
    }
    setState(() => _testResults = results);
    
    // Test 3
    try {
      final user = User(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        phoneNumber: '1234567890',
        city: 'Test City',
        gender: 'Male',
      );
      final json = user.toJson();
      final userFromJson = User.fromJson(json);
      results += userFromJson.name == 'Test User' ? '✅ Test 3: User Creation\n' : '❌ Test 3: User Creation\n';
    } catch (e) {
      results += '❌ Test 3: User Creation - $e\n';
    }
    setState(() => _testResults = results);
    
    // Test 4
    try {
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'Test User',
        email: 'test@example.com',
        phoneNumber: '1234567890',
        city: 'Test City',
        gender: 'Male',
      );
      final userProvider = context.read<UserProvider>();
      await userProvider.loginUser(user);
      results += userProvider.isLoggedIn ? '✅ Test 4: Save User\n' : '❌ Test 4: Save User\n';
    } catch (e) {
      results += '❌ Test 4: Save User - $e\n';
    }
    setState(() => _testResults = results);
    
    // Test 5
    try {
      final userProvider = context.read<UserProvider>();
      results += userProvider.user != null ? '✅ Test 5: Load User\n' : '⚠️ Test 5: No user data\n';
    } catch (e) {
      results += '❌ Test 5: Load User - $e\n';
    }
    
    results += '\n✅ All tests completed!';
    setState(() => _testResults = results);
  }
}
