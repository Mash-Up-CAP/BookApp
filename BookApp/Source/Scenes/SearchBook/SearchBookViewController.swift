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
import SnapKit
import Combine

@MainActor
protocol SearchBookDisplayLogic: AnyObject {
    func displayFetchBookList(viewModel: SearchBook.FetchBookList.ViewModel)
    func displayFetchBookListError(viewModel: SearchBook.FetchBookList.ViewModel.Error)
}

final class SearchBookViewController: UIViewController, SearchBookDisplayLogic {
    
    var interactor: SearchBookBusinessLogic?
    var router: (SearchBookRoutingLogic & SearchBookDataPassing)?
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
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
    
    // MARK: - UIComponent
    
    private lazy var noResultFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과가 없습니다."
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .gray
        label.isHidden = true
        return label
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .darkGray
        indicator.isHidden = true
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var bookListTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 120
        tableView.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.register(SearchBookCell.self)
        return tableView
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLayout()
        self.setUpNavigation()
        self.view.bringSubviewToFront(self.indicatorView)
    }
    
    private func setUpLayout() {
        [self.noResultFoundLabel, self.indicatorView, self.bookListTableView].forEach { view in
            self.view.addSubview(view)
        }
        
        self.noResultFoundLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        self.indicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.bookListTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private var searchSubscriber: AnyCancellable?

    private func setUpNavigation() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "원하는 도서를 검색하세요."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchSubscriber = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
                 .map({ ($0.object as? UISearchTextField)?.text })
                 .compactMap({ $0 })
                 .filter { $0.count > 1 }
                 .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                 .sink { [weak self] searchText in
                     self?.fetchBooks(title: searchText, startIndex: 0)
                 }

        self.navigationItem.title = "도서 검색"
        self.navigationItem.searchController = searchController
    }
    
    private func fetchBooks(title: String, startIndex: Int) {
        self.indicatorView.isHidden = false
        self.indicatorView.startAnimating()
        let request = SearchBook.FetchBookList.Request(title: title, startIndex: startIndex)
        self.interactor?.fetchBookList(request: request)
    }
    
    private func fetchNextPageBooks() {
        self.scrollIndex += 1
        self.fetchBooks(title: self.searchText, startIndex: self.scrollIndex)
    }
    
    // MARK: - Display Logic
    
    private var scrollIndex: Int = 0
    private var searchText: String = ""
    private var displayedBooks: [SearchBook.FetchBookList.ViewModel.DisplayedBook] = [] {
        didSet {
            self.indicatorView.isHidden = true
            self.bookListTableView.isHidden = self.displayedBooks.isEmpty
            self.bookListTableView.reloadData()
        }
    }

    func displayFetchBookList(viewModel: SearchBook.FetchBookList.ViewModel) {
        self.displayedBooks.append(contentsOf: viewModel.displayedBookList)
        if viewModel.displayedBookList.isEmpty {
            self.noResultFoundLabel.isHidden = false
        }
    }
    
    func displayFetchBookListError(viewModel: SearchBook.FetchBookList.ViewModel.Error) {
        let alert = UIAlertController(title: "\(viewModel.message)", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

extension SearchBookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let router = router {
            router.routeToDetailBooks(indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            self.fetchNextPageBooks()
        }
    }
}

extension SearchBookViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.displayedBooks = []
        self.noResultFoundLabel.isHidden = true
        if !searchText.isEmpty {
            self.bookListTableView.isHidden = false
            self.searchText = searchText
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.displayedBooks = []
    }
}

