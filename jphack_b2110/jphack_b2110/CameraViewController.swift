import UIKit
import CoreML
import Vision
import RealmSwift
 
class CameraViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    @IBOutlet var cameraView : UIImageView!
    

    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text = ""
        label2.text = ""
        label3.text = "写真を撮ってひよこに餌をあげよう！"
        label4.text = ""
        label5.text = ""
    }
    
    
    override func viewWillAppear(_ animated: Bool) {//画面に遷移したときに実行される。
        super.viewWillAppear(animated)
        
        
        //時刻の取得
        let now = Date()
        print(now)
        //=> 2016-11-23 23:33:20 +0000
        //現在日時から時分だけ取り出す(24時間制で分単位)
        let minutes = Int(now.timeIntervalSince1970) % (24*60*60) / 60
        print(now.timeIntervalSince1970)
        //時分を抽出
        print("hour =", minutes/60)
        print("minute =", minutes%60)
        
        
        //一旦生成\
        /*
        let food = Food()
        food.calories = 1
        food.fat = 1
        food.carbohydrate = 1
        food.protein = 1
        food.vitamin = 1
        
        let realm = try! Realm()
        try! realm.write{//データベースへの書き込み処理
            realm.add(food)
            
        }
        */
    }
    
    // カメラの撮影開始
    @IBAction func startCamera(_ sender : Any) {
        startTakingPhoto()
    }
    
    func startTakingPhoto(){
        let sourceType:UIImagePickerController.SourceType =
            UIImagePickerController.SourceType.camera
 
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            label1.text = "error"
        }
    }
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        // dismiss
        imagePicker.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.originalImage]
            as? UIImage {
            
            cameraView.contentMode = .scaleAspectFit
            cameraView.image = pickedImage
            
            photoPredict(pickedImage)
        }
    }
    
    func photoPredict(_ targetPhoto: UIImage){
        
        // 学習モデルのインスタンス生成
        guard let model = try? VNCoreMLModel(for: Label_suujinisita().model) else{
            print("error model")
            return
        }
        
        // リクエスト
        let request = VNCoreMLRequest(model: model){
            request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                return
            }
            
            var csvLines = [String]()
            guard let path = Bundle.main.path(forResource:"NutritionMatrix_Food101_3", ofType:"csv") else {
                print("csv error")
                return
            }
            
            do {
                let csvString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                csvLines = csvString.components(separatedBy: .newlines)
            } catch let error as NSError {
                print("エラー: \(error)")
                return
            }
            var nutirtionArray:[Float] = []
            for (i, n) in csvLines.enumerated() {
                if (i%2 == 0){
                    let nutrition = n.components(separatedBy: ",")
                    var predNutrition :Float = 0.0
                    for r in results{
                        let conf = r.confidence
                        let ndx:Int = Int(r.identifier) ?? 0
                        predNutrition += conf*(Float(nutrition[ndx]) ?? 0)
                    }
                    nutirtionArray.append(predNutrition)
                }
            }
            self.label1.text = "カロリー：\(nutirtionArray[0])kca\n"
            self.label2.text = "脂質：\(nutirtionArray[1])g\n"
            self.label3.text = "炭水化物：\(nutirtionArray[2])g\n"
            self.label4.text = "タンパク質：\(nutirtionArray[3])g\n"
            self.label5.text = "ビタミン：１日分の\(nutirtionArray[4])%\n"

            
            let food = Food()
            food.calories = nutirtionArray[0]
            food.fat = nutirtionArray[1]
            food.carbohydrate = nutirtionArray[2]
            food.protein = nutirtionArray[3]
            food.vitamin = nutirtionArray[4]
            
            let realm = try! Realm()
            try! realm.write{//データベースへの書き込み処理
                realm.add(food)
                
            }
            
            for r in results[0...2]{
                print(r.identifier, r.confidence)
            }
        }
        
        
        
        // 画像のリサイズ
        request.imageCropAndScaleOption = .centerCrop
        // CIImageに変換
        guard let ciImage = CIImage(image: targetPhoto) else {
            print("ciImage error")
            return
        }
        
        // 画像の向き
        let orientation = CGImagePropertyOrientation(
            rawValue: UInt32(targetPhoto.imageOrientation.rawValue))!
        
        // ハンドラを実行
        let handler = VNImageRequestHandler(
            ciImage: ciImage, orientation: orientation)
        
        do{
            try handler.perform([request])
            
        }catch {
            print("error handler")
        }
        
    }
 
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // 写真を保存
    /*@IBAction func savePicture(_ sender : Any) {
        let image:UIImage! = cameraView.image
        
        if image != nil {
            UIImageWriteToSavedPhotosAlbum(
                image,
                self,
                #selector(CameraViewController.image(_:didFinishSavingWithError:contextInfo:)),
                nil)
        }
        else{
            print("image Failed !")
        }
        
    }
    
    // 書き込み完了結果の受け取り
    @objc func image(_ image: UIImage,
                     didFinishSavingWithError error: NSError!,
                     contextInfo: UnsafeMutableRawPointer) {
        
        if error != nil {
            print(error.code)
        }
        else{
        }
    }
    
    // アルバムを表示
    @IBAction func showAlbum(_ sender : Any) {
        let sourceType:UIImagePickerController.SourceType =
            UIImagePickerController.SourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            label1.text = "error"
            
        }
        
    }
*/
}
