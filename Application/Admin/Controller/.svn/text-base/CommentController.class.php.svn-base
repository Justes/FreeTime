<?php
	/**
	 *	author:exp;
	 *	email:root@evilexp.me
	 */
namespace Admin\Controller;


class CommentController extends PublicController {
	//管理评论
	public function man() {
		$Model = M();
		$datas = $Model -> table("__COMMENT__ comment,__GOODS__ goods,__USER__ user") -> where("comment.buyerId=user.id and comment.goodsId=goods.goodsId") -> select();
		$this -> assign("datas",$datas);
		$this -> display();
	}
	//删除评论
	public function del() {
		$com = M("comment");
		$id = $_GET['id'];
		if($com -> delete($id)) {
			$this -> redirect("Comment/man");
		} else {
			$this -> error("删除失败");
		}
	}
}
