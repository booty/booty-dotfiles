# brew install sox, if you haven't already

# --- Sox basics ---
#
# pinknoise:  A noise type that has equal energy per octave, making it sound balanced
#             across a range of frequencies. It has a smoother and less rumbling character
#             than brown noise.
#
# brownnoise: A type of noise that has more energy at lower frequencies
#
# play -n:
#             play: This command plays the generated audio.
#             -n: This tells sox to generate audio from scratch instead of playing a file.
#
# --- Note ---
#
# In the past, I sometimes had to add -r48000 (force sample rate to 48kHz) to the play command
# e.g. play -n -r48000 synth pinknoise because, I guess, it wasn't getting resampled automatically
# Presumably because in Audio MIDI Setup, I had the output set to 48kHz?
# Doesn't seem necessary in Sequioa as of Oct 2024

# Less "base" noise
alias n.wave-strong="play -n synth brownnoise synth pinknoise mix synth 0 0 0 10 10 40 trapezium amod 0.1 30"

# More "steady" noise
alias n.wave-gentle="play -n synth brownnoise synth pinknoise mix synth 0 0 0 20 20 40 trapezium amod 0.05 30"

# Band limited pink noise, centered at 60Hz with a bandwidth of 60Hz (so, 30-90hz)
alias n.pink60="play -n synth -1 pinknoise band -n 60 60 gain -30"

alias n.rain="play -n synth -1 pinknoise band -n 1000 150 gain -10 reverb 50"

alias n.fireplace="play -n synth -1 brownnoise band -n 4000 400 gain -15 overdrive 10 20"
