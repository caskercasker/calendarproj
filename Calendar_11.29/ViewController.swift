//
//  ViewController.swift
//  Calendar_11.29
//
//  Created by 조우현 on 2019/11/29.
//  Copyright © 2019 조우현. All rights reserved.
//
import Foundation
import UIKit

class Dates {
    var items: Int
    init(){
        items = 1
    }
    class func add(numberOne: Int, numberTwo: Int) -> Int{
        let answer: Int = numberOne + numberTwo
        return answer
   }
}

extension Date{ //Date 라는 객체는 내용이지 기능을 넣는 곳은 캘린더가 되어야 한다.
    func getCurrentDate() -> Int {
        let calendar = Calendar.current
        let rightNow = Date()
        
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


class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        let month = Calendar.current.component(.month, from: Date())
        title = String(month)
        // Do any additional setup after loading the view.
        //해당주의 데이터를 뿌린다.
        /*let endOfMonth = Calendar.current.component(.day, from: Date().endOfMonth())
        let c: Int = endOfMonth/7
        for index in 1...(c+1){
            setCollectionItem(week: index)
        }*/
    }

    // MARK: -  Fuction for a week

    var collectionItems = [String]()
    var collectionItems2 = [String]()
    var dic1: Dictionary = [String:Int]()
    /*
    func setCollectionItem(week: Int){
        
        var result = Dates.add(numberOne: 4, numberTwo: 2)
        let rightNow = Date() //Date 객체 받음
        
        let i = Date().getCurrentDate() //현재날짜 받아오기
        let dayOfDate = Date().getCurretDayOfDate()
        
        //날짜 시작일에 해당하는 날짜 객체를 받아와야 한다.
        //let startDate = Date(from: <#T##Decoder#>)
        
        let startOfMonth = Calendar.current.component(.day, from: Date().startOfMonth())//그달의 시작일 정수로 받아오기.
        let endOfMonth = Calendar.current.component(.day, from: Date().endOfMonth())
        print(endOfMonth)
        
        let dateOfStartMonth = Calendar.current.component(.weekday, from: Date().startOfMonth())// 그달의 시작 요일
        print(dateOfStartMonth)
        let dateOfEndOfMonth = Calendar.current.component(.weekday, from: Date().endOfMonth())
        print(dateOfEndOfMonth)
        
        
        
        let dayAfter = Calendar.current.date(byAdding: .day, value: -10, to: rightNow) //3일 뒤의 날짜
        let dayAfter3 = Calendar.current.component(.day, from: dayAfter!)//3일 뒤의 날짜 데이터로 받아오기.
        
        let test = Calendar.current.date(byAdding: .day, value: -10, to: Date().startOfMonth())
        //print(test)
        
        //이번주 값들 저장
        
        let sevenDayAfter = Calendar.current.date(byAdding:.day, value: (week-1)*7 , to : Date().startOfMonth())

        var dic1: Dictionary <Int, Int> = [1:0,2:0,3:0,4:0,5:0,6:0,7:0]
        var bufferOfDay = Calendar.current.component(.weekday,from: sevenDayAfter!) // 요일값 정수
        //var bufferOfDay: Int = 0 // 해당 날짜의 요일값을 받아오면 딕셔너리에 저장하는 조건
        var bufferDate = Calendar.current.component(.day, from: sevenDayAfter!) // 날짜값 정수      var day = 0;
        //let b = bufferDate // 뿌리기 기준 날짜
        var keyPoint = 0-bufferOfDay+1 //0일수가 없음

        for _ in 1...8{
        //날짜를 넘기고, 요일을 넘기면
            switch (bufferOfDay){
            case 1:
                dic1.updateValue(bufferDate, forKey: 1)
                //print(day)
                //break
            case 2:
                dic1.updateValue(bufferDate, forKey: 2)
                //print(day)
                //break
            case 3:
                dic1.updateValue(bufferDate, forKey: 3)
                //break
            case 4:
                dic1.updateValue(bufferDate, forKey: 4)
                //break
            case 5:
                dic1.updateValue(bufferDate, forKey: 5)
                //break
            case 6:
                dic1.updateValue(bufferDate, forKey: 6)
                //break
            case 7:
                dic1.updateValue(bufferDate, forKey: 7)
            default:
                print("end")
            }
            if(keyPoint != 0){
  
                let distance = keyPoint
                let c = Calendar.current.date(byAdding: .day, value: distance ,to : sevenDayAfter!)// 다음 날짜 객체 받아오기
                bufferDate = Calendar.current.component(.day, from: c!) // 날짜 받기
                bufferOfDay = Calendar.current.component(.weekday,from: c!) //요일 받기
                keyPoint += 1
            }else {
                keyPoint += 1;
                //print("0")
            }
            //buf += 1;
            //bufferDate = Calendar.current.date(byAdding: .day, value: b ,to : Date().startOfMonth())
            
            //print(index)
        }
    
        /*
        for (key,value) in dic1{
            print("\(key):\(value)") // 1:zedd 2:swift 3:iOS 4:fun 5:Hello
        }*/
        
        
        //print(day) // 일요일을 기준으로 1부터 저장된 딕셔너리에서, 요일값을 기준으로 정렬된 배열에 넣기.
        
