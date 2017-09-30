
//キャリブレーションはあくまで推定するだけなので，別の音源を登録する機能はありません
//登録する場合はコードを直接編集してください

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioInput mic_in;
FFT fft;

PImage background_img;
int mode = 0;
int max_hz_num = -1;
float max_hz_value = 0.0;
int sum_hz_value = 0;

void setup() {
  size(1280, 720);
  background_img = loadImage("pig.png");

  minim = new Minim(this);
  mic_in = minim.getLineIn(Minim.MONO, 512);
  fft = new FFT(mic_in.bufferSize(), mic_in.sampleRate());

  println("--------------------------");
  println("Sampling rate: " +mic_in.sampleRate());
  println("Buffer size: " +mic_in.bufferSize());
  println("Bandwidth:  = "+"mic_in.sampleRate()/mic_in.bufferSize() = "+fft.getBandWidth());
  println("--------------------------");
}

void draw() {
  image(background_img, 0, 0);
  
  if (mode==1 || mode==2) {
    
    //最も値が高い周波数を検知
    fft.forward(mic_in.mix);
    for (int i=0; i<20; i++) {
      if (fft.getBand(i)>10 && fft.getBand(i)>max_hz_value) {
        max_hz_value = fft.getBand(i);
        max_hz_num = i;
      }
    }

    //最も高い周波数に合わせた識別
    if (max_hz_num>=0) {
      if (max_hz_num<10) {
        println("最大"+max_hz_num);
        println("でかぶた");
      } else if (max_hz_num>=0 && max_hz_num>=10) {
        println("最大"+max_hz_num);
        println("こぶた");
      }
    }

    //音声波形の描画
    for (int i = 0; i < mic_in.mix.size ()-1; i++) {
      strokeWeight(10);
      stroke(0);
      point(i*2.5, height/2 + mic_in.mix.get(i)*200);
    }

    //説明文
    fill(0);
    textSize(50);
    textAlign(LEFT);
    text("Calibration "+mode, 10, 50);
    if (max_hz_num>=0) {
      text("Hz = "+max_hz_num*86, 400, 50);
    }
  } else if (mode==3) {
    
    //最も値が高い周波数を検知
    fft.forward(mic_in.mix);
    for (int i=0; i<20; i++) {
      if (fft.getBand(i)>10 && fft.getBand(i)>max_hz_value) {
        max_hz_value = fft.getBand(i);
        max_hz_num = i;
      }
    }

    //最も高い周波数に合わせた識別
    if (max_hz_num>=0) {
      if (max_hz_num<10) {

        //識別結果描画
        fill(0);
        textSize(50);
        textAlign(LEFT);
        text("Recognition: Big Pig", 10, 50);
      } else if (max_hz_num>=0 && max_hz_num>=10) {

        //識別結果描画
        fill(0);
        textSize(50);
        textAlign(LEFT);
        text("Recognition: Small Pig", 10, 50);
      }
    } else {

      //識別結果描画
      fill(0);
      textSize(50);
      textAlign(LEFT);
      text("Recognition: None", 10, 50);
    }
  } else if (mode==4) {

    //最も値が高い周波数を検知
    fft.forward(mic_in.mix);
    for (int i=0; i<20; i++) {
      if (fft.getBand(i)>10 && fft.getBand(i)>max_hz_value) {
        max_hz_value = fft.getBand(i);
        max_hz_num = i;
      }
    }

    //音別のタイマー加算
    if (max_hz_num>=0) {
      if (max_hz_num<10) {
        sum_hz_value += 10;
      } else if (max_hz_num>=10) {
        sum_hz_value += 1;
      }
      max_hz_value = 0;
      max_hz_num = -1;
    }
    
    //タイマーカウントダウン
    if (sum_hz_value>0 && frameCount%60==0) {
      sum_hz_value--;
    }

    //タイマー描画
    fill(0);
    textSize(100);
    textAlign(CENTER);
    text(int(sum_hz_value/60)+":"+sum_hz_value%60, width/2, height/2-200);
    
  }

  //モード描画
  fill(0);
  textSize(100);
  textAlign(CENTER);
  text("Mode: "+mode, width/2, height-50);
}

void keyPressed() {
  if (key == '1') {
    mode = 1;
    max_hz_num = -1;
    max_hz_value = 0.0;
  } else if (key == '2') {
    mode = 2;
    max_hz_num = -1;
    max_hz_value = 0.0;
  } else if (key == '3') {
    mode = 3;
    max_hz_num = -1;
    max_hz_value = 0.0;
  } else if (key == '4') {
    mode = 4;
    max_hz_num = -1;
    max_hz_value = 0.0;
  }
}

void stop() {
  mic_in.close();
  minim.stop();
  super.stop();
}
