import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/c_quiz.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Tangkap id_level dari Get.arguments
    final int idLevel = Get.arguments as int;

    // Inisialisasi controller
    final CQuiz cQuiz = Get.put(CQuiz());
    cQuiz.fetchQuiz(idLevel); // Panggil fungsi untuk mengambil data quiz

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Quiz',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          if (cQuiz.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cQuiz.listQuiz.isEmpty) {
            return const Center(
              child: Text(
                'Tidak ada data quiz.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          // Ambil pertanyaan pertama (bisa di-loop untuk semua pertanyaan)
          final question = cQuiz.listQuiz.first;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tampilkan pertanyaan
                Text(
                  question.questionText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Tampilkan opsi jawaban
                OptionButton(
                  optionLabel: 'A',
                  optionText: question.optionA,
                  onTap: () => cQuiz.answer(0),
                ),
                const SizedBox(height: 20),
                OptionButton(
                  optionLabel: 'B',
                  optionText: question.optionB,
                  onTap: () => cQuiz.answer(1),
                ),
                const SizedBox(height: 20),
                OptionButton(
                  optionLabel: 'C',
                  optionText: question.optionC,
                  onTap: () => cQuiz.answer(2),
                ),
                const SizedBox(height: 20),
                OptionButton(
                  optionLabel: 'D',
                  optionText: question.optionD,
                  onTap: () => cQuiz.answer(3),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// Widget untuk membuat tombol opsi jawaban
class OptionButton extends StatelessWidget {
  final String optionLabel;
  final String optionText;
  final VoidCallback onTap;

  const OptionButton({
    super.key,
    required this.optionLabel,
    required this.optionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.blue, // Sesuaikan dengan warna utama
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: Text(
                optionLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            optionText,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
