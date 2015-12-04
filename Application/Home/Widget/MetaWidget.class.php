<?php
	/**
	 *  author:exp;
	 *  email:root@evilexp.me
	 */
namespace Home\Widget;
use Think\Controller;

class MetaWidget extends Controller {
	public function getMeta() {
		$conf = M("configure");
		$data = $conf -> select();
		$key = $data[0]['keywords'];
		$desc = $data[0]['description'];
		return "<meta name='keywords' content='{$key}' /><meta name='description' content='{$desc}'>";
		//$this -> assign("data",$data[0]);
		//$this -> display("Meta:getMeta");
	}
}
