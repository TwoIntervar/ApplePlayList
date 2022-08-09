//
//  ViewController.swift
//  Mapli
//
//  Created by woo0 on 2022/07/22.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak private var collectionView: UICollectionView!
    let myPlayListModelManager = MyPlayListModelManager.shared
    
    override func viewDidLoad() {
		super.viewDidLoad()
		setupNavigatoinBar()
        setupCollectionView()
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

	private func setupNavigatoinBar() {
		let backButton = UIBarButtonItem()
		backButton.title = "이전"
		navigationItem.backBarButtonItem = backButton
		navigationController?.navigationBar.backIndicatorImage = UIImage()
		navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
		navigationController?.navigationBar.tintColor = .red
	}

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // Cell의 개수가 몇개?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if myPlayListModelManager.myPlayListModelArray.count == 0 {
            let label = UILabel()
            label.text = "나만의 플레이리스트를\n추가해주세요.\n\n\n\n\n"
            label.numberOfLines = 7
            label.textAlignment = .center
            label.textColor = .gray
            collectionView.backgroundView = label
            return 0
        } else {
            return myPlayListModelManager.myPlayListModelArray.count
        }
    }
    
    // Cell이 무엇인가?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell {
            
            DispatchQueue.main.async {
                let myPlayList = self.myPlayListModelManager.myPlayListModelArray[indexPath.item]
                let imageName = myPlayList.titleImageName
                cell.imageView.image = ImageDataManager.shared.fetchImage(named: imageName)
                cell.pliName.text = myPlayList.title
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = myPlayListModelManager.myPlayListModelArray[indexPath.item]
        let storyBoard = UIStoryboard(name: "PlayListDetailedScreen", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "MyPlayListDetailedScreenViewController") as? MyPlayListDetailedScreenViewController else { return }
        viewController.myPlayListModel = model
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    // Cell 모양 어떻게 할래?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let cellHorizontalSpace = DeviceSize.playlistSpacing
        let cellWidth = ((collectionViewWidth - CGFloat(cellHorizontalSpace)) / 2)
        let cellHeight = cellWidth + 25
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
