import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const HeartDiseaseApp());
}

class HeartDiseaseApp extends StatelessWidget {
  const HeartDiseaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PredictionForm());
  }
}

class PredictionForm extends StatefulWidget {
  const PredictionForm({super.key});

  @override
  _PredictionFormState createState() => _PredictionFormState();
}

class _PredictionFormState extends State<PredictionForm> {
  final _formKey = GlobalKey<FormState>();
  final ageController = TextEditingController();
  final bpController = TextEditingController();
  final sugarController = TextEditingController();
  String result = "";

  Future<void> predict() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/predict'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Age": int.parse(ageController.text),
        "RestingBP": int.parse(bpController.text),
        "FastingBS": int.parse(sugarController.text),
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        result = response.body;
      });
    } else {
      setState(() {
        result = "Error in prediction";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Heart Disease Risk Prediction")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Age"),
              ),
              TextFormField(
                controller: bpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Blood Pressure"),
              ),
              TextFormField(
                controller: sugarController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Sugar Level"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: predict, child: const Text("Predict")),
              const SizedBox(height: 20),
              Text(result),
            ],
          ),
        ),
      ),
    );
  }
}
