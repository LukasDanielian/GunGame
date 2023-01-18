//Imports
import processing.net.*;
import com.jogamp.newt.opengl.GLWindow;

//Variables
Client client;
Camera cam;
GLWindow r;
PVector view;
float sensitivity;
boolean[] keys;
boolean mouseLock;
PVector oldMouse;
int offsetX = 0;
int offsetY = 0;
float speed = 5;
float roomHeight = 1000;
float roomWidth = 2000;
float enemyX, enemyZ;
int health;
int enemyHealth;
boolean imDead, otherDead;
int kills;
int deathTimer = 144 * 3;

void setup()
{
  //Settings
  //fullScreen(P3D);
  size(1000, 500, P3D);
  shapeMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  frameRate(144);

  //Setup
  client = new Client(this, "127.0.0.1", 1234);
  cam = new Camera(roomWidth, roomHeight);
  r=(GLWindow)surface.getNative();
  keys = new boolean[256];
  oldMouse = new PVector(mouseX, mouseY);
  sensitivity = .001;
  lockMouse();
  health = 100;
  enemyHealth = 100;
}

void draw()
{
  background(0);

  //If Alive
  if (!imDead)
  {
    //Mouse and lighting
    updateMouse();
    spotLight(100, 100, 100, -cam.x, -cam.y, -cam.z, -view.x, -view.y, -view.z, PI/2, 1);
    spotLight(255, 255, 255, 0, -height, 0, 0, 1, 0, PI/2, 1);

    //Render room
    pushMatrix();
    fill(255);
    noStroke();
    translate(roomWidth/2, roomHeight/2, 0);
    box(roomWidth * 2, roomHeight, roomWidth);
    popMatrix();

    //This Player
    translate(-cam.x, -cam.y, -cam.z);
    movement();
    checkBounds();
    hitScan();
    
    //OtherPlayer
    if (!otherDead)
    {
      enemyRender();
      renderOnTop();
    }

    //Check Death
    if (health <= 0)
    {
      imDead = true;
      sendData("Dead", new String[]{});
    }

    //Hud effects
    render2D();
  }

  //If Dead
  else
  {
    //Display
    textAlign(CENTER, CENTER);
    textSize(50);
    fill(255);
    pushMatrix();
    hint(DISABLE_DEPTH_TEST);
    camera();
    ortho();
    text("DEAD\nRespawn In " + ((int)(deathTimer / 144)+ 1), width/2, height * .25);
    hint(ENABLE_DEPTH_TEST);
    popMatrix();

    deathTimer--;

    //Respawn
    if (deathTimer <= 0)
    {
      health = 100;
      imDead = false;
      deathTimer = 144 * 3;
      cam = new Camera(roomWidth, roomHeight);
      sendData("Alive", new String[]{});
    }
  }

  //Networking
  sendData("Stats", new String[]{-cam.x + "", -cam.z + "", health + ""});
  recieveData();
}
