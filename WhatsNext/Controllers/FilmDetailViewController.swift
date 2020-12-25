//
//  FilmDetailViewController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 25/12/2020.
//

import Foundation
import UIKit

class FilmDetailViewController: UIViewController {
    var film: Film?
    let imageIV = UIImageView()
    var safeArea: UILayoutGuide!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        safeArea = view.layoutMarginsGuide
        setupImage()
    }

    func setupImage() {
        view.addSubview(imageIV)
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        imageIV.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50).isActive = true
        imageIV.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5).isActive = true
        imageIV.heightAnchor.constraint(equalTo: imageIV.widthAnchor).isActive = true
        imageIV.contentMode = .scaleAspectFit
        if let film = film {
            setImage(from: film.titleImage)
        }
    }

    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageIV.image = image
            }
        }

    }

}
