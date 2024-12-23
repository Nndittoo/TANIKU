import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:taniku/api/api_taniku.dart';
import 'package:taniku/models/tutorial_model.dart';
import 'package:video_player/video_player.dart';

class TutorialDetailPage extends StatefulWidget {
  final int id;
  final String title;
  final String publisher;
  final String description;
  final String imageUrl;
  final String videoUrl;

  const TutorialDetailPage({
    super.key,
    required this.id,
    required this.title,
    required this.publisher,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
  });

  @override
  State<TutorialDetailPage> createState() => _TutorialDetailPageState();
}

class _TutorialDetailPageState extends State<TutorialDetailPage> {
  late FlickManager _flickManager;
  bool _isError = false;
  // String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
            ..initialize().then((_) {
              setState(() {});
            }).catchError((error) {
              setState(() {
                _isError = true;
                // _errorMessage = error.toString();
              });
              // debugPrint('Video initialization error: $error');
            }),
    );
  }

  @override
  void dispose() {
    _flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40), // Tinggi AppBar
        child: Container(
          color: Colors.transparent, // Warna AppBar putih
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment
                  .bottomCenter, // Menjaga posisi kontainer tetap berada di tengah AppBar
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol Kembali
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.grey,
                      size: 24,
                    ),
                    label: const Text(
                      "Kembali",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _isError
                ?
                //  Center(child: Text('Gagal memuat video: $_errorMessage'))
                const Center(child: Text('Gagal memuat video'))
                : _flickManager.flickVideoManager?.isVideoInitialized == true
                    ? FlickVideoPlayer(flickManager: _flickManager)
                    : const Center(child: CircularProgressIndicator()),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    radius: 28,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xff00813E),
                            fontWeight: FontWeight.w500,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Text(
                          widget.publisher,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xff00813E),
                    // Warna hijau
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Deskripsi Video",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                widget.description,
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xff00813E),
                    // Warna hijau
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Video Lainnya",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Tutorial>>(
              future: ApiService().getTutorials(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Gagal memuat data'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada video lainnya'));
                } else {
                  final tutorials = snapshot.data!
                      .where((tutorial) => tutorial.id != widget.id)
                      .toList();
                  return Column(
                    children: tutorials.map((tutorial) {
                      return _buildSmallCard(
                        context,
                        tutorial.id,
                        tutorial.judul,
                        tutorial.creator,
                        tutorial.photoCreator,
                        tutorial.deskripsi,
                        tutorial.video,
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallCard(
    BuildContext context,
    int id,
    String title,
    String publisher,
    String photoCreator,
    String description,
    String videoUrl,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TutorialDetailPage(
              id: id,
              title: title,
              publisher: publisher,
              description: description,
              imageUrl: photoCreator,
              videoUrl: videoUrl,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  photoCreator,
                  width: 129,
                  height: 116,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff00813E),
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(photoCreator),
                          radius: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(publisher,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
