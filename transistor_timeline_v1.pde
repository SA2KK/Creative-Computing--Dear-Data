// SILICON BLOOM — VERSION 1
// This sketch shows the history of processors as a small flower garden.
// Each flower represents one chip. Larger flowers mean more transistors.

// The year at each position in this list belongs to the chip at that
// same position in the chips and transistors lists below.
int[] years = {
  1971, 1972, 1974, 1976, 1978, 1979, 1982, 1985, 1988, 1989,
  1992, 1993, 1994, 1995, 1997, 1999, 2000, 2005, 2006, 2007,
  2008, 2020, 2022, 2023, 2024
};

// Chip names, listed in the same order as the years above.
String[] chips = {
  "Intel 4004", "Intel 8008", "Intel 8080", "Intel 8085", "Intel 8086",
  "Intel 8088", "Intel 80286", "Intel 386 DX", "Intel 386 SX", "Intel 486 DX",
  "Intel 486 SL", "Intel Pentium", "Intel DX4", "Intel Pentium Pro",
  "Intel Pentium II", "Intel Pentium III", "Intel Pentium 4",
  "Intel Pentium 4 600", "Intel Core 2 Duo", "Intel Core 2 Quad",
  "Intel Core i7", "Apple M1", "Apple M2", "Apple M3", "Apple M4"
};

// Transistor counts, also in the same order. These numbers let the sketch
// choose a flower size. The f after very large numbers means float.
float[] transistorCount = {
  2300, 3500, 6000, 6500, 29000, 29000, 134000, 275000, 275000, 1200000,
  1400000, 3100000, 1600000, 5500000, 7500000, 9500000, 42000000,
  169000000, 291000000, 582000000, 731000000, 16000000000f,
  20000000000f, 25000000000f, 28000000000f
};

// Readable versions of the counts, used in the hover information.
String[] countLabels = {
  "2,300", "3,500", "6,000", "6,500", "29,000", "29,000", "134,000",
  "275,000", "275,000", "1.2 million", "1.4 million", "3.1 million",
  "1.6 million", "5.5 million", "7.5 million", "9.5 million", "42 million",
  "169 million", "291 million", "582 million", "731 million", "16 billion",
  "20 billion", "25 billion", "28 billion"
};

// Each Era has one colour: 1970s, 1980s, 1990s, 2000s and 2020s.
color[] colours = {
  #FFB35C, #FF7E6F, #EFD270, #84CFA4, #73C1EB
};

void setup() {
  // Set the drawing window's width and height in pixels.
  size(1080, 760);
}

void draw() {
  // Paint over the previous frame with a dark background.
  background(#12192B);

  // Draw the title and short description at the top.
  fill(#F5F0E0);
  textAlign(LEFT);
  textSize(30);
  text("Silicon Bloom", 42, 52);
  fill(#ADB7CB);
  textSize(14);
  text("V1  |  25 chips, from the first microprocessor to Apple M4", 44, 78);

  // This will hold the details for a flower under the mouse, if any.
  String selected = "";

  // Go through the data once and draw one flower for each chip.
  for (int i = 0; i < years.length; i++) {
    // Put each flower in a five by five arrangement.
    // Every second row shifts sideways to make the garden feel less rigid. To give it a bit of creative flair instead of remaing in static posiitons.
    int column = i % 5;
    int row = i / 5;
    float x = 145 + column * 195 + (row % 2) * 42;
    float y = 185 + row * 105;
    // Initialised and declared a new variable of type float that stores value based on the current position of the array list which links with the method flowerSize();
    float size = flowerSize(transistorCount[i]);

    // Pick a colour position based on the chip's decade.
    int era = 0;
    if (years[i] >= 1980) era = 1;
    if (years[i] >= 1990) era = 2;
    if (years[i] >= 2000) era = 3;
    if (years[i] >= 2020) era = 4;
    // Use that index to get the era's colour from the colour list.
    color ink = colours[era];

    // A faint larger circle creates a soft glow behind the flower.
    noStroke();
    fill(ink, 25);
    ellipse(x, y, size * 2.3, size * 2.3);

    // Draw four petals with simple left, right, up and down offset relative to the coordinates of the central ellipse.
    fill(ink, 120);
    ellipse(x - size * 0.36, y, size * 0.48, size * 0.48);
    ellipse(x + size * 0.36, y, size * 0.48, size * 0.48);
    ellipse(x, y - size * 0.36, size * 0.48, size * 0.48);
    ellipse(x, y + size * 0.36, size * 0.48, size * 0.48);
    fill(ink);
    // Add the flower's central circle and a tiny pale highlight.
    ellipse(x, y, size * 0.48, size * 0.48);
    fill(#FFF5DC);
    ellipse(x, y, size * 0.14, size * 0.14);

    // dist() checks how far the mouse is from this flower's centre.
    // If it is close enough, save this chip's details for display below.
    if (dist(mouseX, mouseY, x, y) < size ) {
      selected = chips[i] + "  •  " + years[i] + "  •  " + countLabels[i] + " transistors";
    }
  }

  // Draw a small colour key along the bottom of the sketch.
  String[] decades = {"1970s", "1980s", "1990s", "2000s", "2020s"};
  for (int i = 0; i < decades.length; i++) {
    // The same index connects each decade label to its colour.
    fill(colours[i]);
    noStroke();
    ellipse(48 + i * 112, height - 48, 10, 10);
    fill(#C8D0DE);
    textSize(12);
    text(decades[i], 58 + i * 112, height - 44);
  }

  fill(#F5F0E0);
  textSize(14);
  // This show's chip details when the mouse is over a flower. If the condition reslves to FALSE, then the text in line 130 is displayed.
  if (selected.length() > 0) {
    text(selected, 42, height - 82);
  } else {
    fill(#96A2B8);
    text("Hover over a flower to see its chip, year and transistor count", 42, height - 82);
  }
}

// This method turns a links the transistor count to the subsequent flower size.
float flowerSize(float count) {
  // Check the ranges in order. The first matching branch returns its size.
  if (count < 10000) {
    return 10;
  } else if (count < 100000) {
    return 15;
  } else if (count < 1000000) {
    return 20;
  } else if (count < 10000000) {
    return 25;
  } else if (count < 100000000) {
    return 30;
  } else if (count < 1000000000) {
    return 35;
  } else {
    return 50;
  }
}
