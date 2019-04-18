//
//  ListaDeFilmesView.swift
//  TheMovieDB
//
//  Created by entelgy on 16/04/2019.
//  Copyright © 2019 ERIMIA. All rights reserved.
//

import UIKit
protocol ListaDeFilmesDelegate {
    func endEditing(textChanged: String)
    func clickedItem(id: Int?, error: String?)
}


class ListaDeFilmesView: UIView, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var listaDefilmesModel = [ListaDeFilmesModel]()
    @IBOutlet weak var searchText: UITextField!
    var timer: Timer?
    var delegate: ListaDeFilmesDelegate?

    
    override init( frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder ) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func externalRefresh(listaDeFilmes: [ListaDeFilmesModel]){
        self.listaDefilmesModel = listaDeFilmes
        
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ListaDeFilmesComponent", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        registerNibs()
        
        searchText.addTarget(self, action: #selector(changedValue), for: .editingChanged)
        
    }
    
    @objc func changedValue() {
        if self.timer != nil {
            self.timer!.invalidate()
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(verifyChange), userInfo: nil, repeats: false)
    }
    
    @objc func verifyChange(){
        print("textField: \(searchText.text!)")
        delegate?.endEditing(textChanged: searchText.text!)
    }
    
    
    private func registerNibs() {
        let nib = UINib(nibName: "ListaDeFilmesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ListaDeFilmesCell")
    }
    
    //Table View delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDefilmesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListaDeFilmesCell", for: indexPath) as! ListaDeFilmesTableViewCell
        cell.ano.text = listaDefilmesModel[indexPath.row].ano
        cell.titulo.text = listaDefilmesModel[indexPath.row].nome
        
        if listaDefilmesModel[indexPath.row].posterURL != nil {
            if let url = URL(string: "https://image.tmdb.org/t/p/w500" + listaDefilmesModel[indexPath.row].posterURL!){
                let data = try? Data(contentsOf: url)
                cell.poster.image = UIImage(data: data!)
            }else {
                print("imagem nao encontrada")
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(listaDefilmesModel[indexPath.row])
        if listaDefilmesModel[indexPath.row].id != nil {
            delegate?.clickedItem(id: listaDefilmesModel[indexPath.row].id!, error: nil  )
        } else {
            delegate?.clickedItem(id: nil, error: "Id não identificado"  )
        }

    }
}
