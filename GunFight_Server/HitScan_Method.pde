//Calculates bullet paths and hit scan on enemys
void hitScan()
{
  if (mousePressed)
  {
    if (mouseButton == LEFT)
    {
      if (calculateCollision(new PVector(-cam.x, -cam.y, -cam.z), view, new PVector(enemyX, -cam.y, enemyZ), 100))
        sendData("Hit", new String[]{});
    }
  }
}

//Calculates the Ray sphere collision
boolean calculateCollision(PVector rayOrigin, PVector rayDirection, PVector sphereCenter, float sphereRadius)
{
  PVector sphereToRay = PVector.sub(sphereCenter, rayOrigin);
  float projection = PVector.dot(sphereToRay, rayDirection) / PVector.dot(rayDirection, rayDirection);
  PVector closestPointOnRay = PVector.add(rayOrigin, PVector.mult(rayDirection, projection));
  float distance = PVector.dist(closestPointOnRay, sphereCenter);

  return distance < sphereRadius;
}
