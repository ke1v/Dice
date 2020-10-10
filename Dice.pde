ArrayList<Die> dice = new ArrayList<Die>();
int count = 0, maxCount = 156, dieSize = 50, total = 0, displaySize = 650, displayX = 25, displayY = 25, padding = 10;

void setup() {
  size(700, 700);
  background(0);
  stroke(255);
  strokeWeight(10);
  noLoop();
} 

void draw() {
  background(0);
  textSize(24);
  text("# of Dice: " + count, 275, 650);
  text("Total: " + total, 275, 680);
  for (int i = 0; i < dice.size(); i++) {
    dice.get(i).show();
  }
}

void updateDice() {
    //Update count
    count = dice.size();
    //Recalculate Total
    total = 0;
    //Loop thru dice
    for (int i = 0; i < dice.size(); i++) {
        //Reroll
        total += dice.get(i).num;
    }
}

void rerollDice() {
    //Reset Total
    total = 0;
    //Loop thru dice
    for (int i = 0; i < dice.size(); i++) {
	    //Reroll
	    total += dice.get(i).roll();
	    //Redraw
	    dice.get(i).show();
    }
}

void mousePressed()
{
  rerollDice();
  redraw();
}
void keyPressed() {
  //Increment & Decrements Die.count
  if (key == CODED) {
    if (keyCode == UP && count < maxCount) {
      //Calculate x & y
      int x = (dieSize*count) % displaySize + displayX;
      int y = (int) (Math.floor(dieSize * count / displaySize) * dieSize + displayY);
      dice.add(new Die(x, y));
      updateDice();
      //System.out.println("User pressed up arrow");
    } else if (keyCode == DOWN && count > 0) {
      dice.remove(dice.size()-1);
      updateDice();
      //System.out.println("User pressed down arrow");
    }
  }
  //Updates the display
  redraw();
}
