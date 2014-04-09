(ns yougou.qrcode
  (:import (com.google.zxing BarcodeFormat BinaryBitmap DecodeHintType EncodeHintType MultiFormatReader MultiFormatWriter NotFoundException Result)
           (com.google.zxing.client.j2se MatrixToImageConfig MatrixToImageWriter)
           (com.google.zxing.common BitMatrix HybridBinarizer)
           (com.google.zxing.qrcode.decoder ErrorCorrectionLevel)
           java.awt.Graphics2D
           java.awt.image.BufferedImage
           javax.imageio.ImageIO
           java.io.File
          )
)

(defn overlap-image [image-path logo-path]
  (let [image (ImageIO/read (File. image-path))
        logo-width (quot (.getWidth image) 5)
        logo-height (quot (.getHeight image) 5)
        logo-x (quot (- (.getWidth image) logo-width) 2)
        logo-y (quot (- (.getHeight image) logo-height) 2)
        g (.createGraphics image)
        ]
    (.drawImage g (ImageIO/read (File. logo-path)) logo-x logo-y logo-width logo-height nil)
    (.dispose g)
    (ImageIO/write image (.substring image-path (+ (.lastIndexOf image-path ".") 1)) (File. image-path))
    )
  )

(defn encode-qrcode-image [content image-path width height logo-path]
  ;(println (str content "," image-path "," width "," height "," logo-path))
    (let [hints {EncodeHintType/CHARACTER_SET "UTF-8" EncodeHintType/ERROR_CORRECTION ErrorCorrectionLevel/H}
          bit-matrix (.encode (MultiFormatWriter.)  content BarcodeFormat/QR_CODE width height hints)
          config (MatrixToImageConfig.)
          ]
      (try
        (MatrixToImageWriter/writeToFile bit-matrix (.substring image-path (+ (.lastIndexOf image-path ".") 1)) (File. image-path) config)
        (if logo-path
          (overlap-image image-path logo-path)
        )
        (catch Exception e (.printStackTrace e) false)
      )

    true)
  )