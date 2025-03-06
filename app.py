from flask import Flask
from werkzeug.middleware.proxy_fix import ProxyFix
import json
import mariadb
import os

app = Flask(__name__)

config = {
    'host': os.environ.get("DATABASE_URL", ""),
    'port': int(os.environ.get("DATABASE_PORT", 3306)),
    'user': os.environ.get("DATABASE_USER", ""),
    'password': os.environ.get("DATABASE_PASSWORD", ''),
    'database': os.environ.get("DATABASE_DATABASE", "")
}


@app.route("/")
def hello_world():
    conn = mariadb.connect(**config)
    # create a connection cursor
    cur = conn.cursor()
    # execute a SQL statement
    cur.execute("select * from new_table")
    return cur.fetchall()
    #return "<p>Hello World!</p>"

if __name__ == "__main__":
    app.wsgi_app = ProxyFix(
        app.wsgi_app, x_for=1, x_proto=1, x_host=1, x_prefix=1
    )
    
    app.run(host="0.0.0.0", debug=True, port=80)