//
//  LaunchDetailsViewController.swift
//  SpaceXAppDemo
//
//  Created by Javier Vazquez on 09/08/23.
//

import UIKit
import AlamofireImage
import YouTubePlayerKit

class LaunchDetailsViewController: UIViewController {
    var launch: Launch
    
    init(launch: Launch) {
        self.launch = launch
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageCarousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        return collectionView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let launchSiteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let rocketIDLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let watchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Watch on YouTube", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(watchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let moreInfoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("More Info", for: .normal)
        button.backgroundColor = .systemGray
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        populateData()
    }
    
    private func setupUI() {
        imageCarousel.dataSource = self
        imageCarousel.delegate = self

        view.addSubview(stackView)
        stackView.addArrangedSubview(imageCarousel)
        stackView.addArrangedSubview(rocketNameLabel)
        stackView.addArrangedSubview(rocketIDLabel)
        stackView.addArrangedSubview(launchSiteLabel)
        stackView.addArrangedSubview(detailsLabel)
        stackView.addArrangedSubview(watchButton)
        stackView.addArrangedSubview(moreInfoButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            imageCarousel.topAnchor.constraint(equalTo: stackView.topAnchor),
            imageCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageCarousel.heightAnchor.constraint(equalToConstant: view.bounds.width/2),
            
            launchSiteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            launchSiteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            watchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            watchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            moreInfoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            moreInfoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        watchButton.layer.cornerRadius = 12
        moreInfoButton.layer.cornerRadius = 12
    }
    
    private func populateData() {
        rocketNameLabel.text = launch.rocket.rocketName
        launchSiteLabel.text = "Launch Site: \(launch.launchSite.siteNameLong)"
        rocketIDLabel.text = "Rocket ID: \(launch.rocket.rocketID ?? "")"
        detailsLabel.text = launch.details
        imageCarousel.isHidden = launch.links.flickrImages.isEmpty
    }
    
    @objc private func watchButtonTapped() {
        let configuration = YouTubePlayer.Configuration(fullscreenMode: .system,
                                                        autoPlay: true,
                                                        showControls: true)
        
        let source: YouTubePlayer.Source? = !launch.links.youtubeID.isEmpty ?
            .video(id: launch.links.youtubeID) :
            .url(launch.links.videoLink)
        let youTubePlayerViewController = YouTubePlayerViewController(player: YouTubePlayer(source: source,
                                                                                            configuration: configuration))
        self.present(youTubePlayerViewController, animated: true)
    }
    
    @objc private func closeButtonTapped() {
        if let url = URL(string: launch.links.wikipedia ?? "") {
            let webController = WebViewController(url: url)
            navigationController?.pushViewController(webController, animated: true)
        }
    }
}

extension LaunchDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launch.links.flickrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell ?? ImageCollectionViewCell()
        if let url = URL(string: launch.links.flickrImages[indexPath.item]) {
            cell.imageView.af.setImage(withURL: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCarousel.frame.width, height: imageCarousel.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let centerPoint = CGPoint(x: scrollView.contentOffset.x + scrollView.bounds.width / 2, y: scrollView.bounds.height / 2)
        if let indexPath = imageCarousel.indexPathForItem(at: centerPoint) {
            imageCarousel.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
