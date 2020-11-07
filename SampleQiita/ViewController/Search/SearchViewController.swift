//
//  SearchViewController.swift
//  SampleQiita
//
//  Created by sakiyamaK on 2020/11/07.
//

import UIKit

final class ItemsViewController: UIViewController {

  @IBOutlet private weak var searchBar: UISearchBar!
  private let cellID = "UITableViewCell"
  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
  }

  private var qiitaItems: [QiitaItemModel] = []
}

extension ItemsViewController: UISearchBarDelegate {
}

extension ItemsViewController: UITableViewDelegate {

}

extension ItemsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return qiitaItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
      fatalError()
    }

    let item = qiitaItems[indexPath.row]
    cell.textLabel?.text = item.title

    return cell
  }
}
