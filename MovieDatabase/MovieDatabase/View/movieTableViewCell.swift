//
//  movieTableViewCell.swift
//  MovieDatabase
//
//  Created by Thomas Mani on 15/09/23.
//

import UIKit

class movieTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieLanguages: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    //MARK: - Properties
    private(set) var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //Setup the UI of the cell
    public func setUI(movie: Movie) {
        moviePoster.layer.cornerRadius = 6.0
        self.movie = movie
        if let posterURL = movie.poster,let url = URL(string: posterURL) {
            let urlRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.moviePoster.image = image
                }
            }.resume()
        }
        if let title = movie.title {
            movieTitle.text = title
        }
        if let languages = movie.language {
            movieLanguages.text = "Languages : "+languages
        }
        if let year = movie.year {
            movieYear.text = "Year : "+year
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        moviePoster.image = UIImage(named: "posterThumbnail")
        movieTitle.text = ""
        movieLanguages.text = ""
        movieYear.text = ""
    }
}
