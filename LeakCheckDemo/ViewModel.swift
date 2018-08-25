//
//  ViewModel.swift
//  LeakCheckDemo
//
//  Created by corin8823 on 2018/08/25.
//  Copyright © 2018年 corin8823. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class ViewModel {

    lazy var count = _count.asObservable()
    private let _count = BehaviorRelay<Int>(value: 0)

    private let disposeBag = DisposeBag()

    init(tap: ControlEvent<Void>) {
        tap.subscribe(onNext: { _ in
            self._count.accept(self._count.value + 1)
        })
        .disposed(by: disposeBag)
    }
}
