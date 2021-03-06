

import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20; 
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
private int bombsMuch = 0;
private int clearBombs = 0;
private static int bombsWithin = 30;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int rows = 0; rows < buttons.length; rows++){
        for(int col = 0; col < buttons[rows].length; col++){
            buttons[rows][col] = new MSButton(rows,col);
        }
    }
    bombMuch=bombsWithin;
    while(bombsMuch>=1){
    setBombs();
    }
}
public void setBombs()
{
    while(bombs.size() < 20) 
    {
        int rowsBeta = (int)(Math.random()*NUM_ROWS);
        int colBeta = (int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[rowsBeta][colBeta]))
         bombs.add(buttons[rowsBeta][colBeta]);
    }
}

public void draw ()
{
    //if(isWon())
    //{
        //background( 0 );
        //displayWinningMessage();
    //}
   
}
public boolean isWon()
{
    for(MSButton[] row: buttons)
        for(MSButton x : row)
            if(buttons[row][x].isClicked()){
            clearBombs++;
           }
        }
     }
      if(clearBombs>=(NUM_ROWS*NUM_COLS)-bombsMuch){
            return true;    
        }
        clearBombs=0;
        return false;
}

public void displayLosingMessage()
{
     text("You Lose!", 200, 200);
     textSize(12);
     fill(0);
     textSize(12);
     for(int rowX = 0; rowX < NUM_ROWS; rowX++){
        for(int colY = 0; colY < NUM_COLS; colY++){
          buttons[rowX][colY].mousePressed();
          fill(255,0,0);
      }
    }
}
public void displayWinningMessage()
{
     text("You Win!", 300,300);
     textSize(12);
     noLoop();
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {

   
        if(keyPressed == false)
        {
            clicked=true;
            if(marked == false)
         if (countBombs(r,c) > 0)
        {
            fill(0);
            setLabel(""+countBombs(r,c));
        }
        else 
        {
            if(isValid(r,c+1) && buttons[r][c+1].isClicked()==false)
                buttons[r][c+1].mousePressed();
            if(isValid(r,c-1) && buttons[r][c-1].isClicked()==false)
                 buttons[r][c-1].mousePressed();
            if(isValid(r+1,c) && buttons[r+1][c].isClicked()==false)
                 buttons[r+1][c].mousePressed();
            if(isValid(r-1,c) && buttons[r-1][c].isClicked()==false)
                 buttons[r-1][c].mousePressed();
            if(isValid(r-1,c-1) && buttons[r-1][c-1].isClicked()==false)
                 buttons[r-1][c-1].mousePressed();
            if(isValid(r-1,c+1) && buttons[r-1][c+1].isClicked()==false)
                 buttons[r-1][c+1].mousePressed();
            if(isValid(r+1,c-1) && buttons[r+1][c-1].isClicked()==false)
                 buttons[r+1][c-1].mousePressed();
            if(isValid(r+1,c+1) && buttons[r+1][c+1].isClicked()==false)
                 buttons[r+1][c+1].mousePressed();
        }
       }else if(keyPressed==true){
            marked=!marked;
    }
}
    public void draw () 
    {    
        if (marked)
            fill(0);
         else if(clicked && bombs.contains(this)) {
             fill(255,0,0);
             displayLosingMessage();
         }
         else if(clicked) {
            fill( 200 );
            if(countBombs(r,c)>0){
                label = ""+(this.countBombs(r,c)); 
                text(label, x+width/2, y+ height/2);}
        }
         else if (isWon()){
            displayWinningMessage();
            noLoop();
            }
        else
        {
            fill( 100 );
        }
        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(c >= 0 && r>= 0 && c<=19 && r<=19 ) 
        {
            return true;
        }
        else 
        {
            return false;
        }
        
       
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(r,c+1)==true && bombs.contains(buttons[r][c+1]))
            numBombs++;
        if(isValid(r,c-1)==true && bombs.contains(buttons[r][c-1]))
            numBombs++;
        if(isValid(r+1,c)==true && bombs.contains(buttons[r+1][c]))
            numBombs++;
        if(isValid(r-1,c)==true && bombs.contains(buttons[r-1][c]))
            numBombs++;
        if(isValid(r-1,c-1)==true && bombs.contains(buttons[r-1][c-1]))
            numBombs++;
        if(isValid(r-1,c+1)==true && bombs.contains(buttons[r-1][c+1]))
            numBombs++;
        if(isValid(r+1,c-1)==true && bombs.contains(buttons[r+1][c-1]))
            numBombs++;
        if(isValid(r+1,c+1)==true && bombs.contains(buttons[r+1][c+1]))
            numBombs++;
        return numBombs;
    }
}



