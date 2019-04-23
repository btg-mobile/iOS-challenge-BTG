//
//  ReusableCell.swift
//  BTGMovies
//
//  Created by Ricardo Hochman on 23/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

protocol NibLoadName: class {
    static var nibName: String { get }
}

extension NibLoadName where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

protocol ReusableIdentifier: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableIdentifier where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

protocol ReusableView: NibLoadName, ReusableIdentifier { }

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableIdentifier {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerHeader<T: UICollectionViewCell>(_ view: T.Type) where T: ReusableView {
        registerSupplementaryView(view, kind: UICollectionView.elementKindSectionHeader)
    }
    
    func registerFooter<T: UICollectionViewCell>(_ view: T.Type) where T: ReusableView {
        registerSupplementaryView(view, kind: UICollectionView.elementKindSectionFooter)
    }
    
    func registerSupplementaryView<T: UICollectionViewCell>(_: T.Type, kind: String) where T: ReusableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register(cells: ReusableView.Type...) {
        for cell in cells {
            let bundle = Bundle(for: cell)
            let nib = UINib(nibName: cell.nibName, bundle: bundle)
            self.register(nib, forCellWithReuseIdentifier: cell.defaultReuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableIdentifier {
         guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableFooterCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableIdentifier {
        return dequeueReusableSupplementaryView(for: indexPath, of: UICollectionView.elementKindSectionFooter)
    }
    
    func dequeueReusableHeaderCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableIdentifier {
        return dequeueReusableSupplementaryView(for: indexPath, of: UICollectionView.elementKindSectionHeader)
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionViewCell>(for indexPath: IndexPath, of kind: String) -> T where T: ReusableIdentifier {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableIdentifier {
        self.register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        self.register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        self.register(nib, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register(cells: ReusableView.Type...) {
        for cell in cells {
            let bundle = Bundle(for: cell)
            let nib = UINib(nibName: cell.nibName, bundle: bundle)
            self.register(nib, forCellReuseIdentifier: cell.defaultReuseIdentifier)
        }
    }
    
    func register(cells: [ReusableView.Type]) {
        for cell in cells {
            let bundle = Bundle(for: cell)
            let nib = UINib(nibName: cell.nibName, bundle: bundle)
            self.register(nib, forCellReuseIdentifier: cell.defaultReuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableIdentifier {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>() -> T where T: ReusableIdentifier {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return view
    }

}

extension UIView {
    func loadNib() -> UIView {
        guard let nibName = type(of: self).description().components(separatedBy: ".").last, let nib = UINib(nibName: nibName, bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Could not dequeue view with identifier")
        }
        return nib
    }

}
