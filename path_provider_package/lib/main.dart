import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Path Provider',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _tempDirectory;
  String _appDocumentsDirectory;
  String _appSupportDirectory;
  String _appLibraryDirectory;
  String _externalDocumentsDirectory;
  List<String> _externalStorageDirectories;
  List<String> _externalCacheDirectories;

  void _requestTempDirectory() async {
    final info = await path.getTemporaryDirectory();
    _tempDirectory = info.path;
    setState(() {});
  }

  void _requestAppDocumentsDirectory() async {
    final info = await path.getApplicationDocumentsDirectory();
    _appDocumentsDirectory = info.path;
    setState(() {});
  }

  void _requestAppSupportDirectory() async {
    final info = await path.getApplicationSupportDirectory();
    _appSupportDirectory = info.path;
    setState(() {});
  }

  void _requestAppLibraryDirectory() async {
    final info = await path.getLibraryDirectory();
    _appLibraryDirectory = info.path;
    setState(() {});
  }

  void _requestExternalStorageDirectory() async {
    final info = await path.getExternalStorageDirectory();
    _externalDocumentsDirectory = info.path;
    setState(() {});
  }

  void _requestExternalStorageDirectories(path.StorageDirectory type) async {
    final info = await path.getExternalStorageDirectories(type: type);
    info.forEach((element) => _externalStorageDirectories.add(element.path));
    setState(() {});
  }

  void _requestExternalCacheDirectories() async {
    final info = await path.getExternalCacheDirectories();
    info.forEach((element) => _externalStorageDirectories.add(element.path));
    setState(() {});
  }

  @override
  void initState() {
    _requestTempDirectory();
    _requestAppDocumentsDirectory();
    _requestAppSupportDirectory();
    _requestAppLibraryDirectory();
    _requestExternalStorageDirectory();
    _requestExternalStorageDirectories(path.StorageDirectory.music);
    _requestExternalCacheDirectories();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    _requestExternalStorageDirectories(path.StorageDirectory.music);

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Path Provider'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text("Direactorio de archivos temporales"),
              subtitle: Text(_tempDirectory ?? 'Loading...'),
            ),
            Divider(),
            ListTile(
              title: Text("Directorio de documentos de la app"),
              subtitle: Text(_appDocumentsDirectory ?? 'Loading...'),
            ),
            Divider(),
            ListTile(
              title: Text("Directorio de soporte de la app"),
              subtitle: Text(_appSupportDirectory ?? 'Loading...'),
            ),
            Divider(),
            ListTile(
              title: Text("Libreria de directorios para la app"),
              subtitle: Text(_appLibraryDirectory ?? 'Loading...'),
            ),
            Divider(),
            ListTile(
              title: Text("Directorio de almacenamiento externo"),
              subtitle: Text(_externalDocumentsDirectory ??
                  'No dispones de almacenamiento externo'),
            ),
            Divider(),
            Column(
              children: _externalStorageDirectories != null
                  ? _externalStorageDirectories
                      .map(
                        (e) => ListTile(
                          title: Text("ExternalStorageDocumentsDirectory"),
                          subtitle: Text(e ?? 'Loading...'),
                        ),
                      )
                      .toList()
                  : [
                      ListTile(
                        title: Text('No dispones de almacenamiento externo'),
                      ),
                    ],
            ),
            Divider(),
            Column(
              children: _externalCacheDirectories != null
                  ? _externalCacheDirectories
                      .map(
                        (e) => ListTile(
                          title: Text("ExternalCacheDocumentsDirectory"),
                          subtitle: Text(
                              e ?? 'No dispones de almacenamiento externo'),
                        ),
                      )
                      .toList()
                  : [
                      ListTile(
                        title: Text('No dispones de almacenamiento externo'),
                      ),
                    ],
            ),
          ],
        ),
      ),
    );
  }
}
