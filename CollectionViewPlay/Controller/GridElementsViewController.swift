//
//  GridElementsViewController.swift
//  CollectionViewPlay
//
//  Created by vinmac on 16/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import UIKit

class GridElementsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: IBActions
    @IBAction private func btnOperation1Tapped(_ sender: UIButton) {
        self.addThreeElementsToEndOfItemsArray()
    }
    
    @IBAction private func btnOperation2Tapped(_ sender: UIButton) {
        self.removeThreeElementsFromEndOfItemsArray()
    }
    
    @IBAction private func btnOperation3Tapped(_ sender: UIButton) {
        self.updateItemAtSecondPosition()
    }
    
    @IBAction private func btnOperation4Tapped(_ sender: UIButton) {
        self.moveElementEToTheEnd()
    }
    
    @IBAction private func btnOperation5Tapped(_ sender: UIButton) {
        self.removeThreeFromBeginningOfItemsArray()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.addThreeElementsToEndOfItemsArray()
        }
    }
    
    @IBAction private func btnOperation6Tapped(_ sender: UIButton) {
        self.addThreeElementsToEndOfItemsArray()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.removeThreeFromBeginningOfItemsArray()
        }
    }
    
    @IBAction private func btnSettingsTapped(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {return }
        vc.delegate = self
        vc.animationSpeed = self.animationSpeed
        vc.elementSize = self.cellSizeCopy
        vc.spacing = self.cellSpacing
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: Default values
    private var cellSpacing: CGFloat = 10
    private var cellSize: CGFloat = 50
    private var cellSizeCopy: CGFloat = 1
    private var animationSpeed: Double = 1
    private var itemsNameArr = [Character]()
    
    // MARK: View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.charactersFormation()
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: self.cellSize, height: self.cellSize)
        }
        self.cellSizeCopy = self.cellSize
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIApplication.shared.statusBarOrientation.isLandscape {
            self.cellSize = self.cellSizeCopy * CGFloat(1.5)
        } else {
            self.cellSize = self.cellSizeCopy
        }
        self.collectionView.collectionViewLayout.invalidateLayout()
        DispatchQueue.main.async {
            // your stuff here executing after collectionView has been layouted
            if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.itemSize = CGSize(width: self.cellSize , height: self.cellSize)
            }
        }
    }
    
    // MARK: Private methods
    private func charactersFormation() {
        for i in 97..<97+26 {
            // Convert Int to a UnicodeScalar.
            let u = UnicodeScalar(i)
            // Convert UnicodeScalar to a Character.
            let char = Character(u!)
            self.itemsNameArr.append(char)
        }
    }
    
    private func addThreeElementsToEndOfItemsArray() {
        let lastCharacterAsString = (self.itemsNameArr.count > 0) ? "\(self.itemsNameArr[self.itemsNameArr.count - 1])" : "z"
        if var intValue = Character(lastCharacterAsString).asciiValue {
            for _ in 0..<3 {
                if intValue >= 97-1+26{
                    intValue -= 26
                }
                let u = UnicodeScalar(intValue+1)
                let char = Character(u)
                self.itemsNameArr.append(char)
                intValue += 1
                
                UIView.animate(withDuration: self.animationSpeed, animations: {
                    self.collectionView.insertItems(at: [IndexPath(row: self.itemsNameArr.count-1, section: 0)])
                })
            }
        }
    }
    
    private func moveElementEToTheEnd() {
        var indexForE = -1
        for index in 0..<self.itemsNameArr.count {
            if self.itemsNameArr[index] == "e" {
                indexForE = index
                break
            }
        }
        if indexForE != -1 && indexForE != self.itemsNameArr.count-1{
            self.itemsNameArr.remove(at: indexForE)
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionView.deleteItems(at: [IndexPath(row: indexForE, section: 0)])
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.itemsNameArr.append("e")
                UIView.animate(withDuration: self.animationSpeed, animations: {
                    self.collectionView.insertItems(at: [IndexPath(row: self.itemsNameArr.count-1, section: 0)])
                })
            }
        }
    }
    
    private func removeThreeElementsFromEndOfItemsArray() {
        if self.itemsNameArr.count >= 3 {
            let itemsCount = self.itemsNameArr.count
            for _ in 0..<3 {
                self.itemsNameArr.remove(at: self.itemsNameArr.count - 1)
            }
            UIView.animate(withDuration: self.animationSpeed, animations: {
                self.collectionView.deleteItems(at: [IndexPath(row: itemsCount - 1, section: 0), IndexPath(row: itemsCount - 2, section: 0), IndexPath(row: itemsCount - 3, section: 0)])
            })
        }
    }
    
    private func updateItemAtSecondPosition() {
        if self.itemsNameArr.count>2 {
            self.itemsNameArr[2] = "!"
            if let cell = self.collectionView.cellForItem(at: IndexPath(row: 2, section: 0)) as? GridCell {
                cell.alpha = 0
                cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                UIView.animate(withDuration: self.animationSpeed) {
                    cell.alpha = 1
                    cell.transform = .identity
                    cell.lblItemName.text = "!"
                }
            }
        }
    }
    
    private func removeThreeFromBeginningOfItemsArray() {
        if self.itemsNameArr.count >= 3 {
            for _ in 0..<3 {
                self.itemsNameArr.remove(at: 0)
            }
            UIView.animate(withDuration: self.animationSpeed, animations: {
                self.collectionView.deleteItems(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0), IndexPath(row: 2, section: 0)])
            })
        }
    }
}

//MARK: Collection view delegate methods
extension GridElementsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemsNameArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else {return UICollectionViewCell()}
        cell.lblItemName.text = "\(self.itemsNameArr[indexPath.row])"
        if UIApplication.shared.statusBarOrientation.isLandscape {
            self.cellSize = self.cellSizeCopy * CGFloat(1.5)
        } else {
            self.cellSize = self.cellSizeCopy
        }
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: self.cellSize , height: self.cellSize)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = self.collectionView.cellForItem(at: indexPath) as? GridCell {
            UIView.transition(with: cell.myView, duration: self.animationSpeed, options: .transitionFlipFromTop, animations: nil, completion: { _ in
                if indexPath.row < self.itemsNameArr.count {
                    self.itemsNameArr.remove(at: indexPath.row)
                    cell.myView.isHidden = true
                    self.collectionView.deleteItems(at: [IndexPath(row: indexPath.row, section: 0)])
                    cell.myView.isHidden = false
                }
            })
        }
    }
}

extension GridElementsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellSpacing
    }
}

extension GridElementsViewController: SettingsDataDelegate {
    func setSettingsData(animationSpeed: Double, elementSize: Double, spacingBetweenElements: Double) {
        self.animationSpeed = animationSpeed
        self.cellSize = CGFloat(elementSize)
        self.cellSpacing = CGFloat(spacingBetweenElements)
        self.cellSizeCopy = self.cellSize
        self.collectionView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}
