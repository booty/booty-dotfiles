# ░░░░░░░░░█▄█░█░█░█▀▀░▀█▀░█▀▀░░░░░░░░░░
# ░░░░░░░░░█░█░█░█░▀▀█░░█░░█░░░░░░░░░░░░
# ░░░░░░░░░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░░░

music.mp3all() { parallel -i -j{$(nproc)} ffmpeg -i {} -qscale:a -vcodec copy  0 {}.mp3 ::: ls ./*.flac }
music.aacall() {
  parallel -j2 ffmpeg -i "{}" -vn \
    -c:a libfdk_aac \
    -profile:a aac_low \
    -vbr 5 \
    -cutoff 18000 \
    -afterburner 1 \
    -j 8 \
    "{}.m4a" ::: *.flac
}

music.aacall2() { parallel -i -j{$(nproc)} ffmpeg -i {} -vn -c:a libfdk_aac -vbr 5 -vcodec copy  {}.m4a ::: ls ./*.m4a; }
music.alacall() { parallel -i -j{$(nproc)} ffmpeg -i {} -acodec alac -vcodec copy {}.m4a ::: ls ./*.flac; }
music.alacall_recurse() {
    find . -type f -name '*.flac' | parallel -i -j{$(nproc)} ffmpeg -i {} -acodec alac -vcodec copy {}.m4a
}
