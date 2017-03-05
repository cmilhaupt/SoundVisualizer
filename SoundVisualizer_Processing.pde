import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 256; //must be a power of 2
int check = 0;
int RED = 0;
int r = 3;
int GREEN = 0;
int g = 2;
int BLUE = 0;
int b = 1;
float[] spectrum = new float[bands];

void setup() {
  size(512, 320);
  background(255);
  frameRate(24);

  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);

  // start the Audio Input
  in.start();

  // patch the AudioIn
  fft.input(in);
}      

void draw() { 
  background(255);
  fft.analyze(spectrum);
  //-----------------------------------------------
  // Check Minim's Beat Detection to align peaks
  //-----------------------------------------------
  //color smoothing
  RED += r;
  GREEN += g;
  BLUE += b;
  if ((RED + r) > 255)
    r = -r;
  if ((RED + r) < 0)
    r = -r;
  if ((GREEN + g) > 255)
    b = -b;
  if ((GREEN + g) < 0)
    b = -b;
  if ((BLUE + b) > 255)
    g = -g;
  if ((BLUE + b) < 0)
    g = -g;
  for (int i = 0; i < bands/4; i++) {
    int fit = width/bands * 4;
    // The result of the FFT is normalized
    // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    for (int j = 0; j <= fit; j += 2) {
      stroke(RED, GREEN, BLUE);
      line( i*fit+j, height, i*fit+j, height - spectrum[i]*height*300 );
    }
  }
}