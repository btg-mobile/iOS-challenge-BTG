//
//  Helper.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 12/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class Helper {    
    func getFullScreenFrame() -> CGRect {
        let screenFrame = UIScreen.main.bounds
        let statusBarFrame = UIApplication.shared.statusBarFrame
        
        let frame = CGRect(
            x: 0,
            y: screenFrame.origin.y - statusBarFrame.height,
            width: screenFrame.width,
            height: screenFrame.height + statusBarFrame.height
        )
        
        return frame
    }
}
