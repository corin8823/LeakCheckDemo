//
//  NormalViewController.swift
//  LeakCheckDemo
//
//  Created by corin8823 on 2018/08/25.
//  Copyright © 2018年 corin8823. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class NormalViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel! {
        didSet {
            countLabel.text = "\(0)"
        }
    }
    @IBOutlet weak var incrementButton: UIButton!
    lazy var viewModel = ViewModel(tap: incrementButton.rx.tap)

    private let disposeBag = DisposeBag()

    static func make() -> NormalViewController {
        let className = String(describing: NormalViewController.self)
        let storyboard = UIStoryboard(name: className, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: className) as! NormalViewController
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Normal"

        let closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
        closeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        self.navigationItem.leftBarButtonItem = closeButton

        viewModel.count
            .map { "\($0)" }
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
