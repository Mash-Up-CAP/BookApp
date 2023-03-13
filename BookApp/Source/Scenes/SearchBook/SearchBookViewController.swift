//
//  SearchBookViewController.swift
//  BookApp
//
//  Created by Julia on 2023/03/07.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchBookDisplayLogic: AnyObject {
    func displayFetchBooks(viewModel: SearchBook.FetchBooks.ViewModel)
    func displayFetchBooksError(viewModel: SearchBook.FetchBooks.ViewModel.Error)
}

final class SearchBookViewController: UIViewController, SearchBookDisplayLogic
{
  var interactor: SearchBookBusinessLogic?
  var router: (NSObjectProtocol & SearchBookRoutingLogic & SearchBookDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = SearchBookInteractor()
    let presenter = SearchBookPresenter()
    let router = SearchBookRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
    
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
      super.viewDidLoad()
      self.setUpNavigation()
      self.fetchBooks(title: "love", startIndex: 0) // 임시로 값 테스트
      self.configureTableView()
  }

    private func setUpNavigation() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "원하는 도서를 검색하세요."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        self.navigationItem.title = "도서 검색"
        self.navigationItem.searchController = searchController
    }
    
    private func configureTableView() {
        self.bookListTableView.dataSource = self
        self.bookListTableView.delegate = self
    }

    // MARK: - UIComponent
    @IBOutlet private weak var bookListTableView: UITableView!
    private var displayedBooks: [SearchBook.FetchBooks.ViewModel.DisplayedBook] = []
  
    private func fetchBooks(title: String, startIndex: Int) {
        let request = SearchBook.FetchBooks.Request(title: title, startIndex: startIndex)
        self.interactor?.fetchBooks(request: request)
    }

    func displayFetchBooks(viewModel: SearchBook.FetchBooks.ViewModel) {
        DispatchQueue.main.async {
            self.displayedBooks = viewModel.displayedBooks
            self.bookListTableView.reloadData()
        }
    }
    
    func displayFetchBooksError(viewModel: SearchBook.FetchBooks.ViewModel.Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "\(viewModel.message)", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension SearchBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: SearchBookCell.self, for: indexPath)
        let displayedBook = self.displayedBooks[indexPath.row]
        cell.configure(displayedBook)
        return cell
    }
    
}

extension SearchBookViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.bookListTableView.reloadData()
        self.bookListTableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        self.bookListTableView.isHidden = true
        // TODO: 검색결과 데이터 다시 빈 값들로
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO: 검색 할 때마다 request 보냄
    }
}

extension SearchBookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let router = router {
            router.routeToDetailBooks(indexPath.row)
        }
    }
}

