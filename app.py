from flask import Flask, request, jsonify
import pandas as pd
import joblib

app = Flask(__name__)

# Load models
logistic_model = joblib.load('logistic_model.pkl')
dt_model = joblib.load('decision_tree_model.pkl')

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    input_data = pd.DataFrame(data, index=[0])

    # Predict using both models
    log_prediction = logistic_model.predict(input_data)[0]
    dt_prediction = dt_model.predict(input_data)[0]

    return jsonify({
        "LogisticRegression": "Risk: High" if log_prediction == 1 else "Risk: Low",
        "DecisionTree": "Risk: High" if dt_prediction == 1 else "Risk: Low"
    })

if __name__ == '__main__':
    app.run(debug=True)
