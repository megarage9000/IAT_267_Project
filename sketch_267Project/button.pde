//Class for creating button objects

class Button{
  
  PVector pos = new PVector(0,0);
  PImage img, cimg, renderImg;
  boolean Hit = false;
  float l,w;
  
  
  //placeholder constructor before we use images
  Button(float x,float y,float l,float w){
    pos.x = x;
    pos.y = y;
    this.l = l;
    this.w = w;
  }
  
  // real constructor once we have images
  
  Button(PImage img, float x, float y, PImage cimg){
    pos.x = x;
    pos.y = y;
    this.img = img;
    this.cimg = cimg;
    renderImg = img;
  }
  
  
  void update(){
    render();
  }
  
  void render(){
    //Center coordinates to image
    pushMatrix();
    translate(pos.x, pos.y);
    image(renderImg, -renderImg.width/2, -renderImg.height/2, renderImg.width, renderImg.height);
    popMatrix();
  }
  
  //Changes rendered button if clicked
  void clicked(int i){
    if(i == 0) renderImg = img;
    if(i == 1) renderImg = cimg;
  }
  
}

//-----Class End

//-----Button hit Detection
boolean overImg(Button b){
  int left  = (int)b.pos.x - b.img.width/2;
  int right = (int)b.pos.x + b.img.width/2;
  int top   = (int)b.pos.y - b.img.height/2;
  int bot   = (int)b.pos.y + b.img.height/2;
  if(mouseX >= left && mouseX <= right &&
     mouseY >= top && mouseY <= bot){
       return true;
     }
  return false;
}
