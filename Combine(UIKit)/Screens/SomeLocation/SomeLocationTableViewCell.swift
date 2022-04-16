import UIKit
import SnapKit
import Combine

final class SomeLocationTableViewCell: UITableViewCell, ViewModelBindable, ReactiveReusable {
    
    // MARK: - TypeAlias
    
    typealias Unit = SomeLocationTableViewCellUnit
    typealias ViewModel = Unit.ViewModel
    
    // MARK: - Constants
    
    private enum Constants {
        static let locationDescriptionStackViewSpacing = CGFloat(16)
        static let contentStackViewSpacing = CGFloat(16)
        static let contentStackViewInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static let locationImageViewSize = CGSize(width: 100, height: 100)
        static let buttonHeight = CGFloat(56)
    }
    
    // MARK: - Private properties
    
    private var subscriptions = Set<AnyCancellable>()
    private let locationImageView = UIImageView()
    private let nameLabel = UILabel()
    private let button = UIButton()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

// MARK: - Life cycle

extension SomeLocationTableViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()
        reuse()
    }
}

// MARK: - Implement ViewModelBindable

extension SomeLocationTableViewCell {
    func bind(viewModel: ViewModel) {
        let input = ViewModel.Input(
            tap: button.publisher(for: .touchUpInside).map { _ in }.eraseToAnyPublisher()
        )
        let output = viewModel.transform(input: input)
        
        subscriptions = [
            output.image.assign(to: \.image, on: locationImageView),
            output.name.assign(to: \.text, on: nameLabel),
            output.empty.sink(receiveValue: {})
        ]
    }
}

// MARK: - Common init

private extension SomeLocationTableViewCell {
    func commonInit() {
        setConstraints()
        localize()
        setUI()
    }
    
    func setConstraints() {
        let locationDescriptionStackView = UIStackView(arrangedSubviews: [locationImageView, nameLabel]).apply {
            $0.axis = .horizontal
            $0.spacing = Constants.locationDescriptionStackViewSpacing
            $0.alignment = .center
        }
        let contentStackView = UIStackView(arrangedSubviews: [locationDescriptionStackView, button]).apply {
            $0.axis = .vertical
            $0.spacing = Constants.contentStackViewSpacing
        }
        contentView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.contentStackViewInset)
        }
        locationImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.locationImageViewSize)
        }
        button.snp.makeConstraints {
            $0.height.equalTo(Constants.buttonHeight)
        }
    }
    
    func localize() {
        button.setTitle("Tap me", for: [])
    }

    func setUI() {
        button.backgroundColor = .blue
    }
}

// MARK: - Implement ReactiveReusable

extension SomeLocationTableViewCell {
    func reuse() {
        subscriptions.removeAll()
    }
}
