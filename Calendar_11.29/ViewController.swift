//
//  ViewController.swift
//  Calendar_11.29
//
//  Created by 조우현 on 2019/11/29.
//  Copyright © 2019 조우현. All rights reserved.
//
import Foundation
import UIKit

extension Date{ //Date 라는 객체는 내용이지 기능을 넣는 곳은 캘린더가 되어야 한다.
    func getCurrentDate() -> Int {
        let calendar = Calendar.current
        var rightNow = Date()
        
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        _ = calendar.date(from: dateComponents)!
        
        let day = calendar.component(.day, from: rightNow)
        
        return day
    }
    
    func getCurretDayOfDate() ->  Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    func startOfMonth() -> Date { //Date 객체 보내기.....
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    func endOfMonth() -> Date { //Date 객체보내기...
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
        //달을 한달을 넘기고 하루 뒤에 데이터를 뽑아서 전달의 데이터를 뽑는다.
    }//Create date from Componenets
}

//MARK: - VIEW Ctonroller
class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
        var i: Int = 1
        var cellcount = 84;
        var fetchingMore = false
    
    var rightNow = Date()
    //var itemCount: Int
    override func viewDidLoad() {
        super.viewDidLoad()
        let month = Calendar.current.component(.month, from: rightNow)
        title = String(month)
        
        //self.collectionView.scrollTo
        //self.collectionView.scrollToItem(at: IndexPath(item: 10 ,section:12), at: .right, animated: false)
        // Do any additional setup after loading the view.
        //해당주의 데이터를 뿌린다.
        /*let endOfMonth = Calendar.current.component(.day, from: Date().endOfMonth())
        let c: Int = endOfMonth/7
        for index in 1...(c+1){
            setCollectionItem(week: index)
        }*/
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView?.scrollToItem(at: IndexPath(row:1, section:12), at: UICollectionView.ScrollPosition.top, animated: true)
        //self.collectionView?.scrollToItem(at: IndexPath(item: 365 ,section:12), at: .top, animated: true)
    }
    // MARK: -  Fuction for a week

    var collectionItems = [String]()
    var collectionItems2 = [String]()
    var dic1: Dictionary = [String:Int]()

    //********** 추가되는 부분 ***************

    //콜렉션 뷰에 셀을 행에다가 7개씩 뿌린다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 7
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        //print(size)
        let sizeToWidth: Int = size
        let sizeToHeight: Int = sizeToWidth
        

