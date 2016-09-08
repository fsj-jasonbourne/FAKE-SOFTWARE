#!/bin/bash
# 首先校验/root/rpmbuild/下打包目录是否完整
# 设置fake安装包名称
# 设置fake安装包数量
# 通过rpmbuild命令打包 rpmbuild -ba XXX.spec 

build_dir="/root/rpmbuild/BUILD"
buildroot_dir="/root/rpmbuild/BUILDROOT"
rpm_dir="/root/rpmbuild/RPMS"
source_dir="/root/rpmbuild/SOURCES"
specs_dir="/root/rpmbuild/SPECS"
sprms_dir="/root/rpmbuild/SRPMS"
move_dir="/tmp/softinstall/"

specs_name="rpmtest.spec"

function build_path()
{
    if [ ! -d ${build_dir} ]  
    then
    {
        mkdir ${build_dir} 
        echo "创建${build_dir}目录成功"
    }	   
    fi

    if [ ! -d ${buildroot_dir} ]
    then
    {
	mkdir ${buildroot_dir} 
	echo "创建${buildroot_dir}目录成功"
    }
    fi

    if [ ! -d ${rpm_dir} ]
    then
    {
	mkdir ${rpm_dir} 
	echo "创建${rpm_dir}目录成功"
    }
    fi

    if [ ! -d ${source_dir} ]
    then
    {
	mkdir ${source_dir} 
	echo "创建${source_dir}目录成功"
    }
    fi

    if [ ! -d ${specs_dir} ]
    then
    {
	mkdir ${specs_dir} 
	echo "创建${specs_dir}目录成功"
    }
    fi

    if [ ! -d ${sprms_dir} ]
    then
    {
	mkdir ${sprms_dir} 
	echo "创建${sprms_dir}目录成功"
    }
    fi

}

function fake_pack()
{
    rpmbuild -ba rpmtest.spec
	
}

function fake_number()
{
    echo "Please input your package name:"
    read fake_name
    echo "Please input number of your package:"
    read fake_number
    for ((i=1;i<${fake_number};i++))
    do
    {
        # 设置包名称 packname+packnumber+packnumber
        sed -i "/Name:.*/s/:.*/:${fake_name}${i}/g" ${specs_name}
	echo "${fake_name}${i}${i}"
	# 调用fake_pack函数
        fake_pack
    }
    done
}

function move_package()
{
    mv ${rpm_dir}/* ${move_dir}
}

function install_pack()
{
    software=`ls ${move_dir}/i386/`    
    for soft in ${software}
    do
	rpm -ivh ${move_dir}/i386/${soft}
	sleep 2
    done
}

function uninstall_pack()
{
    software=`ls ${move_dir}/i386/`    
    for soft in ${software}
    do
	softname=`echo "${soft}" |awk -F '-' '{print $1}'`
	#echo "${softname}"
	rpm -e ${softname}
	sleep 2
    done
}


function Main()
{
    #检验打包路径
    build_path
    echo "build_path done"
    #设定打包名称及数量
    fake_number
    echo "fake_number done"
    #打包后进行移动
    move_package
    echo "move_package done"
    install_pack
    #移动完成后进行安装
    echo "install_pack done"
    #uninstall_pack
}

Main
