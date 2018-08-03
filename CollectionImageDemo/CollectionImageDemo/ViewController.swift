//
//  ViewController.swift
//  CollectionImageDemo
//
//  Created by Kirtan Parakhiya on 03/08/18.
//  Copyright © 2018 Kirtan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ContentDynamicLayoutDelegate {
    
    

    let stringUrl : String = "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=4fece3f3783044919c07b59b0d2f8d0e"
    
    var articlList : [Articles] = []
    var TOTAL_PADDING : CGFloat = 10
    var LABEL_PADDING : CGFloat = 8
    
    @IBOutlet var cvArticle : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layout: ContentDynamicLayout = PinterestStyleFlowLayout()
        layout.delegate = self
        layout.cellsPadding = ItemsPadding.init(horizontal: 5, vertical: 5)
        layout.contentPadding = ItemsPadding.init(horizontal: 5, vertical: 5)
        
        self.cvArticle.collectionViewLayout = layout
        self.cvArticle.setContentOffset(CGPoint.zero, animated: false)
        
        self.getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func getData(){
        NetworkManager.shared.sendHTTPGetMethod(strUrl: self.stringUrl) { (response, error) in
            if response != nil{
                if let data = response{
                    if let status = data["status"] as? String{
                        if status.lowercased() == "ok"{
                            if let articles = data["articles"] as? [[String:Any]]{
                                for article in articles{
                                    self.articlList.append(Articles().parseArticales(articaleDetails: article))
                                }
                            }
                        }else{//error
                            print(error!.localizedDescription)
                        }
                    }
                }
            }else{
                print(error!.localizedDescription)
            }
            self.cvArticle.reloadData()
        }
    }
    
    
    //MARK: - ContentDynamicLayoutDelegate
    func cellSize(indexPath: IndexPath) -> CGSize {
        let descHeight = self.articlList[indexPath.row].desc.heightForView(UIFont.systemFont(ofSize: 15), width: self.view.frame.width/2 - self.TOTAL_PADDING)
        return CGSize(width: self.view.frame.width/2 - self.TOTAL_PADDING, height: 100 + descHeight + self.LABEL_PADDING)
    }
    
    //MARK: - UICollectionView Delegate - DataSource
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //        print(CGSizeMake(self.frame.size.width/2 - 10, 100))
//
//        let descHeight = self.articlList[indexPath.row].desc.heightForView(UIFont.systemFont(ofSize: 15), width: self.view.frame.width/2 - 10)
//
//        return CGSize(width: self.view.frame.width/2 - 7.5, height: 100 + descHeight + 8);
//    }
    
    //MARK:- Collectionview Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articlList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ArticleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCollectionViewCell.CELLID, for: indexPath) as! ArticleCollectionViewCell
        cell.configureCellWith(article: self.articlList[indexPath.row], indexPath: indexPath)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

//MARK:- CollectionviewCell

class ArticleCollectionViewCell : UICollectionViewCell {
    static let CELLID : String = "articleCell"
    
    @IBOutlet var lblDesc : UILabel!
    @IBOutlet var imgView : UIImageView!
    
    var article : Articles!
    var indexPath : IndexPath!
    
    func configureCellWith(article : Articles, indexPath : IndexPath){
        
        self.article = article
        self.indexPath = indexPath
        
        self.lblDesc.text = self.article.desc
        self.imgView.sd_setImage(with: URL.init(string: self.article.urlToImage))
    }
    
}

extension String{
    func heightForView(_ font : UIFont, width:CGFloat, numberOfLines: Int = 0) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        
        label.sizeToFit()
        return label.frame.height
    }
}
