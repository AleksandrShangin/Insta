//
//  FormTableViewCell.swift
//  Insta
//
//  Created by Alex on 3/28/21.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel)
}

final class FormTableViewCell: UITableViewCell, UITextFieldDelegate {

    // MARK: - Properties
    
    static let identifier = "FormTableViewCell"
    
    private var model: EditProfileFormModel?
    
    public weak var delegate: FormTableViewCellDelegate?
        
    // MARK: - UI
    
    private let formlabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formlabel)
        contentView.addSubview(textField)
        textField.delegate = self
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: EditProfileFormModel) {
        self.model = model
        formlabel.text = model.label
        textField.placeholder = model.placeholder
        textField.text = model.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formlabel.text = nil
        textField.placeholder = nil
        textField.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Assign frames
        formlabel.frame = CGRect(x: 5, y: 0, width: contentView.width/3, height: contentView.height)
        textField.frame = CGRect(x: formlabel.right + 5, y: 0, width: contentView.width - 10 - formlabel.width, height: contentView.height)
    }
    
    
    // MARK: - TextField
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else {
            return true
        }
        delegate?.formTableViewCell(cell: self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
    
    
}
