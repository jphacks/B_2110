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
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else{
            print("error model")
            return
        }
        
        // リクエスト
        let request = VNCoreMLRequest(model: model){
            request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                return
            }
            // 確率を整数にする
            let conf = Int(results[0].confidence * 100)
            // 候補の１番目
            let name = results[0].identifier
            
            if conf >= 50{
                self.label.text = "\(name) です。確率は\(conf)% \n"
            }
            else{
                self.label.text = "もしかしたら、\(name) かも。確率は\(conf)% \n"
            }
        }
        
        
        // 画像のリサイズ
        request.imageCropAndScaleOption = .centerCrop
        
        // CIImageに変換
        guard let ciImage = CIImage(image: targetPhoto) else {
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
