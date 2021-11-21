class WordItem{
  PVector position;
  int letterID;
  float zPos;
  boolean once = true;
  
  
  WordItem(PVector position, float zPos, int letterID){
     this.position = position; 
    this.letterID = letterID;
    this.zPos = zPos;
  }

  void drawLetter(){
    text(letterID, position.x, position.y);
  }
  
  void updateLetter(){
    if(once){doOnce();}
    drawLetter();
  }
    
    void doOnce(){
      textSize(60);
      
      once = false;
    }


}
