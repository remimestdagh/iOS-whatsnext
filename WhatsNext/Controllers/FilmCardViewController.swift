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
    @IBOutlet weak var IVLike: UIImageView!
    @IBOutlet weak var IVDislike: UIImageView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var IVMessage: UIImageView!
    var films: [Film] = []

    //methods

    override func viewDidLoad() {

        super.viewDidLoad()


        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeGesture(gestureRecognizer: )))

        IVPoster.addGestureRecognizer(swipeGesture)
    }

    @objc func swipeGesture(gestureRecognizer: UIPanGestureRecognizer){
        let labelPoint =  gestureRecognizer.translation(in: view)

        IVPoster.center = CGPoint(x: view.bounds.width/2 + labelPoint.x , y:  view.bounds.height/2 + labelPoint.y)

        // set up the the positon and the CGAffineTransform
        let xFromCenter = view.bounds.width / 2 - IVPoster.center.x

        var rotation = CGAffineTransform(rotationAngle: xFromCenter/200)

        let scale = min(100/abs(xFromCenter), 1)

        var scaleAndRotated = rotation.scaledBy(x: scale, y: scale)

        IVPoster.transform = scaleAndRotated



        if gestureRecognizer.state == .ended{


            // deal with the accpeted and rejected
            var acceptedORrejected = ""





            if IVPoster.center.x < (view.bounds.width / 2 - 100) {
                print("no Interested")
                self.IVMessage.isHidden = false
                IVMessage.image = UIImage(named: "NopeSign")
                acceptedORrejected = "rejected"
            }
            if IVPoster.center.x > (view.bounds.width / 2 + 100) {
                print("Interested")
                self.IVMessage.isHidden = false
                IVMessage.image = UIImage(named: "LikeSign")
                acceptedORrejected = "accepted"
            }







            // resume the positon and the CGAffineTransform
            rotation = CGAffineTransform(rotationAngle: 0)

            scaleAndRotated = rotation.scaledBy(x: 1, y: 1)

            IVPoster.transform = scaleAndRotated

            IVPoster.center = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        }

    }


    func getNextFilms() {
        Network.shared.getNextFilms(skip: "100") {
            [self] films in
            self.films = films
            print(films)

        }
    }


}
