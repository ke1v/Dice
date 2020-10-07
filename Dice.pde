// identical use to setup in Processing IDE except for size()
public void setup(){
    size(700, 700);
	background(0);
	stroke(255);
	strokeWeight(10);
	noLoop();
}

public void mousePressed() {
	redraw();
	//Reroll All Dice
	Die.rerollAll();
}

// identical use to draw in Prcessing IDE
public void draw(){
	background(0);
	textSize(24);
    text("# of Dice: " + String.valueOf(Die.count), 275, 650);
    text("Total: " + String.valueOf(Die.total), 275, 680);
    for (int i = 0; i < Die.dice.size(); i++) {
    	Die.dice.get(i).show();
    }
}

public void keyPressed() {
	//Increment & Decrements Die.count
	if (key == CODED) {
		if (keyCode == UP && Die.count < 156) {
			//Calculate x & y
			int x = (Die.size*Die.count) % Die.displaySize + Die.displayX;
			int y = (int) (Math.floor(Die.size * Die.count / Die.displaySize) * Die.size + Die.displayY);
			new Die(this, x, y);
			//System.out.println("User pressed up arrow");
		} else if (keyCode == DOWN && Die.count > 0) {
			Die.dice.remove(Die.dice.size()-1);
			Die.updateDice();
			//System.out.println("User pressed down arrow");
		}
	} else if (key == BACKSPACE) {
		//Removes last digit in Die.count
		int newCount = Die.count/10;
		for (; Die.count > newCount;) {
			Die.dice.remove(Die.dice.size()-1);
			Die.updateDice();
		}
		//System.out.println("User pressed backspace");
	} else {
		try {
			int newCount = Math.min(Die.count*10+Integer.parseInt(String.valueOf(key)), 156);
    		for (; Die.count < newCount;) {
    			//Calculate x & y
    			int x = (Die.size*Die.count) % Die.displaySize + Die.displayX;
    			int y = (int) (Math.floor(Die.size * Die.count / Die.displaySize) * Die.size + Die.displayY);
    			new Die(this, x, y);
    		}
			//System.out.println("User pressed " + key);
		} catch (NumberFormatException e) {
			//System.out.println("User pressed non-numeric key");
		}
	}
	//Updates the display
	redraw();
}

class Die {
	
	//Init. Vars
	public static List<Die> dice = new ArrayList<Die>();
	public static int count = 0, maxCount = 1, size = 50, total = 0, displaySize = 650, displayX = 18, displayY = 18, padding = 10;
	public int num;
	private static int paddedSize = size-padding;
	private float x, y;
	private PApplet parent;
	
	Die(PApplet parent, int x, int y) {
		this.x = x+padding;
		this.y = y+padding;
		this.parent = parent;
		dice.add(this);
		roll();
		updateDice();
		show();
	}
	
	public static void updateDice() {
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
	
	public static void rerollAll() {
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
	
	public int roll() {
		return num = (int)(Math.random() * 6) + 1;
	}
	
	public void show() {
		//Avoid divide by zero error
		if (count > 0) {
			//Calculate size
			int dotSize = size/7; //7 different "sections" in a die
			//Base Rectangle
			parent.rect(x, y, paddedSize, paddedSize, dotSize);
			//Dots
			parent.noStroke();
			parent.fill(0);
			//Middle Dot (shown when odd)
			if (num % 2 == 1) {
				parent.circle(x+paddedSize/2, y+paddedSize/2, dotSize);
			}
			//Top Left Dot & Bottom Right Dot (2, 4, 5, 6)
			if (num == 2 || num == 4 || num == 5 || num == 6) {
				parent.circle(x+paddedSize/4, y+paddedSize/4, dotSize);
				parent.circle(x+paddedSize*3/4, y+paddedSize*3/4, dotSize);
			}
			//Top Right Dot & Bottom Left Dot (3, 4, 5, 6)
			if (num == 3 || num == 4 || num == 5 || num == 6) {
				parent.circle(x+paddedSize*3/4, y+paddedSize/4, dotSize);
				parent.circle(x+paddedSize/4, y+paddedSize*3/4, dotSize);
			}
			//Midde Left & Right (6)
			if (num == 6) {
				parent.circle(x+paddedSize/4, y+paddedSize/2, dotSize);
				parent.circle(x+paddedSize*3/4, y+paddedSize/2, dotSize);
			}
			//Reset Drawing stuff
			parent.fill(255);
	    	parent.stroke(255);
		}
	}
}
