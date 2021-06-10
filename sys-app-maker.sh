read up
if [ $up -eq 1 ]; then
	cd ~/
	rm -rf sys-app-maker-magisk > /dev/null 2>&1
	git clone https://github.com/remku/sys-app-maker-magisk
	bash ~/sys-app-maker-magisk/sys-app-maker.sh
fi
###  Color & shortcut ###
red="\e[1;91m"
green="\e[1;92m"
blue="\e[1;94m"
white="\e[0m"
sudo="su -c"
### Checker ###
check(){
	if [ $(echo $?) -eq 0 ]; then
		echo -e "${blue}$1 --> ${green}OK${white}"
	else
		echo -e "${blue}$1 --> ${red}ERROR${white}"
	fi
}

### Setting Permission ###
$sudo mount -o remount,rw /
check Mounting_System

### APP checking ###
read -p $'\e[1;94mEnter App Name: \e[0m' appName
if [ ! -e "/sdcard/$appName" ]; then
	echo -e "${red}App Folder Not Found in '/sdcard'${white}"
	read -p $'\n\e[1;94mIs the app already Installed as User APP (y/n): ' choice
	if [ $choice" -eq 'y' ]; then
		$sudo mkdir /sdcard/$appName
		$sudo pm list packages -f | grep "$appName" | grep "/data/app"| sed -e 's/.*package:\(.*\)=\(.*\)/\1/' | args -I {} mv {} /sdcard/$appName
	fi
fi
