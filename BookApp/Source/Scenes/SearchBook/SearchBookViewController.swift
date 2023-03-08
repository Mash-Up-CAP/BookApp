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

protocol SearchBookDisplayLogic: AnyObject
{
  func displaySomething(viewModel: SearchBook.FetchBooks.ViewModel)
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
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
    setUpNavigation()
  }

  // MARK: UIComponent
    @IBOutlet private weak var bookListTableView: UITableView!
    
    
  
  func doSomething()
  {
    let request = SearchBook.FetchBooks.Request()
    interactor?.fetchBooks(request: request)
  }
  
  func displaySomething(viewModel: SearchBook.FetchBooks.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}
