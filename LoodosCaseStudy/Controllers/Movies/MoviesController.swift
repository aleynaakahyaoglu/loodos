//
//  MoviesController.swift
//  LoodosCaseStudy
//
//  Created by Aleyna on 1.06.2023.
//

import UIKit
import SafariServices


class MoviesController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{
    
    

    @IBOutlet weak var SearchTextfield: UITextField!
    
    @IBOutlet weak var MovieList: UITableView!
    
    var movies = [MovieSegment]()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchSize()
        MovieList.delegate = self
        MovieList.dataSource = self
        SearchTextfield.delegate = self
        MovieList.register(MoviesTableViewCell.nib(), forCellReuseIdentifier: MoviesTableViewCell.identifier)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        return true
    }
    func searchSize(){
        SearchTextfield.layer.cornerRadius = 8.0
    }
    
    func searchMovies(){
        SearchTextfield.resignFirstResponder()
        
        
        guard let text = SearchTextfield.text, !text.isEmpty
        else{
            return
        }
        
        let query = text.replacingOccurrences(of: " ", with:" %20")
        movies.removeAll()
        
        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?apikey=3aea79ac&s=\(query)&type=movie")!,completionHandler: { data, response, error  in
            guard let data = data, error == nil else {
                return
            }
            var result : MovieResult?
            do {
                result = try JSONDecoder().decode(MovieResult.self, from:data)
            }
            catch{
                print("error")
            }
            guard let finalResult = result else {
                return
            }
            let newMovies = finalResult.Search
            self.movies.append(contentsOf: newMovies)
            
            DispatchQueue.main.async {
                self.MovieList.reloadData()
            }
        }).resume()
                                            
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MovieList.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as! MoviesTableViewCell
        cell.configure(with: movies[indexPath.row])
        cell.layer.masksToBounds=true
        cell.layer.cornerRadius = 1
        cell.layer.borderWidth = 5
        cell.layer.shadowOffset = CGSize(width: 10, height: 10)
        let borderColor:UIColor = .gray
        cell.layer.borderColor = borderColor.cgColor
        cell.contentView.backgroundColor = .white
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        MovieList.deselectRow(at: indexPath, animated: true)
        
        let url = "https://www.imdb.com/title/\(movies[indexPath.row].imdbID)/"
        let vc = SFSafariViewController(url: URL(string: url)!)
        present(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath:IndexPath) -> CGFloat {
        return 360
    }
 
}

struct MovieResult: Codable {
    let Search: [MovieSegment]
    
}

struct MovieSegment: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let Poster: String
    
   private enum CodingKeys: String, CodingKey {
        case Title, Year, Poster, imdbID
        
    }
}

