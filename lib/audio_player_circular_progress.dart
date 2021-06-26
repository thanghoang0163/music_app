import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:music_app/login_page.dart';
import 'package:music_app/progress_bar_and_play_each.dart';


class AudioPlayerCircularProgress extends StatefulWidget {
  @override
  _AudioPlayerCircularProgressState createState() => _AudioPlayerCircularProgressState();
}

class _AudioPlayerCircularProgressState extends State<AudioPlayerCircularProgress> {

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  double screenWidth = 0;
  double screenHeight = 0;
  final Color mainColor = Color(0xff181c27);
  final Color inactiveColor = Color(0xff5d6169);

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

  @override
  void initState() {
    super.initState();
    setupPlaylist();
  }

  void setupPlaylist() async {
    await audioPlayer.open(Playlist(audios: audioList),
        autoStart:false,
        loopMode: LoopMode.playlist);
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  Widget playlistImage(RealtimePlayingInfos realtimePlayingInfos){
    return Container(
      height: screenHeight * 0.2,
      width: screenWidth * 0.4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.asset('assets/playlist.jpg',
            fit: BoxFit.cover),
      ),
    );
  }

  Widget playlistTitle(){
    return Text(
      'Playlist',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'DMSerif',
        fontSize: 30,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget playButton(){
    return Container(
      width: screenWidth * 0.25,
      child: TextButton(
        onPressed: () => audioPlayer.playlistPlayAtIndex(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_circle_outline_rounded,
              color: mainColor,
            ),
            SizedBox(width: 5),
            Text(
              'Play',
              style: TextStyle(fontSize: 17, color: mainColor, fontFamily: 'DMSerif'),
            )
          ],
        ),
        style: ButtonStyle(
          backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white,
        ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
    )
    )
        )
      ),
    );
  }

  Widget playList(RealtimePlayingInfos realtimePlayingInfos){
    return Container(
      height: screenHeight * 0.35,
      alignment: Alignment.bottomLeft,
      child: ListView.builder(
        itemBuilder: (context, index){
          return playlistItem(index);
        },
      ),
    );
  }

  Widget playlistItem( int index){
    return InkWell(
      onTap: () => audioPlayer.playlistPlayAtIndex(index),
      splashColor: Colors.transparent,
      highlightColor: mainColor,
      child: Container(
        height: screenHeight * 0.1,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Text(
                '${index + 1}     ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DMSerif',
                ),
              ),
              SizedBox(width: screenWidth * 0.004),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      audioList[index].metas.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'DMSerif',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      audioList[index].metas.artist,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'DMSerif',
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
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
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
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
              thumbColor: mainColor,
              activeTrackColor: mainColor,
              inactiveTrackColor: inactiveColor,
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

  Widget bottomPlayContainer(RealtimePlayingInfos realtimePlayingInfos){
    return Container(
      height: screenHeight * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            Container(
              height: screenHeight * 0.08,
              width: screenWidth * 0.08,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  realtimePlayingInfos.current.audio.audio.metas.image.path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    realtimePlayingInfos.current.audio.audio.metas.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DMSerif',
                      color: mainColor,
                      fontSize: 15
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    realtimePlayingInfos.current.audio.audio.metas.artist,
                    style: TextStyle(
                      fontSize: 13, color: mainColor, fontFamily: 'DMSerif',
                    ),
                  )
                ],
              ),
            ),

            slider(realtimePlayingInfos),
            IconButton(
              icon: Icon(realtimePlayingInfos.isPlaying
                  ? Icons.pause_circle_filled_rounded
                  : Icons.play_circle_fill_rounded),
              iconSize: screenHeight * 0.07,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: mainColor,
              onPressed: () => audioPlayer.playOrPause(),
            )
          ],
        ),
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
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                },
                icon: Icon(Icons.home)),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: IconButton(
                iconSize: 30,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PlayEachInPlaylist()));
                  audioPlayer.pause();
                },
                icon: Icon(Icons.menu_rounded)),
            label: 'Play Each'),
        BottomNavigationBarItem(
          icon: IconButton(
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
                audioPlayer.previous();
              },
              icon: Icon(Icons.skip_previous_rounded)),
          label: 'Previous'
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.skip_next_rounded),
            color: Colors.white,
            iconSize: 30,
            onPressed: () {
              audioPlayer.next();
            },
          ),
            label: 'Next',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      backgroundColor: mainColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: inactiveColor,
      selectedLabelStyle: TextStyle(color: Colors.white),
      iconSize: screenWidth * 0.07,
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white10,
      bottomNavigationBar: Container(
        height: screenHeight * 0.1,
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: bottomNavigationBar(),
        ),
      ),
      body: audioPlayer.builderRealtimePlayingInfos(
          builder: (context, realtimePlayingInfos) {
            if (realtimePlayingInfos != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  playlistImage(realtimePlayingInfos),
                  SizedBox(height: screenHeight * 0.02),
                  playlistTitle(),
                  SizedBox(height: screenHeight * 0.02),
                  playButton(),
                  SizedBox(height: screenHeight * 0.02),
                  playList(realtimePlayingInfos),
                  SizedBox(height: screenHeight * 0.02),
                  bottomPlayContainer(realtimePlayingInfos)
                ],
              );
            } else
              return Column();
          }
      ),
    );
  }
}

