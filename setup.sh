#!/bin/bash
echo "**************************************************"
echo " <<<<<<<<<<<< KALI NOOB SETUP SCRIPT >>>>>>>>>>>> "
echo "**************************************************"
check_internet()
{
	if ping -c 1 -q google.com >&/dev/null;then 
		echo "[+] Internet is UP..Ready to go..";
		echo "**************************************************"
	else echo "[+] Please connect to a internet connection and try again..";exit 1
	fi
}
check_internet
rm /etc/apt/sources.list
touch /etc/apt/sources.list
echo "[+] Source Repo Adding To /etc/apt/sources.list ..."

echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" | tee -a /etc/apt/sources.list 
echo "deb-srchttp://http.kali.org/kali kali-rolling main non-free contrib" | tee -a /etc/apt/sources.list
echo "**************************************************"
sleep 2
echo "[+] Added Source Repo ..."
update()
{
	echo -n "[+] Do you want to UPDATE/Or do it manually (y/n)? :"
	read  choice_update
	echo "**************************************************"
	if [ "$choice_update" = "y" ];then	
		sudo apt update;
		echo "**************************************************";
		echo "[+] UPGRADE COMPLETED SUCCESSFULLY ....."
	elif [ "$choice_update" = "n" ];then	
		echo "[+] Aborting ..don't forget to update.."
	else	update
	fi
}
update
echo "**************************************************"
sleep 2
upgrade()
{
	if [ "$choice_update" = "y" ];then		
		echo -n "[+]Do you want to UPGRADE/Or do it manually (y/n)?(Nearly 1.5 GB Required) :"
		read choice_upgrade
		echo "**************************************************"
		if [ "$choice_upgrade" = "y" ];then	
			sudo apt dist-upgrade;
			echo "**************************************************";
			echo "[+] UPGRADE COMPLETED SUCCESSFULLY ....."
		elif [ "$choice_upgrade" = "n" ];then	
			echo "[+] Aborting ..don't forget to upgrade.."
		else	upgrade
		fi
	fi
}
upgrade
echo "**************************************************"
sleep 2
warning_nouveau()
{
	echo "[+] WARNING : Don't proceed if you're not facing this issue..this might affect your kernel"
	echo "**************************************************"
	echo -n "[+]Do you face BLACK SCREEN ERROR/LOOPING LOGIN SCREEN during booting (y/n)? :"
	
	read choice_boot
	if [ "$choice_boot" = "y" ];then	
		sed -i '10s/quiet splash/quiet splash nouveau.modeset=0/' /etc/default/boot;
		echo "[+] GRUB file /etc/default/grub modified"
		sleep 1
		sudo update-grub
		sleep 1
		echo "[+] Nouveau Disabled Successfully In GRUB";
	elif [ "$choice_boot" = "n" ];then	
		echo "[+] Nouveau Not Disabled..."
	else warning_nouveau
	fi
}
warning_nouveau
echo "**************************************************"
clean()
{	
	echo "[+] Cleaning 'temp' and 'unwanted' packages....."
	sudo apt autoremove
	sudo apt autoclean
	sudo dpkg -a --configure
	echo "**************************************************"
	echo "[+] VISIT OUR YOUTUBE CHANNEL : https://www.youtube.com/c/ExploitEverything"
	firefox "https://www.youtube.com/c/ExploitEverything"
	echo "[+] Kali Linux Successfully Set Up"
	echo "[+] Enjoy ..... "
	exit 1
}
clean
