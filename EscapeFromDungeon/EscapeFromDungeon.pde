PImage background0, background1, background2, start_screen, death_screen, win_screen;
PImage heart_full, heart_empty;
PImage key_full, key_empty;
PImage chest_closed, chest_open;

int level = -1;
int life = 3;
int hasKey = 0;
int counter = 0;

boolean keyLeft, keyRight, keyUp, keyDown;

int xPos = 400;
int yPos = 450;
int xPosN;
int yPosN;
int pSpeed = 2;
int pH = 35;
int pW = 35;
int pDirection = 1;
int pD = 1;
int playerSize = 35;

PImage[] walking = new PImage[24];
PImage[] standing = new PImage[24];
PImage[] walkingL = new PImage[24];
PImage[] standingL = new PImage[24];
PImage[] wizard = new PImage[24];
PImage[] monster = new PImage[24];
boolean isWalking = false;

// monster variables
int mX = 600;
int mY = 300;
PImage fireball;
ArrayList<Integer> fireballsX = new ArrayList<Integer>();
ArrayList<Integer> fireballsY = new ArrayList<Integer>();
int hit1, hit2;
int mSpeed = 5;

// cloud variables
PImage clouds;
PImage raindrop;
ArrayList<Integer> raindropsX = new ArrayList<Integer>();
ArrayList<Integer> raindropsY = new ArrayList<Integer>();
int fhit1, fhit2;
int fSpeed = 7;

PImage sb;
PImage chest;


void setup(){
  size(800, 600);
  background0 = loadImage("bg0.png");
  background1 = loadImage("bg1.png");
  background2 = loadImage("bg2.png");
  start_screen = loadImage("start.png");
  death_screen = loadImage("death_screen.png");
  win_screen = loadImage("win_screen.png");
  sb = loadImage("speech_box.png");
  fireball = loadImage("fireball.png");
  clouds = loadImage("clouds.png");
  raindrop = loadImage("raindrop.png");
  heart_full = loadImage("heart_full.png");
  heart_empty = loadImage("heart_empty.png");
  key_full = loadImage("key_full.png");
  key_empty = loadImage("key_empty.png");
  chest_closed = loadImage("ch1.png");
  chest_open = loadImage("ch2.png");
  
  // load images into the walking array 
  for (int i=0; i < 4; i++) {
    for (int j=0; j < 6; j++) {
      walking[(6*i)+(j)] = loadImage("w" + (i+1) + ".png");
    }
  }
  // load images into the standing array 
  for (int i=0; i < 4; i++) {
    for (int j=0; j < 6; j++) {
      standing[(6*i)+(j)] = loadImage("i" + (i+1) + ".png");
    }
  }
  // load images into the walkingL array 
  for (int i=0; i < 4; i++) {
    for (int j=0; j < 6; j++) {
      walkingL[(6*i)+(j)] = loadImage("lw" + (i+1) + ".png");
    }
  }
  // load images into the standingL array 
  for (int i=0; i < 4; i++) {
    for (int j=0; j < 6; j++) {
      standingL[(6*i)+(j)] = loadImage("li" + (i+1) + ".png");
    }
  }
  // load images into the wizard array 
  for (int i=0; i < 4; i++) {
    for (int j=0; j < 6; j++) {
      wizard[(6*i)+(j)] = loadImage("wi" + (i+1) + ".png");
    }
  }
  // load images into the monster array 
  for (int i=0; i < 4; i++) {
    for (int j=0; j < 6; j++) {
      monster[(6*i)+(j)] = loadImage("m" + (i+1) + ".png");
    }
  }
}

void draw(){  
  imageMode(CENTER);
  xPosN = xPos;
  yPosN = yPos;
  
  if (level == 0) level_0();
  if (level == 1) level_1();
  if (level == 2) level_2();
  if (level == 3) level_3();
  if (level == 4) level_4();
  if (level == 5) level_3();
  if (level == 6) level_2();
  if (level == 7) level_1();
  if (level == 8) level_0();

  counter ++;
  if (counter>23) counter = 0;

  if (pDirection == 1){
    if (isWalking) image(walking[counter], xPos, yPos);
    else image(standing[counter], xPos, yPos);
  }
  else if (pDirection == 3){
    if (isWalking) image(walkingL[counter], xPos, yPos);
    else image(standingL[counter], xPos, yPos);
  }
  
  if (life == 3) {
    image(heart_full, 25, 580);
    image(heart_full, 75, 580);
    image(heart_full, 125, 580);
  }
  else if (life == 2) {
    image(heart_full, 25, 580);
    image(heart_full, 75, 580);
    image(heart_empty, 125, 580);
  }
  else if (life == 1) {
    image(heart_full, 25, 580);
    image(heart_empty, 75, 580);
    image(heart_empty, 125, 580);
  }
  else if (life <= 0) {
    image(heart_empty, 25, 580);
    image(heart_empty, 75, 580);
    image(heart_empty, 125, 580);
  }
  
  if (hasKey == 0) image(key_empty, 700, 575);
  else if (hasKey == 1) image(key_full, 700, 575);
  
  if (level == -1) start_screen();
  if (life <= 0) death_screen();
  if (level == -2) win_screen();
}

