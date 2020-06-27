//
//  OnboardingViewModel.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 13/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

class OnboardingViewModel {
    
    //ArrayOfPages for Onborading
    let pages: [Page] = {
        
        let firstPage = Page(title: "Veja o que está em alta", message: "Você pode acompanhar o que há de novo nos cinemas, bem como os filmes populares e os mais bem ranqueados.", imageName: "page1")
        
        let secondPage = Page(title: "Favorite os seus interesses", message: "Clique em favoritar em qualquer item, seja um filme ou uma série para consultar depois.", imageName: "page2")
        
        let thirdPage = Page(title: "Saiba antes de ir ao cinema", message: "Assista aos trailers e reviews de outras pessoas e veja o que te espera.", imageName: "page3")
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    func getArrayOfPages() -> [Page] {
        
        return pages
        
    }
    
    func getNumberOfItems() -> Int {
        
        return self.pages.count
        
    }
    
    func getPageWithIndex(for index: IndexPath) -> Page {
        
        return self.pages[index.item]
        
    }
    
}
