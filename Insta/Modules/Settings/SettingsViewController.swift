//
//  SettingsViewController.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit
import Combine

struct SettingCellModel {
    let title: String
    let handler: () -> Void
}

enum SettingsURLType {
    case terms, privacy, help
}

final class SettingsViewController: UIViewController {

    // MARK: - Properties
    
    private var data = [[SettingCellModel]]()
    
    private weak var tableView: UITableView!
    
    private let viewModel: SettingsViewModel
    private var router: SettingsRouter!
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = SettingsView()
        self.view = view
        self.tableView = view.tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        configureRouter()
        configureNavigationBar()
        configureViews()
        configureBindings()
    }
    
    // MARK: - Configure
    
    private func configureRouter() {
        router = SettingsRouter(viewController: self)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Settings"
    }
    
    private func configureViews() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureBindings() {
        viewModel.logOutSuccess
            .sink { [weak self] in
                if $0 {
                    self?.router.showLogin()
                }
            }
            .store(in: &subscriptions)
    }
    
    private func configureModels() {
        data.append([
            SettingCellModel(title: "Edit Profile", handler: { [weak self] in
                self?.didTapEditProfile()
            }),
            SettingCellModel(title: "Invite Friends", handler: { [weak self] in
                self?.didTapInviteFriends()
            }),
            SettingCellModel(title: "Save Original Posts", handler: { [weak self] in
                self?.didTapSaveOriginalPosts()
            })
        ])
        data.append([
            SettingCellModel(title: "Terms of Service", handler: { [weak self] in
                self?.openURL(type: .terms)
            }),
            SettingCellModel(title: "Privacy Policy", handler: { [weak self] in
                self?.openURL(type: .privacy)
            }),
            SettingCellModel(title: "Help & Feedback", handler: { [weak self] in
                self?.openURL(type: .help)
            })
        ])
        data.append([
            SettingCellModel(title: "Log Out", handler: { [weak self] in
                self?.didTapLogOut()
            })
        ])
    }
    
    // MARK: - Actions

    private func didTapEditProfile() {
        self.router.showEditProfile()
    }
    
    private func didTapInviteFriends() {
        // Show share sheet to invite friends
    }
    
    private func didTapSaveOriginalPosts() {
        
    }
    
    private func openURL(type: SettingsURLType) {
        self.router.openURL(type: type)
    }
    
    private func didTapLogOut() {
        showAlert(
            title: "Log Out",
            message: "Are you sure you want to log out?",
            preferredStyle: .actionSheet,
            actions: [
                UIAlertAction(title: "Cancel", style: .cancel),
                UIAlertAction(title: "OK", style: .destructive) { [weak self] _ in
                    guard let self = self else { return }
                    self.viewModel.logOut()
                }
            ]
        )
    }
    
}

// MARK: - TableView Methods

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // handle cell selection
        data[indexPath.section][indexPath.row].handler()
    }
}