        for count in 0...6{
            collectionItems.append(String())
            collectionItems[count+((week-1)*7)] = String(dic1[count+1]!)
            result += 1
        }*/
    

        ///////////////////////
        
    
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
        var sizeToWidth: Int = size
        var sizeToHeight: Int = sizeToWidth*2
        

        return CGSize(width: size, height: sizeToHeight)

    }
    
        // MARK: - CollectionView DataSource

        override func numberOfSections(in collectionView: UICollectionView) -> Int {
                return 1
        }
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 150

    }
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! CollectionViewCell
            
            let date = Date()
            let startWeekday = Calendar.current.component(.weekday, from: Date().startOfMonth())//첫날의 요일 값 숫자값
            //print(startWeekday)
            let firstDay = Calendar.current.date(byAdding: .day , value: 1-startWeekday, to: Date().startOfMonth()) // 달표시의 첫날
            let begin = Calendar.current.date(byAdding: .day, value: indexPath.row, to: firstDay!) //indexpath에 따라서 날짜가 진행되면서 뿌린다.
            
            let labelText = Calendar.current.component(.day, from: begin!) //UILable에 뿌리는 날짜값, 계산과는 상관없는 일자만 반복
            let cur = Calendar.current.component(.day, from: Date()) //현재날짜값 데이터
            //let date = Date()
            
            let dateFormatter = DateFormatter() //
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            //dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            //dateFormatter.locale = Locale.init(identifier: "ko_Ko")
            //var dateString2 = dateFormatter.string(from: Date()) //현재 시간을 표시
            //print(dateString2)

            let dateString = dateFormatter.string(from: begin!) //포맷에 따른 date 객체의
            //print(dateString)
            //print(dateString()
            
            cell.collectionViewButtons.setTitle(String(dateString), for: .normal) //
            //print(dateString)
            cell.collectionViewButtons.setTitleColor(.white, for: .normal)
            //cell.collectionViewButtons.setTitle
            
            
            //cell.DateLabel
            //cell.collectionViewButtons.setT
            //cell.collectionViewButtons.value(forKey: String(d))
            
            // collectionItems[indexPath.row] = String(Calendar.current.component(.day, from: begin!))
            
             //cell.collectionViewButtons.setTitle(collectionItems[indexPath.row],for:.normal)
            cell.collectionViewButtons.backgroundColor = .white
            cell.collectionViewButtons.frame = CGRect(x: 0, y: 0, width: 80, height: 50)
            //cell.collectionViewButtons.systemLayoutSizeFitting(<#T##targetSize: CGSize##CGSize#>)
                //Frame 에는 CG Rect 만 대입 가능.
            //cell.collectionViewButtons.frame = CGRect(from: )
            //cell.sizeThatFits(<#T##size: CGSize##CGSize#>)
            
            cell.collectionViewButtons.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            cell.DateLabel.text = String(labelText)// 레이블 출력
            var place = NSIndexPath(item: cur, section: 0)
            print(cur)
            let indexPath = IndexPath(row: cur-1, section: 0)//indexPath 는 0부터 시작
            cell.contentView.backgroundColor = .red
            collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = .blue
            //self.tableView.insertRows(at: [indexPath], with: .right)
            //if (indexPath.row == labelText)
            //cell.DateLabel.bac
            return cell

        }
//강제로 cell의 라인과, 아이텝 별로 공간 주는 함수
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0
//    }
//item 숫자를 건드리니까 위에 item per indexpaht 값이 작동하지 않음.
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }


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




