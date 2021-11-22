class WordItem{
  PVector position;
  int letterID;
  float zPos;
    
  WordItem(PVector position, float zPos, int letterID){
     this.position = position; 
    this.letterID = letterID;
    this.zPos = zPos;
  }

  void drawLetter(){
    text(letterID, position.x, position.y);
  }
  
  void updateLetter(){
      textSize(60);
    drawLetter();
  }
}
