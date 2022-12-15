//
//  VC.swift
//  SampleRxSwift
//
//  Created by 秋山悠 on 2022/12/14.
//

import RxCocoa
import RxSwift
import RxOptional

class VC: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressField: UITextField!
    @IBOutlet weak var adressLabel: UILabel!
    
    private let maxNameSize = 10
    private let maxAddresSize = 50
    
    private let disposeBag = DisposeBag()
    
    let limitText: (Int) -> String = {
        return "あと\($0)文字"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.rx.text
            .map { [weak self] text -> String? in
                guard let text = text else { return nil }
                guard let maxNameSize = self?.maxNameSize else { return nil}
                let limitCount = maxNameSize - text.count
                return self?.limitText(limitCount)
            }
            .filterNil() //import RxOptional必要
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        adressField.rx.text
            .map { [weak self] text -> String? in
                guard let text = text else { return nil }
                guard let maxAddresSize = self?.maxAddresSize else { return nil }
                let limitCount = maxAddresSize - text.count
                return self?.limitText(limitCount)
            }
            .filterNil()
            .bind(to: adressLabel.rx.text)
            .disposed(by: disposeBag)
    }

}

//addTargetの場合
//class VC: UIViewController {
//
//    @IBOutlet weak var nameField: UITextField!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var adressField: UITextField!
//    @IBOutlet weak var adressLabel: UILabel!
//
//    private let maxNameSize = 10
//    private let maxAddresSize = 50
//
//    let limitText: (Int) -> String = {
//        return "あと\($0)文字"
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        nameField.addTarget(self, action: #selector(nameFieldEditingChanged(sender:)), for: .editingChanged)
//
//        adressField.addTarget(self, action: #selector(adressFieldEditingChaged(sender:)), for: .editingChanged)
//    }
//
//    @objc func nameFieldEditingChanged(sender: UITextField) {
//        guard let changedText = sender.text else { return }
//        let limitCount = maxNameSize - changedText.count
//        nameLabel.text = limitText(limitCount)
//    }
//
//    @objc func adressFieldEditingChaged(sender: UITextField) {
//        guard let changedText = sender.text else { return }
//        let limitCount = maxAddresSize - changedText.count
//        adressLabel.text = limitText(limitCount)
//    }
//}
