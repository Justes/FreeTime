<?php
/**
 *		author:exp;
 *		email:root@evilexp.me
 */
namespace Home\Widget;
use Think\Controller;

class CartWidget extends Controller {
	public function index() {
		// 得到当前用户的id
		if(isset($_SESSION['user']['flag'])) {
			$userId = $_SESSION['user']['id'];

			// 根据cart中的goodsId去goods中查找
			$Model = M();
			$datas = $Model -> where("cart.goodsId = goods.goodsId and cart.buyerId = $userId and goods.sellerId = user.id") -> table("__CART__ cart, __USER__ user, __GOODS__ goods") -> order("cart.id desc") -> select();

			if($datas) {
				$flag = 1;

				// 通过商品id得到所有该用户发布的商品的图片
				$goodsPic = M("goodspic");

				foreach($datas as $key => &$value) {
					$goodsId['goodsId'] = $value['goodsId'];

					// 此商品的所有图片
					$picData = $goodsPic -> where($goodsId) -> select();

					// 每个商品显示一张图片
					$value['goodsPic'] = $picData[0]['goodsPic'];

					//	算出某类商品的总价 
					$datas[$key]['amounts'] = number_format($datas[$key]['amount'] * $datas[$key]['price'], 2,'.','');
				}
			} else {
				$flag = 0;
			}

			$this -> assign("flag",$flag);
			$this -> assign("datas",$datas);
			$this -> display("Cart:index");
		}
	}

	public function total() {
		// 得到当前用户的id
		if(isset($_SESSION['user']['flag'])) {
			$userId = $_SESSION['user']['id'];

			// 根据cart中的goodsId去goods中查找
			$Model = M();
			$datas = $Model -> where("cart.goodsId = goods.goodsId and cart.buyerId = $userId and goods.sellerId = user.id") -> table("__CART__ cart, __USER__ user, __GOODS__ goods") -> order("cart.id desc") -> select();

			$sum = 0;

			if($datas) {

				// 通过商品id得到所有该用户发布的商品的图片
				foreach($datas as $key => &$value) {

					//	算出某类商品的总价 
					$datas[$key]['amounts'] = number_format($datas[$key]['amount'] * $datas[$key]['price'], 2,'.','');
					$sum += $datas[$key]['amounts'];
				}
			}

			return number_format($sum,2,'.','');
		}
	}
}
