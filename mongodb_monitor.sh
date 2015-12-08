if [ -f ~/.bash_profile ];
then
  . ~/.bash_profile
fi

index=1
len=0
filepath=~/Desktop/mongodbStatus.log  #! 读取mongod 进程的状态文件
outlog=~/Desktop/mongod.log   #! 监视日志
mongodconfig=~/Downloads/mongodb-3.0.7/mongod.conf #! mongodb 的配置文件
ps -e |grep mongod> $filepath   #!读取并写入启动状态到文件

cat $filepath  | while line=$(line)
do
   len=`echo $line | tr -cd mongod | wc -c`
   if [ $len -gt $index ]
   then
      echo ">>>>>>>>have started mongodb"
   fi
done

filelen=`stat -c %s $filepath`

if [ $filelen -eq 0 ] #! haven't started
then
    echo "*********going to start mongodb service"
     mongod -f $mongodconfig    #!重新启动mongod
fi
 echo 'check mongo service once at:'`date` >> $outlog





