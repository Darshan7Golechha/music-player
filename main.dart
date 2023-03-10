import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Define your list of audio files here
  final List<String> audioFiles = [
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Music Player Demo',
        audioFiles: audioFiles,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.audioFiles})
      : super(key: key);

  final String title;
  final List<String> audioFiles;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AudioPlayer _player;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _loadAudio();
  }

  void _loadAudio() async {
    try {
      await _player.setUrl(widget.audioFiles[_currentIndex]);
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  void _play() {
    _player.play();
  }

  void _pause() {
    _player.pause();
  }

  void _stop() {
    _player.stop();
  }

  void _previous() {
    setState(() {
      _currentIndex = (_currentIndex - 1) % widget.audioFiles.length;
      _loadAudio();
    });
  }

  void _next() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.audioFiles.length;
      _loadAudio();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Now playing:',
            ),
            Text(
              '${widget.audioFiles[_currentIndex]}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _previous,
            tooltip: 'Previous',
            child: Icon(Icons.skip_previous),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _play,
            tooltip: 'Play',
            child: Icon(Icons.play_arrow),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _pause,
            tooltip: 'Pause',
            child: Icon(Icons.pause),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _stop,
            tooltip: 'Next',
            child: Icon(Icons.queue_play_next),
          ),
        ]),
    );
  }
  }
