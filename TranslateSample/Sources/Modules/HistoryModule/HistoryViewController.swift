//
//  HistoryViewController.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 19.11.2021.
//

import UIKit
import CoreData

protocol HistoryViewProtocol: AnyObject {
    
}

final class HistoryViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private enum Constant {
        static let mainBackgroundColor: UIColor = .mainBackgroundColor
    }
    
    private var translationsTableView = UITableView()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<DBTranslate> = {
            let fetchRequest: NSFetchRequest<DBTranslate> = DBTranslate.fetchRequest()
            fetchRequest.fetchBatchSize = 30
            let sortDescriptor = NSSortDescriptor(key: "original", ascending: true)
        
            fetchRequest.sortDescriptors = [sortDescriptor]
            fetchRequest.includesPendingChanges = false

            let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: CoreDataManager.shared.container.viewContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
            do {
                try fetchedResultsController.performFetch()
            } catch {
                let fetchError = error as NSError
                print("\(fetchError), \(fetchError.localizedDescription)")
            }
            return fetchedResultsController
    }()

    // MARK: - LIfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        title = "History"
        view.backgroundColor = Constant.mainBackgroundColor
        view.addSubview(translationsTableView)
        translationsTableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        translationsTableView.dataSource = self
        translationsTableView.delegate = self
        translationsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        let translationsTableViewConstraints = [translationsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                                translationsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                                translationsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                                translationsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)]
        
        NSLayoutConstraint.activate(translationsTableViewConstraints)
    }
}

// MARK: - HistoryViewProtocol

extension HistoryViewController: HistoryViewProtocol {
    
}

// MARK: - UITableViewDataSource

extension HistoryViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.fetchedResultsController.sections else {
            return 1
        }
        let  sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        
        let translation = self.fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = translation.original
        cell.detailTextLabel?.text = translation.translated
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
