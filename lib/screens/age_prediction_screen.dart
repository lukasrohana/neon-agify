import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confetti/confetti.dart';
import '../blocs/age_prediction_bloc.dart';
import '../widgets/name_text_field.dart';
import '../widgets/search_button.dart';

class AgePredictionScreen extends StatefulWidget {
  const AgePredictionScreen({super.key});

  @override
  AgePredictionScreenState createState() => AgePredictionScreenState();
}

class AgePredictionScreenState extends State<AgePredictionScreen> {

  ConfettiController confetti = ConfettiController(duration: const Duration(milliseconds: 1500));
  TextEditingController nameController = TextEditingController();

  void _onTextChanged() {
    final currentState = context.read<AgePredictionBloc>().state;
    if ((currentState is AgePredictionLoaded || currentState is AgePredictionError) && nameController.text.isNotEmpty) {
      context.read<AgePredictionBloc>().add(ResetAgePrediction());
      nameController.clear();
    }
  }

  void _searchName() {
    if (nameController.text.isNotEmpty) {
      context.read<AgePredictionBloc>().add(GetAgePrediction(nameController.text));
      confetti.play();
    }
  }

  void _reset() {
    context.read<AgePredictionBloc>().add(ResetAgePrediction());
    nameController.clear();
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    confetti.dispose();
    nameController.removeListener(_onTextChanged);
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFedede9),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            ConfettiWidget(
              confettiController: confetti,
              minBlastForce: 10,
              maxBlastForce: 11,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Estimate the Age\nof a Name',
              style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(child: NameTextField(controller: nameController)),
                const SizedBox(width: 10),
                BlocBuilder<AgePredictionBloc, AgePredictionState>(
                  builder: (context, state) {
                    final showRefreshButton = state is AgePredictionLoaded || state is AgePredictionError;
                    return SearchButton(
                      onTap: showRefreshButton ? _reset : _searchName,
                      showRefreshButton: showRefreshButton,
                    );
                  },
                )
              ],
            ),
            const SizedBox(height: 25),
            BlocBuilder<AgePredictionBloc, AgePredictionState>(
              builder: (context, state) {
                Widget? child;
                if (state is AgePredictionLoading) {
                  child = const CupertinoActivityIndicator();
                }
                else if (state is AgePredictionLoaded) {
                  child = RichText(
                    text: TextSpan(
                      text: '',
                      style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 16, fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(text: state.prediction.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(text: ' is '),
                        TextSpan(text: '${state.prediction.age}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(text: ' years old'),
                      ],
                    ),
                  );
                }
                else if (state is AgePredictionError) {
                  child = Text(state.message, style: const TextStyle(color: Colors.red));
                }

                // same height for calmer UI on state change
                return SizedBox(
                  height: 30,
                  child: child
                );
              },
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
