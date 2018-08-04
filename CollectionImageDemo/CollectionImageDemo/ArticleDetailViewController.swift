//
//  ArticleDetailViewController.swift
//  CollectionImageDemo
//
//  Created by Kirtan on 04/08/18.
//  Copyright © 2018 Kirtan. All rights reserved.
//

import UIKit
import SafariServices

struct ArticleDetails {
    var title : String
//    var desc : String
    var imgString : String
    var isUrl : Bool
    var cellID : String
    var isAuthor : Bool
    
    init(title : String, imgString : String, cellId : String, isUrl : Bool = false, isAuthor : Bool = false) { //, desc : String
        self.title = title
//        self.desc = desc
        self.imgString = imgString
        self.cellID = cellId
        self.isUrl = isUrl
        self.isAuthor = isAuthor
    }
}

class ArticleDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tblDetails : UITableView!
    
    var articleDetils : [ArticleDetails] = []
    
    var article : Articles = Articles()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tblDetails.tableFooterView = UIView()
        self.tblDetails.estimatedRowHeight = UITableViewAutomaticDimension;
        self.tblDetails.rowHeight = UITableViewAutomaticDimension
        self.articleDetils = self.prepareArticleDetails()
    }

    override func viewWillAppear(_ animated: Bool) {
//        self.title = ""
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func prepareArticleDetails() -> [ArticleDetails]{
        
        var arrOfDetils : [ArticleDetails] = []
        
        let imgCell :ArticleDetails = ArticleDetails.init(title: "", imgString: self.article.urlToImage, cellId: ImageTableViewCell.CELL_ID)
        
        let authorCell : ArticleDetails = ArticleDetails.init(title: self.article.author, imgString: "", cellId: AuthorTableViewCell.CELL_ID, isAuthor : true)
        
        let titleCell : ArticleDetails = ArticleDetails.init(title: self.article.title, imgString: "", cellId: TitleTableViewCell.CELL_ID)
        
        let descCell : ArticleDetails = ArticleDetails.init(title: self.article.desc, imgString: "", cellId: DescTableViewCell.CELL_ID)
        
        let publishAtCell : ArticleDetails = ArticleDetails.init(title: self.article.publishedAt, imgString: "", cellId: AuthorTableViewCell.CELL_ID)
        
        let linkCell : ArticleDetails = ArticleDetails.init(title: self.article.url, imgString: "", cellId: DescTableViewCell.CELL_ID, isUrl: true)
        
        
        arrOfDetils.append(imgCell)
        arrOfDetils.append(authorCell)
        arrOfDetils.append(titleCell)
        arrOfDetils.append(descCell)
        arrOfDetils.append(publishAtCell)
        arrOfDetils.append(linkCell)
        
        return arrOfDetils
    }
    
    //MARK:- Tableview methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleDetils.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellInfo = self.articleDetils[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellInfo.cellID, for: indexPath)
        
        switch cellInfo.cellID {
        case TitleTableViewCell.CELL_ID:
            (cell as! TitleTableViewCell).configureCellWith(articleDetail: cellInfo, indexPath: indexPath)
            break
        case ImageTableViewCell.CELL_ID:
            (cell as! ImageTableViewCell).configureCellWith(articleDetail: cellInfo, indexPath: indexPath)
            break
        case DescTableViewCell.CELL_ID:
            (cell as! DescTableViewCell).configureCellWith(articleDetail: cellInfo, indexPath: indexPath)
            break
        case AuthorTableViewCell.CELL_ID:
            (cell as! AuthorTableViewCell).configureCellWith(articleDetail: cellInfo, indexPath: indexPath)
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellInfo = self.articleDetils[indexPath.row]
        
        switch cellInfo.cellID {
        case DescTableViewCell.CELL_ID:
            if cellInfo.isUrl{
                if let url : URL = URL.init(string: cellInfo.title){
                    let svc = SFSafariViewController(url: url)
                    self.navigationController?.present(svc, animated: true, completion: nil)
                }
            }
            break
        default:
            break
        }
    }
}

//MARK:- Tableview Cell

class TitleTableViewCell : UITableViewCell{
    static let CELL_ID : String = "titleCell"
    
    @IBOutlet var lblTitle : UILabel!
    
    var articleDetail : ArticleDetails!
    var indexPath : IndexPath!
    
    func configureCellWith(articleDetail : ArticleDetails, indexPath : IndexPath){
        self.articleDetail = articleDetail
        self.indexPath = indexPath
        
        self.lblTitle.text = self.articleDetail.title
        
    }
}

class ImageTableViewCell : UITableViewCell{
    static let CELL_ID : String = "imageCell"
    
    @IBOutlet var imgView : UIImageView!
    
    var articleDetail : ArticleDetails!
    var indexPath : IndexPath!
    
    func configureCellWith(articleDetail : ArticleDetails, indexPath : IndexPath){
        self.articleDetail = articleDetail
        self.indexPath = indexPath
        
        self.imgView.sd_setImage(with: URL.init(string: self.articleDetail.imgString))
        
    }
}

class DescTableViewCell : UITableViewCell{
    static let CELL_ID : String = "descCell"
    
    @IBOutlet var lblDesc : UILabel!
    
    var articleDetail : ArticleDetails!
    var indexPath : IndexPath!
    
    func configureCellWith(articleDetail : ArticleDetails, indexPath : IndexPath){
        self.articleDetail = articleDetail
        self.indexPath = indexPath
    
        self.lblDesc.textColor = self.articleDetail.isUrl ? .blue : .black
        
        self.lblDesc.text = self.articleDetail.title
    }
}

class AuthorTableViewCell : UITableViewCell{
    static let CELL_ID : String = "authorCell"
    
    @IBOutlet var lblTitle : UILabel!
    
    var articleDetail : ArticleDetails!
    var indexPath : IndexPath!
    
    func configureCellWith(articleDetail : ArticleDetails, indexPath : IndexPath){
        self.articleDetail = articleDetail
        self.indexPath = indexPath
        
        let str : String = self.articleDetail.isAuthor ? "Author:" : "published at:"
        self.lblTitle.text = "\(str) \(self.articleDetail.title)"
        
    }
}
