import SnapKit
import UIKit

final class LocationsView: UIView {

    // MARK: - Constants
    
    private enum Constants {
        static let tableViewContentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    // MARK: - Public properties
    
    let tableView = UITableView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

// MARK: - CommonInit

private extension LocationsView {
    func commonInit() {
        setConstraints()
        setUI()
    }
    
    func setConstraints() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setUI() {
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = Constants.tableViewContentInset
    }
}
