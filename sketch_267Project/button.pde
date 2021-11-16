//Class for creating button objects

class button{
  
  PVector pos = new PVector(0,0);
  PImage img;
  boolean Hit = false;
  
  
  //placeholder constructor before we use images
  button(float x,float y,float l,float w){
    
  }
  
  /* real constructor once we have images
  
  button(PImage img, float x, float y){
    pos.x = x;
    pos.y = y;
    this.img = img;
  }
  
  */
  
  void update(){
    render();
  }
  
  void render(){
    //Center coordinates to image
    pushMatrix();
    translate(pos.x, pos.y);
    image(img, -img.width/2, -img.height/2, img.width, img.height);
    popMatrix();
  }
  
}
