<?php
namespace Admin\Controller;


class RecycleController extends PublicController{
	//查看回收站
    public function RecUsers(){
		$user = M("user"); 
		$map['recycle'] = '0';
		$data = $user ->field('id,username,status') -> where($map) -> select();
		$this -> assign("users",$data);
        $this -> display();
    }
	//回复用户数据
	public function recoveryUsers(){
		
		$map['id'] = $_GET['id'];
		$user = M("user");
		$data['recycle'] = '1';
		$rows = $user -> where($map) -> save($data);
		if($rows){
			
			$this -> redirect("Recycle/RecUsers");
		}else{
			
			$this -> error("更改失败",U("Recycle/RecUsers"));
		}
		
	}
	// **删除用户（！）
	public function dropUsers(){
		
		$id = $_GET['id'];
		$user = M("user");
		$userdetail = M("userdetail");
		$question = M("question");
		$goods = M("goods");
		$order = M("order");
		$comment = M("comment");
		$cart = M("cart");
		$goodPic = M("goodspic");
		$map1['id'] = $id;          //user表
		$map2['userId'] = $id;      //detail表
		$map3['sellerId'] = $id;   	//goods表
		$map4['userId'] = $id;    	//order表
		$map5['buyerId'] = $id;   	//comment表
		$map6['sellerId'] = $id;  	//comment表
		$map7['buyerId'] = $id;   	//cart表
		
		$select1 = $goods -> where($map3) -> select();
		
		$map8['goodsId'] = $select1[0]['goodsId'];  //goodsPic表
		
		$select2 = $user -> where($map1) -> select();
		
		$map9['username'] = $select2[0]['username']; //question表
		
		$rows1 = $user -> where($map1) -> delete();
		$rows2 = $userdetail -> where($map2) -> delete();
		$rows3 = $question -> where($map9) -> delete();
		$rows4 = $goods -> where($map3) -> delete();
		$rows5 = $order -> where($map4) -> delete();
		$rows6 = $comment -> where($map5) -> delete();
		$rows7 = $comment -> where($map6) -> delete();
		$rows8 = $cart -> where($map7) -> delete();
		$rows9 = $goodPic -> where($map8) -> delete();
		//$rows = $user -> table('xy_user,xy_userdetail,xy_goods,xy_order,xy_comment,xy_cart,xy_goodsPic,xy_question') -> where("user.id = userdetail.uid and user.id = {$id} and goods.sellerId = user.id and order.userId = user.id and comment.buyerId = user.id and comment.sellerId = user.id and cart.buyerId = user.id and goodsPic.goodsId = goods.goodsId and user.username = question.username") -> delete();
		
		//var_dump($rows);
		$this -> success("相关数据已全部删除",U("Recycle/RecUsers"));
		
		
	}
}
