import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jvp_app/provider/shared_states.dart';

import 'package:amplify_flutter/amplify_flutter.dart';


class ViewUserAttributesScreen extends StatefulWidget {
  const ViewUserAttributesScreen({super.key});

  @override
  State<ViewUserAttributesScreen> createState() =>
      _ViewUserAttributesScreenState();
}

class _ViewUserAttributesScreenState extends State<ViewUserAttributesScreen> {
  var _isLoading = true;
  var _errorMessage = '';
  var _userAttributes = <AuthUserAttribute>[];

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.green[800], content: Text(message)),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.red[900], content: Text(message)),
    );
  }

  Future<void> _fetchAttributes({bool isRefresh = false}) async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      setState(() {
        _userAttributes = List.of(attributes)
          ..sort((a, b) => a.userAttributeKey.compareTo(b.userAttributeKey));
      });
      if (isRefresh) {
        _showSuccess('User Attributes Refreshed Successfully');
      }
    } on Exception catch (e) {
      final errorMessage = 'There was an error fetching the user attribute: $e';

      if (isRefresh) {
        _showError(errorMessage);
      } else {
        setState(() => _errorMessage = errorMessage);
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    _fetchAttributes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _fetchAttributes(isRefresh: true),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (_errorMessage != '') {
            return Center(child: Text(_errorMessage));
          } else if (_userAttributes.isEmpty) {
            return const Center(child: Text('This user has no attributes'));
          } else {
            return RefreshIndicator(
              onRefresh: () => _fetchAttributes(isRefresh: true),
              child: ListView.builder(
                itemCount: _userAttributes.length,
                itemBuilder: (context, index) {
                  final attribute = _userAttributes[index];
                  final userAttributeKey =
                  attribute.userAttributeKey.toCognitoUserAttributeKey();
                  final value = attribute.value;
                  return ListTile(
                    title: Text(_getKeyTitle(userAttributeKey.key)),
                    subtitle: Text(value),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  String _getKeyTitle(String key) {
    switch (key) {
      case 'email':
        return 'Email';
      case 'email_verified':
        return 'Email Verified';
      case 'name':
        return 'Name';
      default:
        return 'Unknown Key'; // Default case to handle unexpected keys
    }
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile.png'), // Replace with your image URL
              ),
            ),
            SizedBox(height: 20),
            ProfileItem(tag: 'Name', content: Provider.of<SharedState>(context, listen: false).username),
            ProfileItem(tag: 'Email', content: 'johndoe@example.com'),
            ProfileItem(tag: 'Skin Brightness', content: Provider.of<SharedState>(context, listen: false).skinBrightness.toString()),
            ProfileItem(tag: 'Reports', content: '4'),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Edit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  foregroundColor: Colors.white, // Text color
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text('Logout'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue, // Text color
                ),
              ),
            ),
          ],
        ),
      );
  }
}

class ProfileItem extends StatelessWidget {
  final String tag;
  final String content;

  ProfileItem({required this.tag, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1, // Adjust the flex to control the space ratio between tag and content
            child: Text(
              '$tag:',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 2, // Adjust the flex to control the space ratio between tag and content
            child: Text(
              content,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