        return CGSize(width: size, height: sizeToHeight )// CGSize(width: size, height: sizeToHeight)

    }
    
        // MARK: - CollectionView DataSource

        override func numberOfSections(in collectionView: UICollectionView) -> Int {
            //print(nextmonth)
            print("into section1")
            //let section = collectionView.dequ
            //nextmonth = Calendar.current.
            return 24
        }
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            let buf = Calendar.current.date(byAdding:.month, value: -12, to: Date())
            
            if section == 0{
                
                //let buf = Calendar.current.date(byAdding:.month, value: -12, to: Date())
                let endOfMonth = Calendar.current.component(.day, from: buf!.endOfMonth())
                let st = Calendar.current.component(.weekday, from: buf!.startOfMonth())
            print("2323")
            print(st)
            print(endOfMonth)
            return endOfMonth+st-1
                
            }else {
            
            let endOfMonth1 = Calendar.current.component(.day, from: buf!.endOfMonth())
            print(endOfMonth1)
            //let endOfMonthDate = Calendar.current.date(byAdding: .day, value: endOfMonth1, to: Date())
            let endOfMonthDate1 = Calendar.current.date(byAdding: .month, value: section, to: buf!)
            let endOfMonth = Calendar.current.component(.day, from: endOfMonthDate1!.endOfMonth())
                let st = Calendar.current.component(.weekday, from: endOfMonthDate1!.startOfMonth())
            print(endOfMonth)
            return endOfMonth+st-1
            //collectionView 와 section
            }
        }
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! CollectionViewCell
            var rightNow = Calendar.current.date(byAdding:.month, value: -12, to: Date())
            
            
            if indexPath.section == 0 {
            //print(indexPath.section)
            //let rightNow = Date()
        
            
                let startWeekday = Calendar.current.component(.weekday, from: rightNow!.startOfMonth())//첫날의 요일 값 숫자값
            let firstDay = Calendar.current.date(byAdding: .day , value: 1-startWeekday, to: rightNow!.startOfMonth()) // 달표시의 첫날
            let begin = Calendar.current.date(byAdding: .day, value: indexPath.row, to: firstDay!) //indexpath에 따라서 날짜가 진행되면서 뿌린다.
            
                let monthLabel = Calendar.current.component(.month, from: begin!)
                let monthLabelDate = Calendar.current.component(.month, from: rightNow!)
            
            if(monthLabel == monthLabelDate){
            var labelText = Calendar.current.component(.day, from: begin!) //UILable에 뿌리는 날짜값, 계산과는 상관없는 일자만 반복
                cell.DateLabel.text = String(labelText)
            }else{
                cell.DateLabel.text = " "
                }
            let cur = Calendar.current.component(.day, from: rightNow!) //현재날짜값 데이터
            
            let dateFormatter = DateFormatter() //
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            //dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            //dateFormatter.locale = Locale.init(identifier: "ko_Ko")
            //var dateString2 = dateFormatter.string(from: Date()) //현재 시간을 표시
            let dateString = dateFormatter.string(from: begin!) //포맷에 따른 date 객체
            let curMonth = Calendar.current.startOfDay(for: Date())
            
            
            
            cell.collectionViewButtons.setTitle(String(dateString), for: .normal) //
            cell.collectionViewButtons.setTitleColor(.white, for: .normal)
            cell.collectionViewButtons.backgroundColor = .white
            cell.collectionViewButtons.frame = CGRect(x: 0, y: 0, width: 80, height: 50)
            //cell.collectionViewButtons.systemLayoutSizeFitting(<#T##targetSize: CGSize##CGSize#>)
                //Frame 에는 CG Rect 만 대입 가능.
            
            cell.collectionViewButtons.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            //cell.DateLabel.text = String(labelText)// 레이블 출력
            let indexPath = IndexPath(row: cur-1, section: 0)//indexPath 는 0부터 시작
            cell.contentView.backgroundColor = .systemPink
            collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = .blue
            //self.tableView.insertRows(at: [indexPath], with: .right)
            //if (indexPath.row == labelText)
            //cell.DateLabel.bac
            //print("end cell")
            //print("indexPath value ")
            return cell
                
                
                
                
            } else {
      
            let endOfMonth1 = Calendar.current.component(.day, from: Date().endOfMonth()) //전달 달의 숫자를 가져옴
            let rightNow1 = Calendar.current.date(byAdding: .month, value: indexPath.section, to: rightNow!)
//                       let endOfMonth = Calendar.current.component(.day, from: endOfMonthDate!.endOfMonth())
//                       print(endOfMonth)
//                       return endOfMonth
//                rightNow =
//
            let nextMonth = Calendar.current.component(.month, from:rightNow1!)
            //print(nextMonth)
            //let rightNow = Date()
            //print("fdfd")
            //print(rightNow)
            
            
                let startWeekday = Calendar.current.component(.weekday, from: rightNow1!.startOfMonth())//첫날의 요일 값 숫자값
            print(startWeekday)
                let firstDay = Calendar.current.date(byAdding: .day , value: 1-startWeekday, to: rightNow1!.startOfMonth()) // 달표시의 첫날
            let begin = Calendar.current.date(byAdding: .day, value: indexPath.row, to: firstDay!) //indexpath에 따라서 날짜가 진행되면서 뿌린다.
            
                    let monthLabel = Calendar.current.component(.month, from: begin!)
                let monthLabelDate = Calendar.current.component(.month, from: rightNow1!)
                
            if(monthLabel == monthLabelDate){
                var labelText = Calendar.current.component(.day, from: begin!) //UILable에 뿌리는 날짜값, 계산과는 상관없는 일자만 반복
                    cell.DateLabel.text = String(labelText)
            }else{
                cell.DateLabel.text = " "
            }
                //let labelText = Calendar.current.component(.day, from: begin!) //UILable에 뿌리는 날짜값, 계산과는 상관없는 일자만 반복
            
            
            
            
            let cur = Calendar.current.component(.day, from: Date()) //현재날짜값 데이터
            //let date = Date()

            let dateFormatter = DateFormatter() //
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            //dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            //dateFormatter.locale = Locale.init(identifier: "ko_Ko")
            //var dateString2 = dateFormatter.string(from: Date()) //현재 시간을 표시

            let dateString = dateFormatter.string(from: begin!) //포맷에 따른 date 객체의

            
                let curMonth = Calendar.current.startOfDay(for: rightNow!)
            //print(curMonth)
            
            //print(indexPath.row)
            //print(indexPath.section)
            //print(self.collectionView.numberOfItems(inSection: 1))
            //print("pp")
            //print(self.collectionView.numberOfItems(inSection: 0))

            
            if(indexPath.row == self.collectionView.numberOfItems(inSection: 0)){
                print("index check")
            }
            
            
            cell.collectionViewButtons.setTitle(String(dateString), for: .normal) //
            cell.collectionViewButtons.setTitleColor(.white, for: .normal)
            cell.collectionViewButtons.backgroundColor = .white
            cell.collectionViewButtons.frame = CGRect(x: 0, y: 0, width: 80, height: 50)
            //cell.collectionViewButtons.systemLayoutSizeFitting(<#T##targetSize: CGSize##CGSize#>)
                //Frame 에는 CG Rect 만 대입 가능.
            
            cell.collectionViewButtons.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            //cell.DateLabel.text = String(labelText)// 레이블 출력
            let indexPath = IndexPath(row: cur-1, section: 0)//indexPath 는 0부터 시작
            cell.contentView.backgroundColor = .systemPink
            collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = .blue
            //self.tableView.insertRows(at: [indexPath], with: .right)
            //if (indexPath.row == labelText)
            //cell.DateLabel.bac
            //print("end cell")
            //print("indexPath value ")
            return cell
            }
            

        }
