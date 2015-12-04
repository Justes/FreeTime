<?php
	/**
	 *	author:exp;
	 *	email:root@evilexp.me
	 */
namespace Home\Widget;
use Think\Controller;

class TitleWidget extends Controller {
	public function getTitle() {
		$conf = M("configure");
		$data = $conf -> select();
		return $data[0]['title'];
	}
}
