# DailyReport

## day 1

今天接到任务之后简要的看了一下需要实现的控件，将他们分成了以下几类
1. 最开始页面的一个UISearchBar,不过点击之后的交互考虑到是弹出一个View在弹出的View中进行操作可以考虑主页面的SearchBar用一张图片代替。
2. 第二个页面是一个搜索页面，考虑使用tableview实现，第一个cell添加searchBar和cancel按钮。剩余的cell显示搜索结果
3. 第三个页面同理，使用tableview实现。选项需要使用自定义cell，加入一张img作为选项图片即可。
4. 之后是日期选择界面。主要用collectionview，不过因为之前还未接触过collectionview相关内容所以实现起来有一定难度。点击动画也是需要注意的问题
5. 最后是添加顾客界面，实现难点主要在于cell右边的人口上面，按钮的动画较难以实现。

根据我自身的情况来看的话这个星期的任务主要难度在于日历的实现和最后一个view，所以大部分时间应该也是会花在这两个页面的实现上。

今天主要是把时间花在了自定义cell的大小和与collectionview相关的协议上，目前正在研究日历的实现和cell之间边距的实现

## day2
今天主要在研究上次划分任务之后的日历页面，主要遇到的问题有
### 日期显示无法在cell当中居中
最开始我的设置是直接将每个cell对应的日期label的center设置成和cell的center相同。在字体小的时候显示效果尚且正常，但是当字体调大之后即使设置了center相同，日期的label还是会莫名其妙的跑到外面。后尝试用masonry来自动布局，在自动布局中设置父子视图center相同，成功的将label放到了指定的位置

