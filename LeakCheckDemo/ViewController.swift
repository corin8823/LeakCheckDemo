//
//  ViewController.swift
//  LeakCheckDemo
//
//  Created by corin8823 on 2018/08/25.
//  Copyright © 2018年 corin8823. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class ViewController: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        aButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let vc = MemoryLeakViewController.make()
                self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        bButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let vc = NormalViewController.make()
                self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
