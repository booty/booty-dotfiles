# ░░░░░░░░░█▄█░█░█░█▀▀░▀█▀░█▀▀░░░░░░░░░░
# ░░░░░░░░░█░█░█░█░▀▀█░░█░░█░░░░░░░░░░░░
# ░░░░░░░░░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░░░

mp3all() { parallel -i -j6 ffmpeg -i {} -qscale:a -vcodec copy  0 {}.mp3 ::: ls ./*.flac }
aacall() { parallel -i -j6 ffmpeg -i {} -vn -c:a libfdk_aac -afterburner 1 -vbr 5 -vcodec copy  {}.m4a ::: ls ./*.flac; }
aacall2() { parallel -i -j6 ffmpeg -i {} -vn -c:a libfdk_aac -vbr 5 -vcodec copy  {}.m4a ::: ls ./*.m4a; }
alacall() { parallel -i -j6 ffmpeg -i {} -acodec alac -vcodec copy {}.m4a ::: ls ./*.flac; }
