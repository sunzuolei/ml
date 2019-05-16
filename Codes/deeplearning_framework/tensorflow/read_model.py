import tensorflow as tf
import numpy as np
import cv2
import matplotlib.pyplot as plt
from PIL import Image, ImageFilter

def prepare_img(img_path):
    im = Image.open(img_path)  # 读取的图片所在路径，注意是28*28像素
    im = im.resize((28, 28), Image.ANTIALIAS)
    plt.imshow(im)  # 显示需要识别的图片
    plt.show()
    im = im.convert('L')
    plt.imshow(im)  # 显示需要识别的图片
    plt.show()
    tv = list(im.getdata())
    tva = [(255 - x) * 1.0 / 255.0 for x in tv]
    return tva

if __name__ =="__main__":

    img = prepare_img('test_img\\hd2.png')

    x = tf.placeholder(tf.float32, [None, 784])
    w = tf.Variable(tf.zeros([784, 10]), dtype=tf.float32, name="weight")
    keep_prob = tf.placeholder(tf.float32)
    y_pred = tf.matmul(x, w, name="op_pred")

    saver = tf.train.Saver()

    with tf.Session() as sess:
        sess.run(tf.global_variables_initializer())
        saver.restore(sess, ".\\model\\mnist_model.ckpt")  # 使用模型，参数和之前的代码保持一致

        prediction = tf.argmax(y_pred, 1)
        predint = prediction.eval(feed_dict={x: [img], keep_prob: 1.0}, session=sess)

        print('识别结果:')
        print(predint[0])
