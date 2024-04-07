from flask import Flask
import uuid
import time

app = Flask(__name__, static_folder=None)

@app.route("/")
def hello_world():
    machine_id = uuid.getnode()
    time.sleep(2)
    return "Machine ID : " + str(machine_id)

@app.route("/index")
def hello_world():
    machine_id = uuid.getnode()
    time.sleep(2)
    return "This is index page"

if __name__ == "__main__":
    app.run(threaded=True)