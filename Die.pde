class Die
{
  int dieSize = 50;
  int num;
  int x, y;
  int paddedSize = dieSize-padding;
  int roll() 
  {
    return num = (int)(Math.random() * 6) + 1;
  }
  Die(int theX, int theY)
  {
    roll();
    x = theX;
    y = theY;
  }

  void show() 
  {
    //Avoid divide by zero error
    if (count > 0) {
      //Calculate dotSize
      int dotSize = dieSize/7; //7 different "sections" in a die
      //Base Rectangle
      rect(x, y, paddedSize, paddedSize, dotSize);
      //Dots
      noStroke();
      fill(0);
      //Middle Dot (shown when odd)
      if (num % 2 == 1) {
        ellipse(x+paddedSize/2, y+paddedSize/2, dotSize, dotSize);
      }
      //Top Left Dot & Bottom Right Dot (2, 4, 5, 6)
      if (num == 2 || num == 4 || num == 5 || num == 6) {
        ellipse(x+paddedSize/4, y+paddedSize/4, dotSize, dotSize);
        ellipse(x+paddedSize*3/4, y+paddedSize*3/4, dotSize, dotSize);
      }
      //Top Right Dot & Bottom Left Dot (3, 4, 5, 6)
      if (num == 3 || num == 4 || num == 5 || num == 6) {
        ellipse(x+paddedSize*3/4, y+paddedSize/4, dotSize, dotSize);
        ellipse(x+paddedSize/4, y+paddedSize*3/4, dotSize, dotSize);
      }
      //Midde Left & Right (6)
      if (num == 6) {
        ellipse(x+paddedSize/4, y+paddedSize/2, dotSize, dotSize);
        ellipse(x+paddedSize*3/4, y+paddedSize/2, dotSize, dotSize);
      }
      //Reset Drawing stuff
      fill(255);
      stroke(255);
    }
  }
}
