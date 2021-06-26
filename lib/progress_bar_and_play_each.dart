import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/audio_player_circular_progress.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class PlayEachInPlaylist extends StatefulWidget {
  const PlayEachInPlaylist({Key key}) : super(key: key);

  @override
  _PlayEachInPlaylistState createState() => _PlayEachInPlaylistState();
}

class _PlayEachInPlaylistState extends State<PlayEachInPlaylist> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  bool iconChange = true;
  double screenHeight = 0;
  double screenWidth = 0;

  List<Audio> audioList = [
    Audio('assets/downloadfile.mp3',
        metas: Metas(
            title: 'Random Music',
            artist: 'No Artist',
            image: MetasImage.asset('assets/music.jpg'))),
    Audio('assets/Tron Tim - Den.mp3',
        metas: Metas(
            title: 'Trốn Tìm',
            artist: 'Den',
            image: MetasImage.asset('assets/music1.jpg'))),
    Audio('assets/Havana.mp3',
        metas: Metas(
            title: 'Havana',
            artist: 'Camila Cabello',
            image: MetasImage.asset('assets/music2.jpg'))),
    Audio('assets/Phi Dieu Va Ve Sau - Nham Nhien.mp3',
        metas: Metas(
            title: 'Phi Điểu Và Ve Sầu',
            artist: 'Nhận Nhiêm',
            image: MetasImage.asset('assets/music3.jpg'))),
    Audio('assets/Thoi Khong Sai Lech - Ngai Than.mp3',
        metas: Metas(
            title: 'Thời Không Sai Lệch',
            artist: 'Ngải Thần',
            image: MetasImage.asset('assets/music4.jpg'))),
    Audio('assets/Yet Vo Hiet - Truong Tuyet Nhi.mp3',
        metas: Metas(
            title: 'Yến Vô Hiết',
            artist: 'Tương Tuyết Nhi',
            image: MetasImage.asset('assets/music5.jpg'))),
    Audio('assets/country.mp3',
        metas: Metas(
            title: 'Country',
            artist: 'No Artist',
            image: MetasImage.asset('assets/music6.jpg'))),
    Audio('assets/Gặp Nhưng Không Ở Lại - Hiền Hồ Ft. Vương Anh Tú Official Lyrics Video.mp3',
        metas: Metas(
            title: 'Gặp nhưng không ở lại',
            artist: 'Hiền Hồ',
            image: MetasImage.asset('assets/music7.jpg'))),
    Audio('assets/GIÁ NHƯ CÔ ẤY CHƯA XUẤT HIỆN ( Acoustic ver. )Miu Lê Official.mp3',
        metas: Metas(
            title: 'Giá như cô ấy chưa xuất hiện',
            artist: 'Hiền Hồ',
            image: MetasImage.asset('assets/music8.jpg'))),
    Audio('assets/Sasha Sloan - Dancing With Your Ghost (Acoustic Video).mp3',
        metas: Metas(
            title: 'Dancing with your ghost',
            artist: 'Sasha Sloan',
            image: MetasImage.asset('assets/music9.jpg'))),
  ];


  /*final List<Widget> bottomNavigationBar = [
    IconButton(
      icon: Icon(Icons.loop),
      onPressed: () {
        //loopMode(context);
      },
      iconSize: 30,
      color: Colors.white,
    ),
    IconButton(
      icon: Icon(Icons.favorite_outline_rounded),
      onPressed: () {
        Icon(Icons.favorite);
        },
      iconSize: 30,
      color: Colors.white,
    ),
    IconButton(
      icon: Icon(Icons.circle),
      onPressed: () {
        //audioPlayer.playlistPlayAtIndex(0);
      },
      color: Colors.white,
      iconSize: 30,
    ),

  ];*/

  @override
  void initState() {
    super.initState();
    setupPlaylist();
  }

  void setupPlaylist() async {
    await audioPlayer.open(Playlist(audios: audioList),
        autoStart: true,
        loopMode: LoopMode.playlist
        );
  }

  @override
  void dispose(){
    super.dispose();
    audioPlayer.dispose();
  }

  Widget audioImage(RealtimePlayingInfos realtimePlayingInfos){
    return Container(
      height: screenHeight * 0.3,
      width: screenWidth * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          realtimePlayingInfos.current.audio.audio.metas.image.path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget titleText(RealtimePlayingInfos realtimePlayingInfos){
    return Text(
      realtimePlayingInfos.current.audio.audio.metas.title,
      style: TextStyle(
        fontSize: 40,
        color: Colors.white,
        fontFamily: 'DMSerif',
      ),
    );
  }

  Widget artistText(RealtimePlayingInfos realtimePlayingInfos){
    return Text(
      realtimePlayingInfos.current.audio.audio.metas.artist,
      style: TextStyle(
        fontSize: 20,
        color: Colors.grey,
      ),
    );
  }

  Widget playList(RealtimePlayingInfos realtimePlayingInfos){
    return SingleChildScrollView(
      child: Container(
        height: screenHeight * 0.35,
        alignment: Alignment.bottomLeft,
        child: ListView.builder(
          itemBuilder: (context, index){
            return playlistItem(realtimePlayingInfos, index);
          },
        ),
      ),
    );
  }

  Widget playlistItem(RealtimePlayingInfos realtimePlayingInfos, int index){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.skip_previous_rounded),
          onPressed: () => audioPlayer.previous(),
          iconSize: screenHeight * 0.04,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        IconButton(
          icon: Icon(realtimePlayingInfos.current.playlist.currentIndex != null
              ? Icons.pause_circle_filled_rounded
              : Icons.play_circle_fill_rounded),
          onPressed: () => audioPlayer.playOrPause(),
          iconSize: screenHeight * 0.08,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        IconButton(
          icon: Icon(Icons.skip_next_rounded),
          onPressed: () => audioPlayer.next(),
          iconSize: screenHeight * 0.04,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ],
    );
  }


  Widget playBar(RealtimePlayingInfos realtimePlayingInfos){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.skip_previous_rounded),
          onPressed: () => audioPlayer.previous(),
          iconSize: screenHeight * 0.04,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        IconButton(
          icon: Icon(realtimePlayingInfos.isPlaying
              ? Icons.pause_circle_filled_rounded
              : Icons.play_circle_fill_rounded),
          onPressed: () => audioPlayer.playOrPause(),
          iconSize: screenHeight * 0.08,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        IconButton(
          icon: Icon(Icons.skip_next_rounded),
          onPressed: () => audioPlayer.next(),
          iconSize: screenHeight * 0.04,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ],
    );
  }

  Widget timestamps(RealtimePlayingInfos realtimePlayingInfos){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          transformString(realtimePlayingInfos.currentPosition.inSeconds),
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(width: screenWidth * 0.7),
        Text(
          transformString(realtimePlayingInfos.duration.inSeconds),
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  String transformString(int seconds){
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString =
        '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString';
  }

  Widget slider (RealtimePlayingInfos realtimePlayingInfos){
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            height: screenHeight * 0.3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey[1000],
                  Colors.grey[1000],
                  Colors.grey[1000],
                  Colors.grey[1000],
                ], stops: [
                  0.0,
                  0.55,
                  0.55,
                  1.0
              ], end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
              )
            ),
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            trackShape: CustomTrackShape(),
            thumbColor: Colors.white,
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.grey[800],
            overlayColor: Colors.transparent
          ),
          child: Slider.adaptive(
            value:
              realtimePlayingInfos.currentPosition.inSeconds.toDouble(),
            max: realtimePlayingInfos.duration.inSeconds.toDouble() + 3,
            min: -3,
            onChanged: (value){
              if(value <= 0){
                audioPlayer.seek(Duration(seconds: 0));
              }else if(value >= realtimePlayingInfos.duration.inSeconds){
                audioPlayer.seek(realtimePlayingInfos.duration);
              }else{
                audioPlayer.seek(Duration(seconds: value.toInt()));
              }
            },
          ),
        )
      ],
    );
  }
  Widget iconBack(BuildContext context)
  {
    return Container(
      alignment: Alignment.topLeft,
      child: NeumorphicButton(
        style: NeumorphicStyle(
          color: Colors.white10,
          shadowLightColor: Colors.transparent,
          shadowDarkColor: Colors.transparent,
          boxShape:NeumorphicBoxShape.circle()
        ),
        onPressed: () {
          Navigator.of(context).pop(AudioPlayerCircularProgress());
          audioPlayer.isPlaying;
        },
        child: Icon(Icons.arrow_back_rounded,
          color: Colors.white),
      ),
    );
  }

  Widget bottomNavigationBar(){
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: IconButton(
                iconSize: 30,
                color: Colors.white,
                onPressed: () {
                  LoopMode.playlist;
                },
                icon: Icon(Icons.loop)),
            label: 'Loop'),
        BottomNavigationBarItem(
            icon: IconButton(
                iconSize: 30,
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    Icon(iconChange
                        ? Icons.favorite
                        : Icons.favorite_outline_rounded);
                });
                },
                icon: Icon(
                  Icons.favorite_outline_rounded
                  )),
            label: 'Favorite'),
        BottomNavigationBarItem(
            icon: IconButton(
                iconSize: 30,
                color: Colors.white,
                onPressed: () {
                  audioPlayer.playlistPlayAtIndex(0);
                },
                icon: Icon(Icons.circle)),
            label: 'Play Again'
        ),
      ],
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black54,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      //showSelectedLabels: true,
      showUnselectedLabels: true,
      iconSize: screenWidth * 0.08,
    );
  }


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white10,
        bottomNavigationBar: Container(
          height: screenHeight * 0.15,
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
            ),
            child: bottomNavigationBar(),
          ),
        ),
      body: audioPlayer.builderRealtimePlayingInfos(
        builder: (context, realtimePlayingInfos){
          if (realtimePlayingInfos != null){
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                iconBack(context),
                audioImage(realtimePlayingInfos),
                SizedBox(height: screenHeight * 0.05),
                titleText(realtimePlayingInfos),
                SizedBox(height: screenHeight * 0.01),
                artistText(realtimePlayingInfos),
                SizedBox(height: screenHeight * 0.05),
                //playList(realtimePlayingInfos),
                playBar(realtimePlayingInfos),
                SizedBox(height: screenHeight * 0.05),
                timestamps(realtimePlayingInfos),
                slider(realtimePlayingInfos),
              ],
            );
          } else {
            return Column();
          }
        }
      )
    );
  }

}

class CustomTrackShape extends RoundedRectSliderTrackShape{
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}


