<?php
/**
 *  author:exp;
 *  email:root@evilexp.me
 */
namespace Home\Widget;
use Think\Controller;

class SwitchWidget extends Controller {
	
	// 网站关闭
	public function close() {
		$conf = M("configure");
		$data = $conf -> select();
		$this -> assign("data",$data[0]);
		$this -> display("Switch:close");
	}
}
