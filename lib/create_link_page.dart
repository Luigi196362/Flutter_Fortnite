import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql_config.dart';
import 'graphql_queries.dart';

class CreateLinkPage extends StatefulWidget {
  final String token;
  final VoidCallback onLinkCreated;

  CreateLinkPage({required this.token, required this.onLinkCreated});

  @override
  _CreateLinkPageState createState() => _CreateLinkPageState();
}

class _CreateLinkPageState extends State<CreateLinkPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  String errorMessage = '';

  void _createLink() async {
    final client = getGraphQLClient(token: widget.token);
    final QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(createLinkMutation),
        variables: {
          'name': _nameController.text,
          'description': _descriptionController.text,
          'image': _imageController.text,
        },
      ),
    );

    if (result.hasException) {
      setState(() {
        errorMessage = result.exception.toString();
      });
    } else {
      widget.onLinkCreated(); // Llamamos a la función para refrescar los datos
      Navigator.pop(context); // Cerramos CreateLinkPage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear nuevo personaje'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripcion'),
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Url de la imagen'),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createLink,
              child: Text('Crear personaje', style: TextStyle(fontSize: 18)),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
