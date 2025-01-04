from flask import Flask, jsonify
import psycopg2
import os

app = Flask(__name__)

@app.route('/health')
def health_check():
    db_host = os.getenv("DB_HOST")
    db_user = os.getenv("DB_USER")
    db_password = os.getenv("DB_PASSWORD")
    db_name = os.getenv("DB_NAME", "postgres")  # Default DB name if not provided

    try:
        # Connect to the database
        conn = psycopg2.connect(
            host=db_host,
            user=db_user,
            password=db_password,
            dbname=db_name
        )
        conn.close()
        return jsonify({"status": "healthy", "db_connection": "successful"}), 200
    except Exception as e:
        return jsonify({"status": "unhealthy", "error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
