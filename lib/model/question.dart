
class Question{

  final int id;
  final String question;
  final String answer;

  Question({this.id,this.question,this.answer});

  static List<Question> getquestionlist(){
    var list = List<Question>();
    list.add(Question(id: 1,question: '1. What is your craziest party island experience ?',answer:''));
    list.add(Question(id: 2,question: '2. What is your go too drink ?',answer:''));
    list.add(Question(id: 3,question: '3. At the pool party I am most likely to ?',answer:''));
    list.add(Question(id: 4,question: '4. What is your favourite party island ?',answer:''));
    list.add(Question(id: 5,question: '5. A holiday goal of mine ?',answer:''));
    list.add(Question(id: 6,question: '6. My biggest holiday fail is ?',answer:''));
    list.add(Question(id: 7,question: '7. 2 truths and 1 lie ?',answer:''));
    list.add(Question(id: 8,question: '8. The first thing I am going to do  when I land is ?',answer:''));
    list.add(Question(id: 9,question: '9. Your destination ?',answer:''));
    return list;
  }

}