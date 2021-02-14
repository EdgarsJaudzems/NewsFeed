//
//  NewsFeedViewController.swift
//  NewsFeed
//
//  Created by Edgars Jaudzems on 13/02/2021.
//

import UIKit
import Gloss
import CoreData

class NewsFeedViewController: UIViewController {

    var items: [Item] = []
    //var savedData: []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Latvian News"
    }

    @IBAction func refreshData(_ sender: Any) {
        getData()
    }
    
    func getData() {
        
        let jsonUrl = "https://newsapi.org/v2/top-headlines?country=lv&apiKey=23d84b84b6ec4512949301869ddfebef"
        
        guard let url = URL(string: jsonUrl) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in

            if let err = error {
                print("error: \(err.localizedDescription)")
            }
            
            guard let data = data else {
                print("Data error!")
                return
            }
            
            do {
                if let dictData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("dictData", dictData)
                    self.populateData(dictData)
                }
            } catch {
                print("Error when converting JSON")
            }
        }
        task.resume()
    }
    
    func populateData(_ dict: [String: Any]) {
        guard let responseDict = dict["articles"] as? [Gloss.JSON] else {
            return
        }
        
        items = [Item].from(jsonArray: responseDict) ?? []
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension NewsFeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }

        let feed = items[indexPath.row]
        cell.setUI(with: feed)
        cell.showImage(with: feed)
        cell.selectionStyle = .none


        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            vc.contentString = items[indexPath.row].description
            vc.titleString = items[indexPath.row].title
            vc.webURLString = items[indexPath.row].url
            vc.imageString = items[indexPath.row].urlToImage
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
