//
//  Debouncer.swift
//  BTGTest
//
//  Created by Mario de Castro on 07/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

class Debouncer {

    private var timer: Timer?

    func debounce(delay: TimeInterval, action: @escaping () -> Void) {
        if timer != nil {
            timer!.invalidate()
        }

        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: { (timer) in
            guard timer.isValid else { return }
            action()
        })
    }
}
