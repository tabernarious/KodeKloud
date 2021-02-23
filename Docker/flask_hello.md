# Flask Hello World

### Update pip and install Flask:
```
pip3 install --upgrade pip
pip3 install Flask
```

### Create Flask app file:
```
cat > flask-hello.py

from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'
```

### Export Flask app and run externally:
```
export FLASK_APP=flask-hello.py
flask run --host=10.204.136.10
```