//
//  MovieDetailViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var watchlistBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    
    var movie: Movie!
    
    var isWatchlist: Bool {
        return MovieModel.watchlist.contains(movie)
    }
    
    var isFavorite: Bool {
        return MovieModel.favorites.contains(movie)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = movie.title
        
        toggleBarButton(watchlistBarButtonItem, enabled: isWatchlist)
        toggleBarButton(favoriteBarButtonItem, enabled: isFavorite)
        
    }
    
    @IBAction func watchlistButtonTapped(_ sender: UIBarButtonItem) {
        ApiClient.markWatchList(mediaType: Types.movie.rawValue, mediaId: movie.id, watchlist: !isWatchlist) { sucess, error in
            if sucess {
                if self.isWatchlist {
                    if let index = MovieModel.watchlist.firstIndex(of: self.movie) {
                        MovieModel.watchlist.remove(at: index)
                    }
                } else {
                    MovieModel.watchlist.append(self.movie)
                }
                self.toggleBarButton(self.watchlistBarButtonItem, enabled: self.isWatchlist)
            }
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        ApiClient.markFavorite(mediaType: Types.movie.rawValue, mediaId: movie.id, favorite: !isFavorite) { sucess, error in
            if sucess {
                if self.isFavorite {
                    if let index = MovieModel.favorites.firstIndex(of: self.movie) {
                        MovieModel.favorites.remove(at: index)
                    }
                } else {
                    MovieModel.favorites.append(self.movie)
                }
                self.toggleBarButton(self.favoriteBarButtonItem, enabled: self.isFavorite)
            }
        }
    }
    
    func toggleBarButton(_ button: UIBarButtonItem, enabled: Bool) {
        if enabled {
            button.tintColor = UIColor.primaryDark
        } else {
            button.tintColor = UIColor.gray
        }
    }
    
    
}
