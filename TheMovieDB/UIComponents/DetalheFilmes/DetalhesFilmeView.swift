//
//  DetalhesFilmeView.swift
//  TheMovieDB
//
//  Created by entelgy on 17/04/2019.
//  Copyright © 2019 ERIMIA. All rights reserved.
//

import UIKit

class DetalhesFilmeView: UIView {
    var id = 0
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var notaLabel: UILabel!
    @IBOutlet weak var imagemLabel: UIImageView!
    @IBOutlet weak var SinopseLabel: UILabel!
    @IBOutlet weak var favoritarButton: UIButton!
    @IBOutlet var contentView: UIView!
    
    
    override init( frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder ) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("DetalhesFilmeComponent", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func generalInits(id: Int?, titulo: String, nota: String, imagemURL: String, Sinopse: String){
        self.id = id!
        self.tituloLabel.text = titulo
        self.notaLabel.text = nota
        self.SinopseLabel.text = Sinopse
        
            if let url = URL(string: "https://image.tmdb.org/t/p/w500" + imagemURL){
                let data = try? Data(contentsOf: url)
                self.imagemLabel.image = UIImage(data: data!)
            }else {
                print("imagem nao encontrada")
            }
        
    }
}
