//
//  EditProfileViewController.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit
import ColorCompatibility


struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}



final class EditProfileViewController: UIViewController {

    // MARK: - Properties
    
    private var models = [[EditProfileFormModel]]()
    
    
    // MARK: - UI
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorCompatibility.systemBackground
        // Table View
        view.addSubview(tableView)
        tableView.dataSource = self
        configureModels()
        tableView.tableHeaderView = createTableHeaderView()
        // Bar Buttons
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    // MARK: - Private Methods
    
    private func configureModels() {
        // name, usename, website, bio
        let section1Labels = ["Name", "Username", "Website", "Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section1.append(model)
        }
        models.append(section1)
        // email, phone, gender
        let section2Labels = ["Email", "Phone", "Gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        let size = header.height/1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width - size)/2, y: (header.height-size)/2, width: size, height: size))
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2.0
        if #available(iOS 13.0, *) {
            profilePhotoButton.tintColor = .label
        } else {
            // Fallback on earlier versions
        }
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        if #available(iOS 13.0, *) {
            profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        profilePhotoButton.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        } else {
            // Fallback on earlier versions
        }
        return header
    }
    
    
    // MARK: - Actions
    
    @objc private func didTapProfilePhotoButton() {
        
    }
    
    @objc private func didTapSave() {
        // Save info to database
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change profile picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionSheet, animated: true, completion: nil)
    }
    
}


extension EditProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private Info"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
}


extension EditProfileViewController: FormTableViewCellDelegate {
    
    func formTableViewCell(cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        // Update model
        print(updatedModel.value ?? "nil")
    }
    
    
}

