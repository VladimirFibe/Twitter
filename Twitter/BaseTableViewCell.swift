import UIKit

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(style: .default, reuseIdentifier: "")
        setupViews()
    }
}

@objc extension BaseTableViewCell {
    func setupViews() {}
}
