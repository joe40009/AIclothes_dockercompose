#!/usr/bin/python3
def identify(modulePath,predictPicturePath):
    # list all types what the model identified
    # REMEMBER LABELS in your model have to be defined as following in this .py
    # 「tshirt -> 0」; 「shirt -> 1」; 「suit -> 2」; 「dress -> 3」; 「vest -> 4」;
    types=["T-shirt", "Shirt", "Suit", "Dress", "Vest"]

    # load the "MODEL" what you want
    from keras.models import load_model
    onion = load_model(modulePath)

    # glob.glob（pathname), 返回所有匹配的文件路徑列表。它只有一個參數pathname，定義了文件路徑匹配規則，這裏可以是絕對路徑，也可以是相對路徑。
    import glob
    testnew = glob.glob(predictPicturePath)

    # load a testing picture what you want to identify
    import numpy as np
    from keras.preprocessing.image import load_img
    fn = load_img(testnew[0], target_size=(224, 224))

    # 再用的時候所有東西都轉成np array
    from keras.applications.vgg16 import preprocess_input
    imglist = []
    imglist.append(preprocess_input(np.array(fn)))
    xs=np.array(imglist)

    # Identification Result
    return onion.predict(xs).argmax(axis=-1), types[onion.predict(xs).argmax(axis=-1)[0]]

if __name__=='__main__':
    result=identify('./modules/XXX.h5',"XXX.jpg")
    print("Identification Result INDEX:", result[0])
    print("Identification Result:", result[1])
       
