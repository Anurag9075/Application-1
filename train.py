import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
import joblib

# Load CSV dataset
data = pd.read_csv('heart.csv')

# Features and target
X = data.drop('Target', axis=1)
y = data['Target']

# Split dataset
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train Logistic Regression
log_model = LogisticRegression()
log_model.fit(X_train, y_train)

# Train Decision Tree
dt_model = DecisionTreeClassifier()
dt_model.fit(X_train, y_train)

# Save models
joblib.dump(log_model, 'logistic_model.pkl')
joblib.dump(dt_model, 'decision_tree_model.pkl')

print("Models saved successfully!")
