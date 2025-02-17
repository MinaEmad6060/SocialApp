import UIKit
import Combine
import Kingfisher

class PhotoDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var btnShareOutlet: UIButton!
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private var imageURL: String
    
    //MARK: - INITIALIZER
    init(imageURL: String) {
        self.imageURL = imageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle-Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewcontroller()
    }
    
    // MARK: - Functions
    private func initViewcontroller() {
        addPinchGesture()
        setupViews()
        bindTapOnShareButton()
    }
    
    private func setupViews() {
        btnShareOutlet.layer.cornerRadius = 8
        photoImageView.kf.setImage(
            with: URL(string: imageURL),
            completionHandler: { [weak self] result in
                guard let self = self else { return }
                if case .failure(_) = result {
                    photoImageView.image = UIImage(named: "noImage")
                }
            }
        )
    }
    
    private func bindTapOnShareButton() {
        btnShareOutlet.tapPublisher
            .sink { [weak self] in
                self?.shareImage()
            }
            .store(in: &cancellables)
    }
    
    private func shareImage() {
        guard let image = photoImageView.image else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = btnShareOutlet
            popoverController.sourceRect = btnShareOutlet.bounds
        }
        
        present(activityViewController, animated: true)
    }

}


// MARK: - Enable-Image-Zooming
extension PhotoDetailsViewController {
    private func addPinchGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(pinchGesture)
    }
    
    @objc private func handlePinch(_ sender: UIPinchGestureRecognizer) {
        guard let view = sender.view else { return }
        view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
    }
}
