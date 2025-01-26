"""
1.第5章6 紙の書類から文字を取り出す
2.ファイル名:5_6_1.py
3.作成日:2021-9-12
4.バージョン:001 
5.利用するシチュエーション
　紙のデータから文字情報を取り出してデジタル化したい
6.できること:紙の文字を認識してテキストとして出力する
7.入力用データファイル:画像ファイル
8.出力用データファイル:テキストファイル
9.その他 以下のインストールが必要
conda install -c conda-forge pytesseract
brew install tesseract
/opt/homebrew/Cellar/tesseract/4.1.1/share/tessdata
"""
from PIL import Image
import pytesseract
# WindowsとMacでパスを切り替える
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'
# pytesseract.pytesseract.tesseract_cmd = r'/usr/local/Cellar/tesseract/4.1.1/bin/tesseract'
# 変換するpngファイルを指定して文字を取り出す
result = pytesseract.image_to_string(Image.open('IMG_7500.png'), lang='jpn')
# 半角スペースを取る
result = result.replace(" ", "")
# テキストファイルに書き出す
with open("result.txt", "w", encoding="utf_8") as file:
    file.write(result)
