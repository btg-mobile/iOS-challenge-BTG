//
//  viewControllerSpec.swift
//  DHUnitTestTests
//
//  Created by Alan Silva on 29/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import Quick
import Nimble
import Nimble_Snapshots

@testable import DHUnitTest

class viewControllerSpec: QuickSpec {
    
    override func spec() {
        describe("ViewController Layout"){
            
            var sut : ViewController!
            
            context("When instantiates the ViewController") {
                
                beforeEach {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    sut = storyboard.instantiateViewController(identifier: "ViewController")
                }
                
                it("Espero que o layout seja") {
                    //expect(sut).to(recordSnapshot())
                    expect(sut).to(haveValidSnapshot())
                }
                
                beforeEach {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    sut = storyboard.instantiateViewController(identifier: "ViewController")
                    WindowHelper.showInTestWindow(viewController: sut)
                }
                
                it("Espero que o layout da tableView seja"){
                    //expect(sut.tableView).to(recordSnapshot())
                    expect(sut.tableView).to(haveValidSnapshot())
                }
                
            }
            
        }
        
    }
    
}
