###
 # @FilePath: /个人脚本/init.sh
 # @author: Wibus
 # @Date: 2021-10-01 04:59:38
 # @LastEditors: Wibus
 # @LastEditTime: 2021-10-05 06:57:58
 # Coding With IU
###
clear
steps=1
user=$(whoami)
SYS_INFO=$(uname -a)
SYS_BIT=$(getconf LONG_BIT)
CPU_INFO=$(getconf _NPROCESSORS_ONLN)

# Colorful Text
dark="\033[0;30m"
dark_gray="\033[1;30m"  
blue="\033[0;34m"  
light_blue="\033[1;34m"  
green="\033[0;32m"  
light_green="\033[1;32m"  
cyan="\033[0;36m"  
light_cyan="\033[1;36m"  
red="\033[0;31m"  
light_red="\033[1;31m"  
purple="\033[0;35m"  
light_purple="\033[1;35m"  
brown="\033[0;33m"  
yellow="\033[1;33m"  
light_gray="\033[0;37m"


echo "--------------------------------------------------------------"

echo Bit:${SYS_BIT} Core:${CPU_INFO}
echo ${SYS_INFO}
echo "Hello $user, This your computer infos"

echo "--------------------------------------------------------------"

GetStep(){
    echo "Choose steps: "
    echo "0. All"
    echo "1. Brew"
    echo "2. vim"
    echo "3. mongodb"
    echo "4. mysql"
    echo "5. cloc"

    read steps
}

BrewInstall(){
    # brew install
    echo "$purple Brew Installing... $purple"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew update
}

VimInstall(){
    echo "$purple Vim Installing... $purple"

    brew update
    brew install vim
}

MongodbInstall(){
    echo "$purple Mongodb Installing... $purple"

    echo "Adding brew mongodb tap..."
    brew tap mongodb/brew # mongodb tap
    brew update
    echo "installing mongodb..."
    brew install mongodb-community@4.2 # install mongodb(slow speed)
    brew services start mongodb-community@4.2 # start mongodb service
    echo "install mongodb-shell"
    brew install mongodb-community-shell


    echo "Verifying mongodb service..."
    ps aux | grep -v grep | grep mongod # search mongodb service
}

MySQLInstall(){
    echo "$purple MySQL Installing... $purple"
    brew update
    brew install mysql
    echo "$dark_gray"
    echo "
    We've installed your MySQL database without a root password. To secure it run:
    $light_cyan mysql_secure_installation $dark_gray

    MySQL is configured to only allow connections from localhost by default

    To connect run:
        $light_cyan mysql -uroot $dark_gray

    To start mysql:
    $light_cyan brew services start mysql $dark_gray
    Or, if you don't want/need a background service you can just run:
    /usr/local/opt/mysql/bin/mysqld_safe --datadir=/usr/local/var/mysql
    "
    echo "as usual, I will run: $light_cyan mysql.service start $dark_gray"
    echo "$dark_gray"
}

ClocInstall(){
    echo "$purple cloc installing... $dark"
    brew update
    brew install cloc
}

Main(){
    startTime=`date +%s`
    GetStep
    echo "you choose $steps"
    if [ "$steps" == "0" ];then
        BrewInstall
        VimInstall
        MongodbInstall
        MySQLInstall
    elif [ "$steps" == "1" ];then
        BrewInstall
    elif [ "$steps" == "2" ];then
        VimInstall
    elif [ "$steps" == "3" ];then
        MongodbInstall
    elif [ "$steps" == "4" ];then
        MySQLInstall
    elif [ "$steps" == '5' ];then
        ClocInstall
    fi
}

Main

endTime=`date +%s` #停止时间

((outTime=($endTime-$startTime)/60)) #计算出花了多少分钟

echo ""
echo ""
echo "Time consumed:\033[32m $outTime \033[0mMinute!"
echo ""
echo ""