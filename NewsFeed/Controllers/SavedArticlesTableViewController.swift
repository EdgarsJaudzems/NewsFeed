//
//  SavedArticlesTableViewController.swift
//  NewsFeed
//
//  Created by Edgars Jaudzems on 14/02/2021.
//

import UIKit


class SavedArticlesTableViewController: UITableViewController {

    var items: [Item] = []
//    var savedItems: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "savedFeedCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }

        let feed = items[indexPath.row]
        cell.setUI(with: feed)
        cell.showImage(with: feed)
        cell.selectionStyle = .none
        
        return cell
    }
}
