from flask import Flask , request ,render_template
import PIL.Image as Image
import base64
import io
import time
from getcaption import NeuraIC

app = Flask(__name__)

@app.route('/',methods=['GET','POST'])
def home():
    return render_template('form.html')

@app.route('/getCaption',methods=['POST'])
def getCaption():
    encodedImage = request.form['image']
    decodedImage = base64.b64decode(encodedImage)
    image = Image.open(io.BytesIO(decodedImage))
    return NeuraIC(image)

if __name__ == '__main__':
    app.run(debug=True)