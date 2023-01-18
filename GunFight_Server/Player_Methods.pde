//Calculates player position
void movement()
{
  if (keyPressed)
  {
    if (keyDown('W'))
    {
      cam.x += view.x * speed;
      cam.z += view.z * speed;
    }
    if (keyDown('S'))
    {
      cam.x -= view.x * speed;
      cam.z -= view.z * speed;
    }
    if (keyDown('A'))
    {
      cam.x += cos(cam.yaw - PI/2) * cos(cam.pitch) * speed * 2;
      cam.z += sin(cam.yaw - PI/2) * cos(cam.pitch) * speed * 2;
    }
    if (keyDown('D'))
    {
      cam.x -= cos(cam.yaw - PI/2) * cos(cam.pitch) * 10;
      cam.z -= sin(cam.yaw - PI/2) * cos(cam.pitch) * 10;
    }
  }
}

//Insures player is in bounds
void checkBounds()
{
  if (cam.x <= roomWidth * -1.5 + 50)
    cam.x = roomWidth * -1.5 + 50;
    
  if (cam.x > roomWidth/2 - 50)
    cam.x = roomWidth/2 - 50;
    
  if (cam.z >= roomWidth/2 - 50)
    cam.z = roomWidth/2 - 50;

  if (cam.z < -roomWidth/2 + 50)
    cam.z = -roomWidth/2 + 50;
}

//Renders enemy player
void enemyRender()
{
  pushMatrix();
  noStroke();
  fill(255, 0, 0);
  translate(enemyX + cam.x, 0, enemyZ + cam.z);
  sphere(100);
  popMatrix();
}

//Renders Health Bar
void renderOnTop()
{
  pushMatrix();
  translate(enemyX + cam.x, 0, enemyZ + cam.z);
  translate(0, -100-100*.2, 0);
  fill(map(enemyHealth, 100, 0, 175, 255), map(enemyHealth, 100, 50, 255, 0), 0);
  rotateY(-cam.yaw + HALF_PI);
  rotateX(-cam.pitch);
  rectMode(CORNER);
  rect(-100, -15, enemyHealth * 2, 30);
  rectMode(CENTER);
  noFill();
  stroke(0);
  strokeWeight(2);
  rect(0, 0, 200, 30);
  popMatrix();
}
