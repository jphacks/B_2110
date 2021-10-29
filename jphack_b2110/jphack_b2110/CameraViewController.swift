import UIKit
import CoreML
import Vision
 
 
class CameraViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    @IBOutlet var cameraView : UIImageView!
    @IBOutlet var label : UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    // カメラの撮影開始
    @IBAction func startCamera(_ sender : Any) {
        
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
            label.text = "error"
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
        guard let model = try? VNCoreMLModel(for: efficientnetb2_Keras_7().model) else{
            print("error model")
            return
        }
        
        // リクエスト
        let request = VNCoreMLRequest(model: model){
            request, error in
            guard let results = request.results else {
                print("results error")
                return
            }
            // 確率を整数にする
            for i in 0...3{
                let classifications = results[i]
                print(classifications)
            }
            //let classifications = results[0]
            // 候補の１番目
            //let name = results[0].identifier
            //print(classifications)
            //self.label.text = "確率は\(classifications)\n"
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
    @IBAction func savePicture(_ sender : Any) {
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
            label.text = "error"
            
        }
        
    }
    
}
