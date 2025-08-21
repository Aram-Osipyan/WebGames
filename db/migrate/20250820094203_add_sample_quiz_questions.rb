class AddSampleQuizQuestions < ActiveRecord::Migration[7.1]
  def up
    # Sample quiz questions in Russian
    questions = [
      {
        question_text: "Актёр кино и дубляжа, эстрадный певец, один из наиболее любимых артистов советской эстрады 1950—1960-х годов",
        option_a: "Михаил Булгаков",
        option_b: "Михаил Ломоносов", 
        option_c: "Марк Бернес",
        option_d: "Дмитрий Менделеев",
        correct_answer: "B",
        category: "История",
        difficulty: 2
      },
      {
        question_text: "Какая планета является самой большой в Солнечной системе?",
        option_a: "Сатурн",
        option_b: "Юпитер",
        option_c: "Нептун", 
        option_d: "Уран",
        correct_answer: "B",
        category: "Астрономия",
        difficulty: 1
      },
      {
        question_text: "В каком году была основана Москва?",
        option_a: "1147",
        option_b: "1156",
        option_c: "1174",
        option_d: "1185",
        correct_answer: "A",
        category: "История",
        difficulty: 2
      },
      {
        question_text: "Кто написал роман 'Война и мир'?",
        option_a: "Фёдор Достоевский",
        option_b: "Лев Толстой",
        option_c: "Иван Тургенев",
        option_d: "Антон Чехов",
        correct_answer: "B",
        category: "Литература",
        difficulty: 1
      },
      {
        question_text: "Какой химический элемент обозначается символом 'Au'?",
        option_a: "Серебро",
        option_b: "Алюминий",
        option_c: "Золото",
        option_d: "Медь",
        correct_answer: "C",
        category: "Химия",
        difficulty: 2
      },
      {
        question_text: "Столица Австралии?",
        option_a: "Сидней",
        option_b: "Мельбурн",
        option_c: "Канберра",
        option_d: "Перт",
        correct_answer: "C",
        category: "География",
        difficulty: 3
      },
      {
        question_text: "Сколько струн у классической гитары?",
        option_a: "4",
        option_b: "5",
        option_c: "6",
        option_d: "7",
        correct_answer: "C",
        category: "Музыка",
        difficulty: 1
      },
      {
        question_text: "Какая река является самой длинной в мире?",
        option_a: "Амазонка",
        option_b: "Нил",
        option_c: "Янцзы",
        option_d: "Миссисипи",
        correct_answer: "B",
        category: "География",
        difficulty: 2
      },
      {
        question_text: "В каком году человек впервые высадился на Луну?",
        option_a: "1967",
        option_b: "1968",
        option_c: "1969",
        option_d: "1970",
        correct_answer: "C",
        category: "История",
        difficulty: 2
      },
      {
        question_text: "Кто изобрёл телефон?",
        option_a: "Томас Эдисон",
        option_b: "Александр Белл",
        option_c: "Никола Тесла",
        option_d: "Гульельмо Маркони",
        correct_answer: "B",
        category: "Наука",
        difficulty: 2
      },
      {
        question_text: "Какой газ составляет большую часть атмосферы Земли?",
        option_a: "Кислород",
        option_b: "Углекислый газ",
        option_c: "Азот",
        option_d: "Аргон",
        correct_answer: "C",
        category: "Наука",
        difficulty: 2
      },
      {
        question_text: "Сколько костей в теле взрослого человека?",
        option_a: "196",
        option_b: "206",
        option_c: "216",
        option_d: "226",
        correct_answer: "B",
        category: "Биология",
        difficulty: 3
      }
    ]

    questions.each do |q|
      QuizQuestion.create!(
        question_text: q[:question_text],
        option_a: q[:option_a],
        option_b: q[:option_b],
        option_c: q[:option_c],
        option_d: q[:option_d],
        correct_answer: q[:correct_answer],
        category: q[:category],
        difficulty: q[:difficulty],
        active: true,
        active_from: Time.current
      )
    end
  end

  def down
    QuizQuestion.delete_all
  end
end