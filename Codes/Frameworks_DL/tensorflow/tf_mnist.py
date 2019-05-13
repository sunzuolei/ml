import tensorflow as tf
from tensorflow.examples.tutorials.mnist import input_data
import numpy as np
DATA_DIR = "..\\mnist\\raw\\"
NUM_STEPS = 6000
MINIBATCH_SIZE = 100
data = input_data.read_data_sets(DATA_DIR, one_hot=True)

x = tf.placeholder(tf.float32, [None, 784])
w = tf.Variable(tf.zeros([784, 10]), dtype=tf.float32, name="weight")

y_true = tf.placeholder(tf.float32, [None, 10])
y_pred = tf.matmul(x, w,name="op_pred")
print(y_pred)
cross_entropy = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=y_pred, labels=y_true))
# loss = tf.reduce_sum(cross_entropy)
gd_step = tf.train.GradientDescentOptimizer(0.5).minimize(cross_entropy)

correct_mask = tf.equal(tf.argmax(y_pred, 1), tf.argmax(y_true, 1))
# tf.argmax(y,0/1)
# y = array([[1,2,3],
#            [2,3,4],
#            [5,4,3],
#            [8,7,2]])
# tf.argmax(y,0) = array([3,3,1])
# tf.argmax(y,1) = array([2,2,0,0])
# -----------------------------------
# tf.equal(A,B)
# 判断A与B中元素是否相等
# eg: A = [1,2,3,4] B = [1,2,6,7]
# C = tf.equal(A,B)
# >>>[True,True,False,False]
accuracy = tf.reduce_mean(tf.cast(correct_mask, tf.float32))
# tf.cast(x,dtype,name=None) 将Bool值的数转换成dtype
# --------------------------------------------------
# tf.reduce_mean(input_tensor,
#                axis-None,
#                keep_dims=False,
#                name=None
#                reduction_indics=None)

saver = tf.train.Saver()
with tf.Session() as sess:
    # Train
    sess.run(tf.global_variables_initializer())
    for i in range(NUM_STEPS):
        print(sess.run(w))
        batch_xs, batch_ys = data.train.next_batch(MINIBATCH_SIZE)
        #weight = sess.run(w)
        #np.savetxt("weight.txt",weight,delimiter=",")//可视化的方式存储训练权重
        sess.run(gd_step, feed_dict={x: batch_xs, y_true: batch_ys})
        loss = sess.run(cross_entropy, feed_dict={x: batch_xs, y_true: batch_ys})
        print("iter:", i, "loss:", loss)
    # Test
    ans = sess.run(accuracy, feed_dict={x: data.test.images, y_true: data.test.labels})
    print("Accuracy:{:.4}%".format(ans * 100))
    # Save model
    saver.save(sess,"mnist\\model\\mnist_model.ckpt")