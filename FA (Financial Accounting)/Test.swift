//import UIKit
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var datePicker1: UIDatePicker!
//    @IBOutlet weak var datePicker2: UIDatePicker!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Настраиваем первый DatePicker на вызов метода при изменении даты
//        datePicker1.addTarget(self,
//                              action: #selector(datePicker1Changed(_:)),
//                              for: .valueChanged)
//
//        // Если нужно двустороннее связывание (чтобы при изменении второго обновлялся первый),
//        // аналогично:
//        datePicker2.addTarget(self,
//                              action: #selector(datePicker2Changed(_:)),
//                              for: .valueChanged)
//    }
//
//    @objc private func datePicker1Changed(_ sender: UIDatePicker) {
//        // Устанавливаем во второй пикер такую же дату
//        datePicker2.setDate(sender.date, animated: true)
//    }
//
//    @objc private func datePicker2Changed(_ sender: UIDatePicker) {
//        // При желании зеркально обновляем первый
//        datePicker1.setDate(sender.date, animated: true)
//    }
//}
//
//#Preview {
//    ViewController()
//}
