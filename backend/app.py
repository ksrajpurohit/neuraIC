from flask import Flask , request ,render_template
import PIL.Image as Image
import base64
import io
import time



app = Flask(__name__)

@app.route('/',methods=['GET','POST'])
def home():
    return render_template('form.html')

@app.route('/getCaption',methods=['POST'])
def getCaption():
    # this the base64 encoded image retrived from http body
    encodedImage = request.form['image']
    # this the base64 decode image in byte format
    decodedImage = base64.b64decode(encodedImage)
    # byte image is loaded as PIL jpeg object
    image = Image.open(io.BytesIO(decodedImage))
    return "Childrens Running in a Garden"

if __name__ == '__main__':
    app.run(debug=True)