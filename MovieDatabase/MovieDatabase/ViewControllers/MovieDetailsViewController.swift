//
//  MovieDetailsViewController.swift
//  MovieDatabase
//
//  Created by Thomas Mani on 15/09/23.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var castAndCrewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var ratingMenuButton: UIButton!
    @IBOutlet weak var starRatingView: UIStackView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    //MARK: - Propeties
    private var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    public func setMovie(movie:Movie) {
        self.movie = movie
    }
    
    //Update number of starts in rartigs view
    func updateRatings(source:String) {
        if let rating = movie?.ratings?.first(where: { $0.source == source }) {
            var ratingvalue = rating.getRatingValue()
            for view in starRatingView.subviews {
                view.removeFromSuperview()
            }
            for _ in 0..<Int(ratingvalue) {
                let view = UIImageView(image: UIImage(systemName: "star.fill"))
                view.heightAnchor.constraint(equalToConstant: 25).isActive = true
                view.widthAnchor.constraint(equalToConstant: 25).isActive = true
                starRatingView.addArrangedSubview(view)
            }
            if ratingvalue.truncatingRemainder(dividingBy: 1) >= 0.5{
                ratingvalue += 1
                let view = UIImageView(image: UIImage(systemName: "star.leadinghalf.fill"))
                view.heightAnchor.constraint(equalToConstant: 25).isActive = true
                view.widthAnchor.constraint(equalToConstant: 25).isActive = true
                starRatingView.addArrangedSubview(view)
            }
            for _ in Int(ratingvalue)..<5 {
                let view = UIImageView(image: UIImage(systemName: "star"))
                view.heightAnchor.constraint(equalToConstant: 25).isActive = true
                view.widthAnchor.constraint(equalToConstant: 25).isActive = true
                starRatingView.addArrangedSubview(view)
            }
            ratingLabel.text = rating.value
        }
    }
    
    //Setup the menu button to choose ratings from multiple sources
    func setupRatingButton(ratings:[Ratings]) {
        let menuClosure = { (action: UIAction) in
            self.updateRatings(source: action.title)
        }
        let actionArray : [UIAction] = ratings.compactMap {
            if let source = $0.source {
               return  UIAction(title: source , handler:menuClosure)
            }
            return nil
        }
        actionArray.first?.state = .on
        if let source = ratings.first?.source {
            updateRatings(source: source)
        }
        ratingMenuButton.menu = UIMenu(children: actionArray)
        ratingMenuButton.showsMenuAsPrimaryAction = true
        ratingMenuButton.changesSelectionAsPrimaryAction = true
    }

    //Setup the content of the viewcontroller
    func setupUI() {
        if let movie = self.movie {
            if let posterURL = movie.poster,let url = URL(string: posterURL) {
                let urlRequest = URLRequest(url: url)
                URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                    guard
                        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                        let data = data, error == nil,
                        let image = UIImage(data: data)
                        else { return }
                    DispatchQueue.main.async() { [weak self] in
                        self?.posterImageView.image = image
                    }
                }.resume()
            }
            if let title = movie.title {
                titleLabel.text = title
            }
            if let castAndCrew = movie.actors {
                castAndCrewLabel.text = castAndCrew
            }
            if let releaseDate = movie.released {
                releaseDateLabel.text = "Release date : " + releaseDate
            }
            if let genre = movie.genre {
                genreLabel.text = "Genre : " + genre
            }
            if let plot = movie.plot {
                plotLabel.text = plot
            }
            if let ratings = movie.ratings {
                setupRatingButton(ratings: ratings)
            } else {
                ratingStackView.isHidden = true
            }
        }
    }

}
