//Sends data to client
void sendData(String tag, String[] data)
{
  server.write(tag + "/" + join(data, "/") + "\n");
}

//Grabs data from client
void recieveData()
{
  Client client = server.available();

  if (client != null)
  {
    String recieved = client.readString();
    recieved = recieved.substring(0, recieved.indexOf("\n"));

    //If recieved data
    if (recieved != null) {

      String[] data = split(recieved, "/");

      //Enemy stats
      if (data[0].equals("Stats"))
      {
        enemyX = float(data[1]);
        enemyZ = float(data[2]);
        enemyHealth = int(data[3]);
      }
      
      //Got Hit
      else if(data[0].equals("Hit"))
        health--;
      
      //Other Player Died
      else if(data[0].equals("Dead"))
      {
        otherDead = true;
        kills++;
      }
      
      //Other Player Alive
      else if(data[0].equals("Alive"))
        otherDead = false;
    }
  }
}
