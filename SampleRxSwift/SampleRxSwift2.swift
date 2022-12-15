//
//  SampleRxSwift2.swift
//  SampleRxSwift
//
//  Created by 秋山悠 on 2022/12/15.
//

import RxSwift

class HogeViewController: UIViewController {
    private let disposebag = DisposeBag()
    private var viewModel: HogeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HogeViewModel()
        
        viewModel.hellowWorldObservable
            .subscribe(onNext: { [weak self] value in
                print("value:",value)
            })
            .disposed(by: disposebag)
        viewModel.updateItem()
    }
}

class HogeViewModel {
    
    private let hellowWorldSubject = PublishSubject<String>()
    
    var hellowWorldObservable: Observable<String> {
        return hellowWorldSubject
    }
    
    func updateItem() {
        hellowWorldSubject.onNext("Hellow World")
        hellowWorldSubject.onNext("Hellow World!")
        hellowWorldSubject.onCompleted()
    }
}
