//Locks mouse into place
void lockMouse() 
{
  if (!mouseLock) 
  {
    oldMouse = new PVector(mouseX, mouseY);
    offsetX = mouseX - width/2;
    offsetY = mouseY - height/2;
  }
  
  mouseLock = true;
}

//unlocks mouse
void unlockMouse() 
{
  if (mouseLock) 
    r.warpPointer((int) oldMouse.x, (int) oldMouse.y);
    
  mouseLock = false;
}

//Key down
void keyPressed()
{
  if (keyCode >= 0 && keyCode < 256)
    keys[keyCode] = true;
    
  if(key == 'p')
  {
    if(mouseLock)
      unlockMouse();
      
    else
      lockMouse();
  }
}

//Key up
void keyReleased() 
{
  if (keyCode >= 0 && keyCode < 256)
    keys[keyCode] = false;
}

//Grabs key
boolean keyDown(int key) 
{
  return keys[key];
}

//Updates mouse information
void updateMouse()
{
  // mouse shenanigans
  if (!focused && mouseLock) 
    unlockMouse();
  
  //Bound
  if (mouseLock) 
  {
    cam.yaw += (mouseX-offsetX-width/2.0)*sensitivity;
    cam.pitch -= (mouseY-offsetY-height/2.0)*sensitivity;
    r.setPointerVisible(false); //When locked and trying to move, the pointer jerks all over the place, so best to hide it.
    r.warpPointer(width/2, height/2); //Move it to the exact center of the sketch window.
    r.confinePointer(true); //Locks pointer inside of the sketch's window so it doesn't escape.
  }
  
  //Not bound
  else 
  {
    r.confinePointer(false);
    r.setPointerVisible(true);
  }
  
  offsetX=offsetY=0;
  cam.pitch = constrain(cam.pitch, -HALF_PI + 0.0001, HALF_PI- .0001); // glitchyness near 90 degrees
  cam.apply(g, 3);
  view = cam.getViewDirection();
}
