//
//  MoviesTableViewCell.swift
//  LoodosCaseStudy
//
//  Created by Aleyna on 6.06.2023.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var PosterImageView: UIImageView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var YearLabel: UILabel!
    
    @IBOutlet weak var imdbIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let identifier = "MoviesTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MoviesTableViewCell", bundle: nil)
    }
    
    func configure(with model: MovieSegment) {
        self.TitleLabel.text = model.Title
        self.YearLabel.text = model.Year
        self.imdbIdLabel.text = " "
        let url = model.Poster
        
        if let data = try? Data(contentsOf: URL(string: url)!) {
            self.PosterImageView.image = UIImage(data: data)
            
        }
        }


    
}
