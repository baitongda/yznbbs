<?php
return array(
	//'配置项'=>'配置值'
    'MODULE_ALLOW_LIST' => array ('Home','Admin'),
    'DEFAULT_MODULE' => 'Home',
    
    'SHOW_PAGE_TRACE' =>true,//页面调试工具
    
    //加载其他配置文件　
    'LOAD_EXT_CONFIG' => 'config_db,config_url',//加载扩展配置文件
);