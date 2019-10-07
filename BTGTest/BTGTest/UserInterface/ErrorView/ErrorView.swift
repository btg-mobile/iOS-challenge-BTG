//
//  ErrorView.swift
//  BTGTest
//
//  Created by MARIO CASTRO on 07/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit

protocol ErrorViewDelegate {
    func errorViewDidPressTryAgainButton(_ errorView: ErrorView)
}

class ErrorView: UIView {

    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var tryAgainButton: UIButton!

    var delegate: ErrorViewDelegate!

    class func instance() -> ErrorView {
        guard let view = UINib(nibName: "ErrorView", bundle: nil)
            .instantiate(withOwner: nil, options: nil).first as? ErrorView else {
            return ErrorView()
        }

        return view
    }

    func layout(into view: UIView?) {
        guard let view = view else { return }

        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)

        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])

        tryAgainButton.layer.borderWidth = 3
        tryAgainButton.layer.cornerRadius = tryAgainButton.frame.height / 2
        tryAgainButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        if #available(iOS 13.0, *) {
            tryAgainButton.layer.borderColor = UIColor.label.cgColor
        } else {
            tryAgainButton.layer.borderColor = UIColor.black.cgColor
        }
    }

    func setMessage(_ message: String) {
        errorLabel.text = message
    }

    @IBAction private func didPressTryAgainButton(_ sender: Any) {
        delegate.errorViewDidPressTryAgainButton(self)
    }

}
