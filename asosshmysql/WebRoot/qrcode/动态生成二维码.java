动态生成二维码

要生成动态二维码，首先需要掌握以下基本编程技能：html、css、php（jsp/asp也行）。

对于高手来说，只看一段代码就行：<img src =”http://chart.apis.google.com/chart?cht=qr&chs=300×300&chl=加密的内容&choe=UTF-8″ >。
	这里有一点需要注意：编码格式必须是utf-8。300X300是二维码图像大小，大家可以自行修改，需要保证是正方形，最好不要太小。

为了让每一个人都会应用，我在此就多花点时间，把每一种二维码的调用写法都告诉大家。其实我们唯一需要改动的就是chl=后面的内容。

第一种情况：普通文本格式二维码。很简单，就是上面的那段代码
<img src =”http://chart.apis.google.com/chart?cht=qr&chs=300×300&chl=加密的内容&choe=UTF-8″ >。
	我们只需把“加密的内容”换成你想要的文字就行了。当然可以是动态的，但还是要注意必须是utf-8编码。

第二种情况：电话号码二维码。代码如下
<img src =”http://chart.googleapis.com/chart?chl=tel%3A电话号码&chs=200×200&cht=qr&chld=%7C1&choe=UTF-8″ >。 
我们只需把“电话号码”换成你想要的号码就行了，当然可以是动态的。

第三种情况：短信二维码。代码如下
<img src =”http://chart.googleapis.com/chart?chl=SMSTO%3A电话号码%3A短信内容&chs=200×200&cht=qr&chld=%7C1&choe=UTF-8″ >。
	把“电话号码”和“短信内容”换成你想要的号码和内容就行了。当然可以是动态的，但还是要注意必须是utf-8编码。

第三种情况：邮件二维码。邮件二维码相对其他几种，比较棘手一些。不过相信花些功夫还是能做到的。
代码如下<img src =”http://chart.googleapis.com/chart?chl=mailto%3A电子邮箱&chs=200×200&cht=qr&chld=%7C1&choe=UTF-8″ >。
	这里大家要注意，邮箱中的“@”一定要转换成“%40”。当然邮件也是可以是动态的，但还是要注意必须是utf-8编码。

第四种情况：通讯录/名片二维码。这个其实就是以上三种的集合体。代码如下
<img src =”http://chart.googleapis.com/chart?
	chl=NAME%3A名字%0ATEL%3A电话号码%0AEMAIL%3A电子邮箱
	%0AORG%3A公司名称%0ATITLE%3A职位%0AADR%3A地址%0AURL%3A网址
	%0A&chs=200×200&cht=qr&chld=%7C1&choe=UTF-8″ >。
	这里有两点需要注意，1）邮箱中的“@”一定要转换成“%40”。2）网址中的“：”要换成“%3A”,”/”要换成“%2F”。