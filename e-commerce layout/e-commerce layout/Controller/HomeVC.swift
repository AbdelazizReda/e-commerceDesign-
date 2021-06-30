//
//  HomeVC.swift
//  e-commerce layout
//
//  Created by عبدالعزيز رضا  on 6/3/21.
//

import UIKit

class HomeVC: UIViewController {
    //outlets
    @IBOutlet weak var HomeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
   
    //Setup for any UI
    fileprivate func setupUI() {
        HomeCollectionView.dataSource = self
        HomeCollectionView.delegate = self
        self.HomeCollectionView.register(UINib(nibName: "HomeCells", bundle: nil), forCellWithReuseIdentifier: "HomeCells")
        
        HomeCollectionView.register(UINib(nibName: "headerView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "headerView")
        HomeCollectionView.collectionViewLayout = creatCompositionalLayout()
    }
    
    
    
    
    //composition layout data
    func creatCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { [weak self](index , evnvironemt) -> NSCollectionLayoutSection?in
            return self!.creatSectionFor(index: index, environment: evnvironemt )
        }
        
        return layout
    }
    
    func creatSectionFor(index:Int , environment:NSCollectionLayoutEnvironment) ->NSCollectionLayoutSection{
        
        switch index {
        case 0:
            return creatFirstSection()
        case 1:
            return creatSecondSection()
        case 2:
            return creatThirdSection()
        default:
            return creatFirstSection()
        }
        
    }
    
    
    
    
    
    //MARK:First Section
    func creatFirstSection() -> NSCollectionLayoutSection{
        let inset:CGFloat = 2.5
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
    
        return section
        
    }
    
    //MARK:Second Section
    func creatSecondSection() -> NSCollectionLayoutSection{
        let inset:CGFloat = 2.5
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        //group
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        //headers
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
    
    
    //MARK:Third Section
    func creatThirdSection() -> NSCollectionLayoutSection{
        let inset:CGFloat = 2.5
        //smallItem in collection
        let smallitemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let smallitem = NSCollectionLayoutItem(layoutSize: smallitemSize)
        smallitem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        //largItem in collection
        let largitemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let largitem = NSCollectionLayoutItem(layoutSize: largitemSize)
        largitem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        //group
        
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
        let VerticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [smallitem])
        let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4))
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [largitem,VerticalGroup,VerticalGroup])
        
        
        //section
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        
        //headers
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
    
    
    
}


//MARK:- Collection View delegation Methods
extension HomeVC:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 2 ? 15:5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCells", for: indexPath)
        cell.backgroundColor = .systemGray2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "headerView", for: indexPath) as? headerView else{
            return UICollectionReusableView()
        }
        view.title = indexPath.section == 1 ? "Recently" : "Browse by Category"
        return view
    }
    
}
