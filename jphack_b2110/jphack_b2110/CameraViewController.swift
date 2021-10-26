import UIKit
import AVFoundation
import CoreML
import Vision

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
       // setupCaptureSession()
      //  setupDevice()
      //  setupInputOutput()
      //  setupPreviewLayer()
      //  captureSession.startRunning()
    }

    // デバイスからの入力と出力を管理するオブジェクトの作成
    var captureSession = AVCaptureSession()

    // カメラの画質の設定
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    // カメラデバイスそのものを管理するオブジェクトの作成
    // メインカメラの管理オブジェクトの作成
    var mainCamera: AVCaptureDevice?
    // インカメの管理オブジェクトの作成
    var innerCamera: AVCaptureDevice?
    // 現在使用しているカメラデバイスの管理オブジェクトの作成
    var currentDevice: AVCaptureDevice?
    
    // デバイスの設定
    func setupDevice() {
        // カメラデバイスのプロパティ設定
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        // プロパティの条件を満たしたカメラデバイスの取得
        let devices = deviceDiscoverySession.devices

        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                mainCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                innerCamera = device
            }
        }
        // 起動時のカメラを設定
        currentDevice = mainCamera
    }
    
    // キャプチャーの出力データを受け付けるオブジェクト
    var photoOutput : AVCapturePhotoOutput?

    // 入出力データの設定
    func setupInputOutput() {
        do {
            // 指定したデバイスを使用するために入力を初期化
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
            // 指定した入力をセッションに追加
            captureSession.addInput(captureDeviceInput)
            // 出力データを受け取るオブジェクトの作成
            photoOutput = AVCapturePhotoOutput()
            // 出力ファイルのフォーマットを指定
            photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    
    // プレビュー表示用のレイヤ
    var cameraPreviewLayer : AVCaptureVideoPreviewLayer?

    // カメラのプレビューを表示するレイヤの設定
    func setupPreviewLayer() {
        // 指定したAVCaptureSessionでプレビューレイヤを初期化
        self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        // プレビューレイヤが、カメラのキャプチャーを縦横比を維持した状態で、表示するように設定
        self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        // プレビューレイヤの表示の向きを設定
        self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait

        self.cameraPreviewLayer?.frame = view.frame
        self.view.layer.insertSublayer(self.cameraPreviewLayer!, at: 0)
    }
    /// UIImagePickerController カメラを起動する
    /// - Parameter sender: "UIImagePickerController"ボタン

    @IBAction func CameraBotton(_ sender: Any) {
        // カメラで撮影した後の画像を予測に送る
    }
    
    @IBAction func Camera(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        // UIImagePickerController カメラを起動する
        present(picker, animated: true, completion: nil)
    }
    /// シャッターボタンを押下した際、確認メニューに切り替わる
    /// - Parameters:
    ///   - picker: ピッカー
    ///   - info: 写真情報
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        // "写真を使用"を押下した際、写真アプリに保存する
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        // UIImagePickerController カメラが閉じる
        self.dismiss(animated: true, completion: nil)
        photoPredict(image)
    }
    
    func photoPredict(_ targetPhoto: UIImage){
        // 学習モデルのインスタンス生成
        guard let model = try? VNCoreMLModel(for: Food11().model) else{
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
               // self.label.text = "\(name) です。確率は\(conf)% \n"
            }
            else{
              //  self.label.text = "もしかしたら、\(name) かも。確率は\(conf)% \n"
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
}
