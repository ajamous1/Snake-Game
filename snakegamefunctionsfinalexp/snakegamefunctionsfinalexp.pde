PImage snake;
PImage greenS, blueS, yellowS, pinkS;
int n = 40;
int x, y;
int score;
int counter;
int headx, heady;
int applex=(round(random(20))+1)*40;
int appley=(round(random(20))+1)*40;
int snakex = 40;
int snakey = 40;
int snakeSize = 2;
int result;
int screen, selection;
color pink = color(238, 0, 255), blue = color(0, 38, 255), green = color(0, 255, 0), yellow = color(255, 238, 0);
color selected = (#ffffff);
ArrayList<Integer> tailx = new ArrayList<Integer>();
ArrayList<Integer> taily = new ArrayList<Integer>();

boolean gameOver() {
  for (int i = 0; i < tailx.size(); i++) {
    if (x + 40 == tailx.get(i) && y + 40 == taily.get(i)) {
      println("ATE");
      return true;
    }
  }  


  return false;
}





boolean boundaryCheck() {
  if (x < 0 || x > 1240  || y < 0 || y > 920) {

    return false;
  } else
    return true;
} 

void customizePlayer() {
  background(0);
  if (selection > 3){
    selection = 0;
    
  } else if (selection < 0){
    selection = 3;
    
  }
  if(selection == 0){
  image(greenS, 0 ,0);
  selected = green;
  } else if (selection == 1){
  image(blueS, 0, 0);
  selected = blue;
    
  } else if (selection == 2){
   image(yellowS, 0, 0); 
   selected = yellow;
    
  } else if (selection == 3){
   image(pinkS, 0, 0); 
   selected = pink;
    
  }
  
}

void mainMenu() {
  background(0);
  fill(255);
  fill(0, 0, 255);
  rect(width/2 - 150, height/2 - 80, 300, 80, 25);
  textSize(50);
  textAlign(CENTER);
  fill(255);
  text("PLAY", width/2, height/2 - 25);
  image(snake, width/2 - 400, height/2 - 500, 800, 717);
  fill(selected);
  
}

void setup() {
  size(1280, 960);
  counter = 1000;
  headx = x + 40;
  heady = y + 40;
  snake = loadImage("snakegame.png");
  greenS = loadImage("snakegamegreen.png");
  blueS = loadImage("snakegameblue.png");
  yellowS = loadImage("snakegameyellow.png");
  pinkS = loadImage("snakegamepink.png");
  

  noStroke();
}
void apple() {
  fill(255, 0, 0);
  rect(applex, appley, 40, 40);
}
void draw() {
  
  background(0);
  

   
  if (screen == 0) {
    mainMenu();
  } else if (screen == 1) {
  customizePlayer();
    
    
    
    
  } else if (screen == 2) {


    drawPlayer();
    apple();
    interaction();
    gameOver();
    mechanics();
  }
  fill(selected);

}

void mechanics() {
  if (gameOver() == true) {
    snakeSize = 2;
    tailx.clear();
    taily.clear();
    result = 1;
    score = 0;
  } else {
    println("NO");
  }


  fill(255);
  rect(x + 40, y + 40, 40, 40);



  if (boundaryCheck() == false) {
    x = 0;
    y = height/2;
    score = 0;
  }
  if (keyCode == UP) {

    moveVertical(n);
  } else if (keyCode == DOWN) { 
    moveVertical(-n);
  } else if (keyCode == LEFT) {
    moveHorizontal(-n);
  } else if (keyCode == RIGHT) {
    moveHorizontal(n);
  }

  textSize(30);
  text("score " + score, 250, 30);
 
 
}

void drawPlayer() {
  fill(selected);
  for (int i = 0; i < tailx.size(); i++) {
    rect(tailx.get(i), taily.get(i), snakex, snakey);
  }
}
void moveHorizontal(int n) {
  if (counter > 0) {
    counter = counter - 100;
    headx = x + 40;
  } else if (counter == 0) {



    counter = 1000;
    tailx.add(x + 40);
    taily.add(y + 40);
    if (tailx.size() > snakeSize) {
      tailx.remove(0);
      taily.remove(0);
    }
    x = x + n;
  }
}

void moveVertical(int n) {
  heady = y + 40;
  if (counter > 0) {
    counter = counter - 100;
  } else if (counter == 0) {

    counter = 1000;

    tailx.add(x + 40);
    taily.add(y + 40);
    if (tailx.size() > snakeSize) {
      tailx.remove(0);
      taily.remove(0);
    }
    y = y - n;
  }
}

void interaction() {
  if (x + 40 == applex && y + 40 == appley) {
    applex=(round(random(20))+1)*40;
    appley=(round(random(20))+1)*40;
    snakeSize = snakeSize + 1;
    score = score + 1;
  }
}

void mousePressed() {
  if (screen == 0 && mouseX >= 490 && mouseX <= 790 && mouseY > 400 && mouseY < 480) {
    screen = 1;
  }
  //Player Customization function
   else if(screen == 1 && mouseX >= 410 && mouseX <= 445){
    selection = selection - 1;
  } else if (screen == 1 && mouseX >= 810 && mouseX < 845 && mouseY >= 360 && mouseY <= 400){
    selection = selection + 1;
    
  } else if(screen == 1 && mouseX >= 400 && mouseX <= 835 && mouseY >= 630 && mouseY <= 740){
    screen = 2;
    
  }
}
