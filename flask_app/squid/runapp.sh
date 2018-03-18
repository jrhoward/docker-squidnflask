#!/bin/bash
cd /opt/flask_app/squid/
export FLASK_APP=/opt/flask_app/squid/flask_app.py
flask run --host=0.0.0.0
