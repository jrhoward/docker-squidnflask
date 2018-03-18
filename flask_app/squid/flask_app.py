from flask import Flask, render_template, abort, redirect, url_for
from flask_httpauth import HTTPBasicAuth
import os.path
import json
app = Flask(__name__)

auth = HTTPBasicAuth()

users = None
with open('users.json') as json_data:
    users = json.load(json_data)

@auth.get_password
def get_pw(username):
    if username in users:
        return users.get(username)
    return None

@app.route('/lock-disable', methods=['POST'])
def lockd():
    with open('command', 'w') as file:
        file.write('disable')
    return redirect(url_for('status'))

@app.route('/lock-enable', methods=['POST'])
def locke():
    with open('command', 'w') as file:
        file.write('enable')
    return redirect(url_for('status'))

@app.route('/', methods=['GET'] )
@auth.login_required
def status():
    with open('state') as file:
        state =file.read()
    if os.path.isfile('command'):
        with open('command') as file:
            command =file.read()
    else:
        command='none'
    return render_template('status.html', state=state, command=command)