### headerview重影
为了节省空间和提升效率，collectionview当中的cell并不是一次性全部加载完的，而是仅加载当前视图中的部分，当后面的cell进入视图之后再进行加载，这一点从控制台的输出也可以得证。headerview和cell一样， 都是可以重用的组件。但是在实践过程中发现上下拖动屏幕的时候最上面的headerview会发生重影，如下图：
![UAHVOI.png](https://s1.ax1x.com/2020/07/07/UAHVOI.png)
总的来说就是不属于这个headerview的月份出现在了这个headerview上。经过查找之后了解到在添加label到headerview之前需要remove headerview里面的所有子视图。

从collectionview的生成过程来看，我认为是这样子发生的：在最开始的时候程序创建最初的一批headerview，然后将子视图，在这个app中也就是他们的标题，添加进headerview。当这个headerview被滑出了屏幕之后，为了节省开销与他有关的资源被释放，但是依旧保存在内存当中，当新的 headerview进入屏幕之后，方法``dequeueReusableCellWithReuseIdentifier:forIndexPath:``从内存中寻找是否有``ReuseIdentifier``和指定的``ReuseIdentifier``相同的headview，之前被所谓**释放资源**的headerview就被重新使用。而这时的headerview并不是一个刚刚初始化过的cell，里面已经包含了添加过的label的headerview，这样就解释了为什么在上图中同一个headerview里面会出现两个label。

### 排列月份的每一天
对于每一个section，当中的cell总是默认从第一个开始排列，这显然和一个日历的要求不相符。所以**获取指定月份的第一天是星期几**成为了必要实现的一个功能。而这也关系到协议方法``numberOfItemsInSection``的实现，我们可以采用返回星期几+当前月份的天数的方式来返回section中的item数。在这个过程中主要遇到的问题是无法添加指定的月份到当前的日期。
我确定section对应的月份的方式是先生成当前日期的``NSDate``，再将当前的section加到当前日期的``NSDate``上。用到的主要方法是``dateByAddingUnit:value:toDate:options:``,但是在控制台输出的新的日期总是``nil``。
最开始我认为问题是出在最后的options参数上，因为在官方文档中有这样一句话：
>If you specify a “wrap” option (NSCalendarWrapComponents), the specified components are incremented and wrap around to zero/one on overflow, but do not cause higher units to be incremented. When the wrap option is false, overflow in a unit carries into the higher units, as in typical addition.

显然这个``NSCalendarWrapComponents``设置为``false``就是我想要的效果，因为section的值必然会大于12，向年份的进位是必须的。但是找了很多方法设置了很多值也不行。最后发现问题出在最开始的``NSCalendar``的初始化上。
别人的样例代码中的``NSCalendar``初始化的参数是``currentCalendar``，但是我却是用``NSCalendar.new``来直接进行初始化。在修改了初始化的方法之后果然新的``NSDate``输出不再是``nil``而是正常的日期。

### 今天的成果
经过今天的coding之后目前的成果大概张这样：
[![UAzQht.md.png](https://s1.ax1x.com/2020/07/07/UAzQht.md.png)](https://imgchr.com/i/UAzQht)

目前存在的主要问题是程序启动时间过长，以及选中cell之后后面加载的部分cell也会存在被选中的情况。我认为后面的问题也和之前的headerview一样，计划用全局indexPath变量来解决cell选中问题。程序启动时间较长则先放一放，以实现功能为主要目的

## day3
### 多选与deselect问题
最开始的版本是支持多选的，但是不支持点击cell之后自动取消（这个时候尚未打开``allowsMultipleSelection``的开关)。所以我决定在``select``方法中手动调用``deselect``方法来支持单击cell取消。但是实现了这样一个方法之后又出现了新的问题：**不支持多选了**。这和我前天在官方的demo中看到的情况类似，也是实现了``select``和``deselect``方法，但是只支持单选，重复选取会自动取消之前的cell。随后我又在网上找到了之前说的``allowsMultipleSelection``的开关。在设置这个属性为``true``之后，又有了新的问题
现在的app支持cell多选，但是单击已选中的cell的``deselect``方法却不会再执行。控制台中之前本应该会输出的语句也没有输出。不过这个时候我还是在``select``里面手动执行``deselect``，设置日期cell的label的指令也放在判断当前cell是否已经选择过的外面。断点调试后发现，自己的``deselect``并非是没有执行，而是执行之后的效果被之前的设置日期的cell的label的指令效果所**覆盖**了，也就是对一个label执行了两次操作。和设置变量``allowsMultipleSelection``为``true``之前相比，最显著的变化就是自己实现的``deselect``方法会自动执行，而不需要手动执行。对比设置变量，实现``deselect``方法前后不同情况，我认为``collectionview``这个控件在``allowsMultipleSelection``被设置为``true``之前如果实现了``deselect``方法就会变成单选，未实现就会变成多选，且一旦选择就不能取消选择。但是``allowsMultipleSelection``被设置为``true``之后就不一样了，``deselect``会在单击已选择cell的时候自动执行。

### 日期遍历问题
在任务中，日期部分需要实现一个两个日期之间的日期用灰色方格表示，首尾两个方格用黑色圆圈表示。在这次任务中我采用的方法是一个月份对应一个``section``，那么就会出现几种情况
1. 选择的日期在已选择的日期之前
2. 选择的日期在已选择的日期之后，但是在同一月
3. 选择的日期在已选择的日期之后，但是不在同一月

第一种情况爱彼迎的解决方法是只保留最新的选择日期，第二和第三种情况即刚才所说。那么就涉及到一个日期比较的问题。如何知道cell对应的日期？
如果用``cellForItemAtIndexPath:``里面计算日期的方法未免太过复杂，于是我选择使用和日期一一对应的``indexPath``。最开始的判断方法是根据``indexPath``的``section``和``item``来判断谁前谁后，但是后来在网上查找到了``NSindexPath``自带有``compare``方法，可以返回两个``indexPath``的比较结果。于是对代码进行了重构，解决了第一种情况的判断问题。
但是第二三种的情况的处理困扰了我很久，第二种情况倒还好，因为在同一个``section``,遍历``item``即可.但是第三种情况则会出现后面选择的日期的``section``比之前选择的要大，但是``item``的值要小的情况。两个``indexPath``也不能用快速枚举的方式遍历。最终在学长的建议下我决定还是使用遍历``visiblecells``的方式，同时根据当前正在遍历的cell的``indexPath``来判断其相对于两个已选择日期的位置。最终还是解决了日期问题。但是遍历问题虽然解决了，产生了新的问题：两个日期中间的单元格没有变成预计的颜色，旁边许多的单元格变成了不应该变成的灰色

### 单元格view正常显示的问题
承接上文，通过观察我发现是我没有添加全局变量对显示灰色的单元格加以限制的缘故。于是和之前的``selectedArray``一样，对于处于两个日期之间的``indexPath``添加到全局变量之中。同时在自定义的cell之中添加标志位``isGap``和设置处于两个日期之间的样式。这样处理之后问题大部分解决了。但是还是出现了问题： 
中间本应该是清一色灰色的小方格中出现了1-2个圆形cell。圆形cell是我用来表示被选中的日期的cell样式，但是中间的日期并没有被选中，本不应该出现这些小圆形。对此我联想到了cell的重用机制，并在控制台对每一次``cellForItemAtIndexPath:``前后cell的状态进行了打印。果然是之前已选择日期的cell变成了已选择日期中间的cell，同时连带着被选择的状态也过去了，导致了这种情况的存在。经过了这次的debug我对cell的重用机制又有了新的理解，重用cell是把一个原有的cell实例加载到新的地方，实例中的属性的值也并不会发生变化，并且每``reloaddata``一次都会让当前视图中的所有cell强制重用。

### 今日份的成果
[![UeidW4.md.png](https://s1.ax1x.com/2020/07/09/UeidW4.md.png)](https://imgchr.com/i/UeidW4)
明天开始应该可以着手写别的界面了，日历部分再加一个footerview应该就行了

## day4

今天完成的工作有点出人意料的多，也许是因为和之前的相比简单的原因。但还是遇到了一些问题。

### 自定义cell的圆角与边框显示
demo中的三个cell和普通的cell相比，可以明显的看出三个cell和两边都有一定的间距，而且每个cell之间也有一定间距，cell的下面还有一定的阴影让cell看上去更具立体感。
最开始的每一个cell都是和view的两边紧密相连的，而且上下的cell之间也没有空隙。最开始我的做法是将所有的空间放在一个view里面，将view做成圆角。但是这样点选的时候还是会选中一整块cell，没有达到圆角的效果。所以舍弃，最后采用的是移动cell的frame的原点到右下角，同时缩减``width``和``height``。这样子实现了cell之间存在空隙。然后又用一个``CALayer``来作为cell的``mask``。这样圆角的显示效果也有了。但是之后反复尝试给作为``mask``的layer添加``borderwidth``和``bordercolor``属性都不能在视图上展现出来。后来才知道，要修改的是cell的``layer``而不是``mask``的``layer``
### 自定义button的形状
在原生的控件库里面并没有符合最后一个视图要求的，所以需要自己写一个``UIButton``。自定义好之后开始习惯性的自动布局，但是尽管自动布局的已经设置好了，自定义的``UIButton``的形状已经从原来的圆形扭曲成了椭圆形。之后才知道，使用自动布局会覆盖控件的frame，也就会出现从圆形变成椭圆形这种情况。所以目前采用的方案是放弃自动布局，手动计算控件应该出现的位置然后在初始化的时候指定。后期优化应该会在考虑这个问题

### 今天的成果
今天完成了第二个视图和最后一个视图，目前还剩下第一个视图没有完成。
[![UnTyqJ.md.png](https://s1.ax1x.com/2020/07/09/UnTyqJ.md.png)](https://imgchr.com/i/UnTyqJ)
[![UnTgaR.md.png](https://s1.ax1x.com/2020/07/09/UnTgaR.md.png)](https://imgchr.com/i/UnTgaR)
## day5
今天主要是在解决日期选择画面的底部的视图的问题，最开始以为是要用``ToolBarItem``来进行设置，但是在自定义``UIBarButton``的时候遇到了诸多困难，而且后面了解到其实最好的方式也并不是用``ToolBarItem``,而是自定义一个View并将其附着到当前视图的底部。
因为今天临时有点事情，所以大部分时间都在研究``ToolBarItem``，并没有进行多少有效的编码
## day6

今天完成了最后一个视图，以及各个视图之间的衔接工作。主要碰到的问题是将一个自定义的``UIview``和一个``UITableView``组合到一起，以及搜索框的``Cancel``按钮的布局。

### 自定义View和UITableView

在任务的demo中，点击搜索框之后会从下而上弹出一个新的视图。而这个视图的上半部分是一个搜索框，搜索框的右边是一个自定义的取消按钮，下面是一个``UITableView``，用来展示搜索获得的信息。但是在将自定义的搜索框和``UITableView``进行整合的时候出现了问题。无论怎么操作最终显示的都只有一个``UITableView``而缺少了搜索框部分。后来才知道之前的操作一直都是将搜索框作为子视图添加到``UITableView``里面。但是其实正确的做法应该是创建一个母View，将搜索框和``UITableView``同时作为子视图添加到母View里面，同时设置``UITableView``的内容偏移，使得其在显示上就像从搜索框下面开始一样。
### 今日份的成果
[![U1tMDS.md.png](https://s1.ax1x.com/2020/07/11/U1tMDS.md.png)](https://imgchr.com/i/U1tMDS)
[![U1tJCn.md.png](https://s1.ax1x.com/2020/07/11/U1tJCn.md.png)](https://imgchr.com/i/U1tJCn)

## day7

今天主要看了下``objectivec设计模式``和``提升objectiveca代码质量的52个建议``其中重温了下协议的部分。再结合之前面试时遇到的关于代理的问题，这几天写代码的时候遇到的问题，对协议和代理的理解又不一样了。
前几天在将``UICollectionView``添加进母view的时候出了一些问题，即虽然各个协议的方法都已经实现了，显示出来的``UICollectionView``还是空白一片。最开始的控制器就是一个``UICollectionViewController``，然后被修改成``UIViewController``。然后在stackoverflow上浏览的时候发现有人提了相同的问题，下面有人回复需要设置代理。有点垂死病中惊坐起内味了。在设置代理为self之后果然可以正常的显示数据。
对于一般的``UICollectionViewController``及其子类，应该是直接指定当前对象就是``self.collectionview``的delegate和datasource.但是对于一般的vc，由于事先并不知道类的属性会有哪些，所以需要手动指定。
``UICollectionView``及其子类自身并没有管理内容的业务逻辑的能力，而是只负责将视图呈现出来。实现了``UICollectionViewDelegate``和``UICollectionViewDataSource``的类实现如何展示view的具体方法，如``cellForRowAtIndex``。也就是书上所说的将方法的实现交给了别的对象完成，有助于不同对象之间的解耦。
但是在这个过程中，vc和model之间的交流却没有很好的体会到。虽然delegate和dataSource可以交给不同的对象完成，通常情况下还是由同一个对象来充当这个角色。