//HUD Effects
void render2D()
{
  //Setup for flat
  pushMatrix();
  hint(DISABLE_DEPTH_TEST);
  rectMode(CENTER);
  camera();
  ortho();

  //Crosshair
  stroke(255, 0, 0);
  strokeWeight(3);
  line(width/2 - 7.5, height/2, width/2 + 7.5, height/2);
  line(width/2, height/2 - 7.5, width/2, height/2  + 7.5);
  noFill();
  strokeWeight(2);
  ellipse(width/2, height/2, 25, 25);

  //FPS counter
  textAlign(LEFT, TOP);
  fill(0);
  textSize(25);
  text("FPS: " + frameRate, 5, 5);
  
  //Kill Count
  textAlign(CENTER,CENTER);
  text("Kills: " + kills, width/2, height * .05);
  
  //Heath Bar
  fill(map(health, 100, 0, 175, 255), map(health, 100, 50, 255, 0), 0);
  rectMode(CORNER);
  rect(width/2-100, height * .95 -15, health * 2, 30);
  rectMode(CENTER);
  noFill();
  stroke(0);
  strokeWeight(2);
  rect(width/2, height * .95, 200, 30);
  
  //End flat
  hint(ENABLE_DEPTH_TEST);
  popMatrix();
}
