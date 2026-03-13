from flask import Flask, jsonify
import os, datetime

app = Flask(__name__)

@app.route("/")
def index():
    return jsonify({
        "status": "ok",
        "version": os.getenv("APP_VERSION", "unknown"),
        "time": datetime.datetime.utcnow().isoformat()
    })

@app.route("/health")
def health():
    return jsonify({"healthy": True}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)