//강제로 cell의 라인과, 아이텝 별로 공간 주는 함수
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0
//    }
//item 숫자를 건드리니까 위에 item per indexpaht 값이 작동하지 않음.
//    func collectionView(_ collectionView: UICollectionView, layout
//        collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
    //MARK: Scroll controll
    //
    override func scrollViewDidScroll(_ scrollView: UIScrollView){
        print("Dfdfd")
        let offsetY = scrollView.contentOffset.y
        let contentHeight  = scrollView.contentSize.height
            //print("offsetY: \(offsetY) | contentHeight: \(contentHeight)")
        if offsetY > contentHeight - scrollView.frame.height{
            //i+=1
            //var indices: IndexSet = [1,2,3]
            //itemCount += 93
            //self.collectionView.insertSections(indices)
            //sself.collectionView.reloadData()
            //self.collectionView.insertSubview( , belowSubview: <#T##UIView#>)
//            print(offsetY)
//            print(contentHeight)
            //print("Dfdfd")
            print("beginBatchFetch!!")
            print(offsetY)
            print(contentHeight)
            if !fetchingMore   {
                beginBatchFetch()
                
            }
        }
            //print("beginBatchFetch!!")
    }

    func beginBatchFetch(){
        fetchingMore = true
        print("touch the bottom!")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.fetchingMore = false
            //let change = Calendar.current.date(byAdding: .day, value: 93, to: self.rightNow)
                //self.rightNow = change ?? <#default value#>
            //rightNow = Calendar.current.date(bySetting: .day, value: 93, of: .self)!
            self.collectionView.reloadData()
            
            
            
            
            
        })
//            //self.cellcount = self.cellcount + 120
//            let indexpath = IndexPath(row: self.cellcount, section: 1)
//            //self.collectionView.reloadSections(NSIndexSet(index: indexpath.section) as IndexSet)
            //self.collectionView.reloadData()
            
        //})
        //DispatchQueue.main.asyncAfter(
        //추가적으로 셀을 뿌리는 작업 해야 한다? 혹은 데이터 를 추가해야 한다.
        
    }
        
//        if offsetY > contentHeight - scrollView.frame.height {
//            if !fetchingMore{
//                beginBatchFetch()
//            }
//                //print("beginBatchFetch!")
//        }
//    }
//    func beginBatchFetch() {
//            fetchingMore = true
//        print("beginBatchFetch!")
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 , execute:  {})
//
//    }
        //********** 추가되는 부분 ***************
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // self.performSegue(withIdentifier: "SceneConnection", sender: nil)
            if segue.identifier == "SceneConnection" {
                let button = sender as! UIButton

                if let destinationVC = segue.destination as? SecondViewController {
                    destinationVC.destinationDate = button.title(for: .normal)!
                }
            }
        }

    @objc func buttonClicked(sender: UIButton) {
        performSegue(withIdentifier: "SceneConnection", sender: sender)
            // let value = UIButton.title
    }
}
