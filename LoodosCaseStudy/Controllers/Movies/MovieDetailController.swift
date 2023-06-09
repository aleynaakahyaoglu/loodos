//
//  MovieDetailController.swift
//  LoodosCaseStudy
//
//  Created by Aleyna on 9.06.2023.
//

import UIKit

class MovieDetailController: UIViewController {

    @IBOutlet weak var TypeText: UILabel!
    @IBOutlet weak var ImdbText: UILabel!
    @IBOutlet weak var YearText: UILabel!
    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var Poster: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configure(with model: MovieSegment) {
        self.TitleText.text = model.Title
        self.YearText.text = model.Year
        self.ImdbText.text = model.imdbID
        
        let url = model.Poster
        
        if let data = try? Data(contentsOf: URL(string: url)!) {
            self.Poster.image = UIImage(data: data)
            
        }
        }
    

}
