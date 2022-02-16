//
//  ViewController.swift
//  UITextView
//
//  Created by MacBook on 04.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var myTextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextWiev), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextWiev), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        createTextView()
    }

    func createTextView() {
        //Задаем координаты и размер
        myTextView = UITextView(frame: CGRect(x: 20, y: 100, width: self.view.bounds.width - 40, height: self.view.bounds.height / 2))
        //
        myTextView.text = "Hello World"
        //Расположение контента
        myTextView.contentInset = UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 0)
        //Задаем шришт
        myTextView.font = UIFont.systemFont(ofSize: 17)
        //Задаем цвет текста
        myTextView.textColor = .black
        //Задаем цвет для UITextViev
        myTextView.backgroundColor = .gray
        //Закруглил края на UITextView
        myTextView.layer.cornerRadius = 12
        //Добавляем на View
        self.view.addSubview(myTextView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //При касании вне области UITextView, клавиатура пропадает
        self.myTextView.resignFirstResponder()
        //При касании вне области UITextView, меняется цвет
        self.myTextView.backgroundColor = UIColor.white
    }
    
    @objc func updateTextWiev(param: Notification) {
        let userInfo = param.userInfo
        let getKeyboardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardFrame = self.view.convert(getKeyboardRect, from: view.window)
        if param.name == UIResponder.keyboardWillHideNotification {
            /*Настраиваемое расстояние, на котором представление содержимого
            находится в пределах безопасной области или краев представления
            прокрутки */
            myTextView.contentInset = UIEdgeInsets.zero
        }else {
            myTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height / 4, right: 0)
            /*Расстояние, на которое индикаторы прокрутки вставляются
            от края прокрутки */
            myTextView.scrollIndicatorInsets = myTextView.contentInset
        }
        /*Прокручивает текстовое представление до тех пор,
        пока текст в указанном диапазоне не станет видимым */
        myTextView.scrollRangeToVisible(myTextView.selectedRange)
    }
        
}

