<?php
namespace Admin\Controller;

class WebManageController extends PublicController{

	/**
	 *  友情链接
	 */
    public function Links(){
		$links = M("links");
		$datas = $links -> select();
		$this -> assign("datas",$datas);
        $this -> display();
    }

	/**
	 *  增加友情链接
	 */ 
	public function add() {
		if($_POST['sub']) {
			$links = M("links");

			// 上传照片
			if($_FILES['logo']['name']) {
				$_POST['logo'] = $this -> upload();
			}

			$_POST['addTime'] = date("Y-m-d H:i:s",time());

			if($links -> create()) {
				if($links -> add()) {
					U("Webmanage/Links");
					$this -> redirect("");
				} else {
					$this -> error("添加出错");
				}
			} else {
				$this -> error("添加出错");
			}
		}
		$this -> display();
	}

	/**
	 *  修改
	 */
	public function mod() {
		$links = M("links");

		if($_GET['id']) {
			$map['id'] = $_GET['id'];
			$id = $_GET['id'];
			$data = $links -> where($map) -> select();

			$this -> assign("data",$data[0]);
		} 
	   	if($_POST['sub']) {
			if($_FILES['logo']['name']) {
				$_POST['logo'] = $this -> upload();
			}

			if($links -> create()) {
				if($links -> save()) {
					$this -> redirect("WebManage/links");
				} else {
					$this -> error("修改失败");
				}
			} else {
				$this -> error("修改失败");
			}
		}
		$this -> display();
	}

	/**
	 *	上传友链图片
	 */
	private function upload() {
		$upload = new \Think\Upload();
		$upload -> maxSize = 10000000;
		$upload -> exts = array("jpeg","jpg","png","gif");
		$upload -> rootPath = "./Public/Admin/";
		$upload -> savePath = "Upload/";
		$info = $upload -> upload();

		return $info['logo']['savepath'].$info['logo']['savename'];
	}

	/**
	 *	删除
	 */
	public function del() {
		$id = $_GET['id'];
		$links = M("links");
		if($links -> delete($id)) {
			$this -> redirect("WebManage/links");
		} else {
			$this -> error("删除失败");
		}
	}


	/**
	 *	网站配置
	 */
    public function Management(){
		$conf = M("configure");
		if($_POST['sub']) {
			if($_FILES['logo']['name']) {
				$_POST['logo'] = $this -> upload();
				$datas = $conf -> select();
				if($datas[0]['logo']) {
					unlink("./Public/Admin/{$datas[0]['logo']}");
				}
			}

			if($conf -> create()) {
				if($conf -> save()) {
					$this -> redirect("WebManage/Management");
				} else {
					$this -> error("修改失败");
				}
			} else {
				$this -> error("修改失败");
			}
		}
		$data = $conf -> select();

		$this -> assign("data",$data[0]);
        $this -> display();
    }

	/**
	 *	网站轮播
	 */
	public function ppt() {
		$ppt = M("ppt");
		$datas = $ppt -> select();
		$this -> assign("datas",$datas);
		$this -> display();
	}

	/**
	 *  修改网站轮播
	 */
	public function modppt() {
		$ppt = M("ppt");
		if($_POST['sub']) {
			if($_FILES['logo']['name']) {
				$map['id'] = $_POST['id'];
				$_POST['logo'] = $this -> upload();

				$datas = $ppt -> where($map) -> select();
				if($datas[0]['logo']) {
					unlink("./Public/Admin/{$datas[0]['logo']}");
				}
			}

			if($ppt -> create()) {
				if($ppt -> save()) {
					$this -> redirect("WebManage/ppt");
				} else {
					$this -> error("修改失败");
				}
			} else {
				$this -> error("修改失败");
			}
		}
		$this -> display();
	}

}