void control(){
  if (keyRight == true) xPosN = xPos + pSpeed;
  if (keyLeft == true) xPosN = xPos - pSpeed;
  if (keyUp == true) yPosN = yPos - pSpeed;
  if (keyDown == true) yPosN = yPos + pSpeed;
}

void moveX() {
  xPos=constrain(xPosN, 50, 740);
}
void moveY() {
  yPos=constrain(yPosN, 50, 520);
}

void start_screen(){
  image(start_screen, width/2, height/2);
  if (mousePressed == true && mouseX > 309 && mouseX < 490 && mouseY > 300 && mouseY < 375) level = 0;
}

void death_screen(){
  image(death_screen, width/2, height/2);
  if (mousePressed == true && mouseX > 309 && mouseX < 490 && mouseY > 300 && mouseY < 375) { level = 0; life = 3; hasKey = 0;}
}

void win_screen(){
  image(win_screen, width/2, height/2);
  if (mousePressed == true && mouseX > 309 && mouseX < 490 && mouseY > 300 && mouseY < 375) { level = 0; life = 3; hasKey = 0;}
}

void level_0(){
  image(background0, width/2, height/2);
  if (keyPressed) control();
  moveX();
  moveY();
  image(wizard[counter], 100, 250);
  
  if (xPos < 120 && xPos > 90 && yPos > 240 && yPos < 270) {
    image(sb, 400, 220);
    fill(255);
    textSize(15);
    textAlign(CENTER);
    text("Zindandan çıkmak için aşağıdaki kapıyı kullan.\nİhtiyacın olan şeyleri diğer odalarda bulabilirsin.", 400, 210);
  }
  
  if (xPos > 389 && xPos < 441 && yPos < 521 && yPos > 389 && hasKey == 1) {
    if (keyPressed) {
      if (key == ' ') {
        level = -2;
      }
    }
  }
  
  if (xPos > 650 && xPos < 700 && yPos < 270 && yPos > 220) {
    if (keyPressed) {
      if (key == ' ') {
        xPosN = 100;
        yPosN = 100;
        level = 1;
      }
    }
  }
}


void level_1(){
  image(background1, width/2, height/2);
  for (int i = 0; i < 2; i++){
    moveX();
    moveY();
  }
  fill(255, 0, 0);
  noStroke();
  rect(150, 50, 500, 20);
  rect(150, 70, 20, 200);
  rect(170, 250, 75, 20);
  rect(225, 190, 20, 60);
  rect(225, 170, 80, 20);
  rect(285, 130, 20, 40);
  rect(150, 330, 145, 20);
  rect(295, 260, 20, 90);
  rect(315, 260, 60, 20);
  rect(355, 130, 20, 130);
  rect(375, 130, 75, 20);
  rect(430, 150, 20, 180);
  rect(380, 330, 70, 20);
  rect(450, 185, 60, 20);
  rect(505, 70, 20, 60);
  rect(525, 110, 60, 20);
  rect(565, 130, 20, 60);
  rect(630, 70, 20, 220);
  rect(520, 270, 110, 20);
  rect(500, 270, 20, 140);
  rect(520, 390, 65, 20);
  rect(565, 350, 20, 40);
  rect(630, 350, 20, 180);
  rect(150, 530, 500, 20);
  rect(150, 350, 20, 180);
  rect(170, 405, 55, 20);
  rect(285, 420, 20, 110);
  rect(285, 405, 160, 20);
  rect(425, 420, 20, 65);
  rect(370, 465, 55, 20);
  rect(495, 480, 20, 50);
  
  // player can move if the next pixel in the heading direction is not red
  if (keyPressed) control();
  if (pD == 0) {
    if (get(xPos, yPos-20) != -65536) {
      moveY();
    }
  }
  if (pD == 1) {
    if ((get(xPos+20, yPos) != -65536) && (get(xPos+20, yPos+5) != -65536) && (get(xPos+20, yPos - 5) != -65536)) {
      moveX();
    }
  }
  if (pD == 2) {
    if (get(xPos, yPos+40) != -65536) {
      moveY();
    }
  }
  if (pD == 3) {
    if (get(xPos-20, yPos) != -65536) {
      moveX();
    }
  }
  
  // going down
  if (xPos > 700 && xPos < 750 && yPos < 320 && yPos > 270) {
    if (keyPressed) {
      if (key == ' ') {
        xPosN = 100;
        yPosN = 100;
        level = 2;
      }
    }
  }
  // going up
  if (xPos > 65 && xPos < 125 && yPos < 55 && yPos > 45) {
    if (keyPressed) {
      if (key == ' ') {
        level = 8;
        xPosN = 725;
        yPosN = 250;
      }
    }
  }
}

