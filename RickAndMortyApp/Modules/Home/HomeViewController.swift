//
//  HomeViewController.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import UIKit

final class HomeViewController: UIViewController,
                                HomePresenterDelegate {    
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actLoading: UIActivityIndicatorView!
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor(named: "Neon-verde")
        return label
    }()
    
    var presenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showCollectionView(false)
        loadUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configUI()
    }
    
    private func loadUI() {
        presenter.loadCharacters()
    }
    
    private func configUI() {
        configCollectionView()
    }

    private func configCollectionView() {
        collectionView.indicatorStyle = .white
        collectionView.register(UINib(nibName: "CharacterCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CharacterCell")
    }
    
    // MARK: - HomePresenterDelegate
    
    func dataLoaded() {
        collectionView.reloadData()
    }
    
    func showCollectionView(_ show: Bool) {
        
        if show {
            UIView.animate(withDuration: 2.0) {
                self.collectionView.alpha = 1
            }
        }else {
            UIView.animate(withDuration: 2.0) {
                self.collectionView.alpha = 0
            }
        }
    }
    
    func showLoading(_ loading: Bool) {
        
        if loading {
            actLoading.startAnimating()
        }else {
            actLoading.stopAnimating()
        }
    }
    
    func showNotFoundMessage() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true

        let attributedString = Constants.Messages.NotFoundCharacters.withLink("aqui")
        self.label.attributedText = attributedString
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        self.loadUI()
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (
            width: (view.frame.size.width/2)-48,
            height: (view.frame.size.width/2)-42
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.presenter.numberOfRows == 0 {
            collectionView.backgroundView = label
        }else {
            collectionView.backgroundView = nil
        }
        return presenter.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        
        cell.loadUI(presenter.getCharacter(for: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showDetails(character: presenter.getCharacter(for: indexPath.item))
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        presenter.loadMoreCharacters(at: indexPath.item)
    }
}
