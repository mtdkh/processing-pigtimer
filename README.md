# processing-pigtimer

## Description
PigTimer is a timer for ramen, and the timer uses pigs to adjust set time  
[YouTube動画](https://youtu.be/Z8DOZ3PvtQU)  

## Requirement
* Processing ver2.2.1
* Processing Library Minim

## Usage

### Change mode
モードはキーボードの1〜4を押すと切り替え可能  
※キャリブレーションの登録はコードを直接変える必要があります（max_hz_num辺り）  
* mode=0 標準画面（何もできません）
* mode=1 キャリブレーション1（音をキャリブレーションして，音域を推定します）
* mode=2 キャリブレーション2（mode=1と同じ，1と別の音を推定します）
* mode=3 認識（2つの音を認識して識別します）
* mode=4 タイマー（2つの音に応じてタイマーを設定します）

### 必要な環境
このコードを動作させるには、マイク等の音入力装置が必要です  

## License
MIT License  
