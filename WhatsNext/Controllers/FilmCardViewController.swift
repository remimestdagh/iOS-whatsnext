//
//  FilmCardViewController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 21/11/2020.
//

import Foundation
import UIKit
class FilmCardViewController: UIViewController {
    //attributes
    @IBOutlet weak var IVPoster: UIImageView!
    @IBOutlet weak var LBLFilmTitle: UILabel!
    @IBOutlet weak var LBLScore: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var IVMessage: UIImageView!
    @IBOutlet weak var LBLDescription: UITextView!
    @IBOutlet weak var SwipeView: UIView!
    var currentIndex: Int = 0
    var films: [Film] = []
    var currentFilm: Film?
    let defaultSkip: Int = 0

    //methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getNextFilms(skip: defaultSkip)
        mainStackView.layer.cornerRadius = 15
        mainStackView.layer.cornerCurve = .continuous
    }
    func getNextFilms(skip: Int) {
        Network.shared.getNextFilms(skip: skip) { [self] films in
            self.films = films
            if !films.isEmpty {
                self.currentFilm = films[0]
                setImage(from: self.currentFilm!.titleImage)
                LBLFilmTitle.text=self.currentFilm?.titel
                LBLScore.text = self.currentFilm?.regisseur
                LBLDescription.text = self.currentFilm?.description

            }

        }
    }

    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.IVPoster.image = image
            }
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeGesture(gestureRecognizer: )))
        self.SwipeView.addGestureRecognizer(swipeGesture)
    }

    @objc func swipeGesture(gestureRecognizer: UIPanGestureRecognizer) { let labelPoint =
        gestureRecognizer.translation(in: view)

        SwipeView.center = CGPoint(x: view.bounds.width/2 + labelPoint.x, y: view.bounds.height/2 + labelPoint.y)
        let xFromCenter = view.bounds.width / 2 - SwipeView.center.x
        var rotation = CGAffineTransform(rotationAngle: xFromCenter/200)
        let scale = min(100/abs(xFromCenter), 1)
        var scaleAndRotated = rotation.scaledBy(x: scale, y: scale)

        SwipeView.transform = scaleAndRotated
        if gestureRecognizer.state == .ended {
            if SwipeView.center.x < (view.bounds.width / 2 - 100) {
                self.IVMessage.isHidden = false
                self.IVMessage.image = UIImage(named: "NopeSign")
                nextFilm()
            }
            if SwipeView.center.x > (view.bounds.width / 2 + 100) {
                self.IVMessage.isHidden = false
                self.IVMessage.image = UIImage(named: "LikeSign")
                Network.shared.addToWatchlist(id: String.init(currentFilm!.id)) { isSuccess in
                    if isSuccess {
                        self.nextFilm()

                    }

                }

            }
            if SwipeView.center.y > (view.bounds.height / 2 + 200) {
                self.IVMessage.isHidden = false
                self.IVMessage.image = UIImage(named: "SeenSign")
                Network.shared.addToWatched(id: String.init(currentFilm!.id)) { isSuccess in
                    if isSuccess {
                        self.nextFilm()
                    }
                }

            }
            rotation = CGAffineTransform(rotationAngle: 0)
            scaleAndRotated = rotation.scaledBy(x: 1, y: 1)
            SwipeView.transform = scaleAndRotated
            SwipeView.center = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)

        }

    }
    ///called after swipe, prepares view for next film
    func nextFilm() {
        hideImageAfterTime(time: 2, imageView: self.IVMessage)
        self.currentIndex+=1
        self.IVMessage.isHidden = false

        if self.currentIndex == self.films.endIndex {
            getNextFilms(skip: defaultSkip)
            self.currentIndex = 0
        }

        self.currentFilm = self.films[self.currentIndex]
        self.LBLFilmTitle.text = self.currentFilm?.titel
        self.LBLScore.text = self.currentFilm?.regisseur
        self.LBLDescription.text = self.currentFilm?.description
        setImage(from: self.currentFilm!.titleImage)
    }
    ///hides message image after indicated time in seconds
    func hideImageAfterTime(time: CFTimeInterval, imageView: UIImageView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
          imageView.isHidden = true
        }
      }
}
