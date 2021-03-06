//
//  FilmDetailViewController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 25/12/2020.
//

import Foundation
import UIKit

/// View that's shown after a film is selected from the tableview
class FilmDetailViewController: UIViewController {
    var film: Film!
    @IBOutlet weak var filmPoster: UIImageView!
    @IBOutlet weak var filmScore: UILabel!
    @IBOutlet weak var filmYear: UILabel!
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var filmDirector: UILabel!
    @IBOutlet weak var filmDescription: UITextView!
    @IBOutlet weak var filmRuntime: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        mainStackView.layer.cornerRadius = 15
        mainStackView.layer.cornerCurve = .continuous
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage(from: self.film!.titleImage)
        filmName.text = self.film!.titel
        filmDirector.text = "Director: \(self.film!.regisseur)"
        filmDescription.text = self.film!.description
        filmYear.text = "Release date: \(self.film!.year)"
        filmScore.text = "Score: \(self.film!.score)"
        filmRuntime.text = "Runtime: \(self.film!.runtime) minutes"
    }
    /// sets image from url
    /// - Parameter url: url of image
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.filmPoster.image = image
            }
        }

    }
}