void level_2(){
  image(background1, width/2, height/2);
  if (keyPressed) control();
  moveX();
  moveY();
  image(monster[counter], mX, mY);
  mY = mY + mSpeed;
  
  if (mY > 499) { mSpeed = (-1) * mSpeed; }
  if (mY < 99) { mSpeed = (-1) * mSpeed; }
  
  if (frameCount % floor(random(30, 90)) == 0) {
    fireballsX.add(mX);
    fireballsY.add(mY);
  } 
  
  for (int i = 0; i < fireballsX.size(); i++) {
    
    image(fireball, fireballsX.get(i), fireballsY.get(i));
    if (hit2 - hit1 > 60) {
      if(dist(xPos, yPos, fireballsX.get(i), fireballsY.get(i))<30){
        hit1 = frameCount;
        life --;
      }
      if(dist(xPos, yPos, mX, mY)<60){
        hit1 = frameCount;
        life --;
      }
    }
    
    fireballsX.set(i, fireballsX.get(i)-5);
    hit2 = frameCount;
  }
  
  if (fireballsX.size() > 0 && fireballsX.get(0) < 150){
    fireballsX.remove(0);
    fireballsY.remove(0);
  }
  
  // going down
  if (xPos > 700 && xPos < 750 && yPos < 320 && yPos > 270) {
    if (keyPressed) {
      if (key == ' ') {
        xPosN = 100;
        yPosN = 100;
        level = 3;
      }
    }
  }
  // going up
  if (xPos > 65 && xPos < 125 && yPos < 55 && yPos > 45) {
    if (keyPressed) {
      if (key == ' ') {
        level = 7;
        xPosN = 725;
        yPosN = 250;
      }
    }
  }
}

void level_3(){
  image(background1, width/2, height/2);
  if (keyPressed) control();
  moveX();
  moveY();
  image(clouds, 415, 50);
  if (frameCount % floor(random(15, 30)) == 0) {
    raindropsX.add(floor(random(150, 670)));
    raindropsY.add(50);
  } 
  
  for (int i = 0; i < raindropsX.size(); i++) {
    image(raindrop, raindropsX.get(i), raindropsY.get(i));
    if (fhit2 - fhit1 > 30) {
      if(dist(xPos, yPos, raindropsX.get(i), raindropsY.get(i))<30){
        fhit1 = frameCount;
        life --;
      }
    }
    
    raindropsY.set(i, raindropsY.get(i)+fSpeed);
    fhit2 = frameCount;
    textSize(100);
  }
  
  if (raindropsX.size() > 0 && raindropsY.get(0) > 530){
    raindropsX.remove(0);
    raindropsY.remove(0);
  }
  // going down
  if (xPos > 700 && xPos < 750 && yPos < 320 && yPos > 270) {
    if (keyPressed) {
      if (key == ' ') {
        xPosN = 100;
        yPosN = 100;
        level = 4;
      }
    }
  }
  // going up
  if (xPos > 65 && xPos < 125 && yPos < 55 && yPos > 45) {
    if (keyPressed) {
      if (key == ' ') {
        level = 6;
        xPosN = 725;
        yPosN = 250;
      }
    }
  }
}

void level_4(){
  image(background2, width/2, height/2);
  if (keyPressed) control();
  moveX();
  moveY();
  
  if (xPos > 375 && xPos < 425 && yPos < 300 && yPos > 240) {
    if (keyPressed) {
      if (key == ' ') {
        hasKey = 1;
      }
    }
  }
  if (hasKey == 0) {
    image(chest_closed, 400, 300);
  }
  else if (hasKey == 1) {
    image(chest_open, 400, 300);
  }

  
  // going up
  if (xPos > 65 && xPos < 125 && yPos < 55 && yPos > 45) {
    if (keyPressed) {
      if (key == ' ') {
        level = 5;
        xPosN = 725;
        yPosN = 250;
      }
    }
  }
}

void keyPressed(){
  if (keyCode == UP){
    keyUp = true;
    pD = 0;
    isWalking = true;
  }
  if (keyCode == RIGHT){
    keyRight = true; 
    pDirection = 1;
    pD = 1;
    isWalking = true;
  }
  if(keyCode == DOWN){
    keyDown = true;  
    pD = 2;
    isWalking = true;
  }
  if(keyCode == LEFT){
    keyLeft = true;  
    pDirection = 3;
    pD = 3;
    isWalking = true;
  }
}

void keyReleased(){
  if (keyCode == LEFT) { keyLeft = false; isWalking = false; pDirection = 3;}
  if (keyCode == RIGHT) { keyRight = false; isWalking = false; pDirection = 1;}
  if (keyCode == UP) { keyUp = false; isWalking = false; }
  if (keyCode == DOWN) { keyDown = false; isWalking = false; }
}
