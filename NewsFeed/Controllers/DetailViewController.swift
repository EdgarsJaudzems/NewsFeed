//
//  DetailViewController.swift
//  NewsFeed
//
//  Created by Edgars Jaudzems on 13/02/2021.
//

import UIKit
import Gloss

class DetailViewController: UIViewController {

    var items: [Item] = []
    var savedData: [ReadingList] = []


    var webURLString = String()
    var titleString = String()
    var contentString = String()
    var imageString = String()
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = titleString
        setImage(from: imageString)
        contentLabel.text = contentString
        
    }
    
    @IBAction func saveToReadingList(_ sender: Any) {
        
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageLabel.image = image
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let destination: WebViewController = segue.destination as! WebViewController
        // Pass the selected object to the new view controller.
        destination.urlString = webURLString
        
    }

}


