package com.sxsram.ssm.controller;

import java.io.File;
import java.io.FileInputStream;
import java.security.KeyStore;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.net.ssl.SSLContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.sxsram.ssm.entity.AccountRecordExpand;
import com.sxsram.ssm.entity.JournalBookExpand;
import com.sxsram.ssm.entity.OnlineJournalBookItem;
import com.sxsram.ssm.entity.PlatformSyDistributedRecordExpand;
import com.sxsram.ssm.entity.PlatformYljSavedRecordExpand;
import com.sxsram.ssm.entity.RechargeAndWithDrawRecordExpand;
import com.sxsram.ssm.entity.RoleExpand;
import com.sxsram.ssm.entity.ShoppingMallExpand;
import com.sxsram.ssm.entity.UserExpand;
import com.sxsram.ssm.entity.UserExpandQueryVo;
import com.sxsram.ssm.service.MemberService;
import com.sxsram.ssm.service.UserService;
import com.sxsram.ssm.util.ConfigUtil;
import com.sxsram.ssm.util.DateUtil;
import com.sxsram.ssm.util.IpAddressUtil;
import com.sxsram.ssm.util.JsonResult;
import com.sxsram.ssm.util.Pagination;
import com.sxsram.ssm.util.PreciseComputeUtil;
import com.sxsram.ssm.util.WechatJsapiSign;
import com.sxsram.ssm.util.WechatJsapiSignUtil;
import com.sxsram.ssm.util.WechatPosition;
import com.sxsram.ssm.util.WechatUtil;
import com.sxsram.ssm.util.XMLUtil;

@Controller()
@RequestMapping(value = "/user", method = { RequestMethod.GET, RequestMethod.POST })
public class UserController {
	@Autowired
	private UserService userService;

	@RequestMapping(value = "/error", method = { RequestMethod.GET, RequestMethod.POST })
	public String error(HttpSession session, Model model, String code, String state) throws Exception {
		return "user/error";
	}

	@RequestMapping(value = "/getMoneyAccountRecord", method = { RequestMethod.GET, RequestMethod.POST })
	public String getMoneyAccountRecord(Integer userId, Model model) throws Exception {
		List<AccountRecordExpand> accountRecordExpands = userService.getMoneyAccountRecord(userId);
		if (accountRecordExpands != null && accountRecordExpands.size() > 0)
			model.addAttribute("accountRecordExpands", accountRecordExpands);
		return "user/moneyAccountRecord";
	}

	@RequestMapping(value = "/getJfAccountRecord", method = { RequestMethod.GET, RequestMethod.POST })
	public String getJfAccountRecord(Integer userId, Model model) throws Exception {
		List<AccountRecordExpand> accountRecordExpands = userService.getJfAccountRecord(userId);
		if (accountRecordExpands != null && accountRecordExpands.size() > 0)
			model.addAttribute("accountRecordExpands", accountRecordExpands);
		return "user/jfAccountRecord";
	}

	@RequestMapping(value = "/getDlbAccountRecord", method = { RequestMethod.GET, RequestMethod.POST })
	public String getDlbAccountRecord(Integer userId, Model model) throws Exception {
		List<AccountRecordExpand> accountRecordExpands = userService.getDlbAccountRecord(userId);
		if (accountRecordExpands != null && accountRecordExpands.size() > 0)
			model.addAttribute("accountRecordExpands", accountRecordExpands);
		return "user/dlbAccountRecord";
	}

	@RequestMapping(value = "/getYljAccountRecord", method = { RequestMethod.GET, RequestMethod.POST })
	public String getYljAccountRecord(Integer userId, Model model) throws Exception {
		List<PlatformYljSavedRecordExpand> accountRecordExpands = userService.getYljAccountRecord(userId);
		if (accountRecordExpands != null && accountRecordExpands.size() > 0)
			model.addAttribute("accountRecordExpands", accountRecordExpands);
		return "user/yljAccountRecord";
	}

	@RequestMapping(value = "/getSyAccountRecord", method = { RequestMethod.GET, RequestMethod.POST })
	public String getSyAccountRecord(Integer userId, Model model) throws Exception {
		List<PlatformSyDistributedRecordExpand> accountRecordExpands = userService.getSyAccountRecord(userId);
		if (accountRecordExpands != null && accountRecordExpands.size() > 0)
			model.addAttribute("accountRecordExpands", accountRecordExpands);
		return "user/syAccountRecord";
	}

	@RequestMapping(value = "/userNearbyStores", method = { RequestMethod.GET, RequestMethod.POST })
	public String userNearbyStores(HttpServletRequest request, Model model) throws Exception {
		String url = request.getRequestURL().toString();
		if (request.getQueryString() != null)
			url += ("?" + request.getQueryString());
		String wechatJsapiTicket = WechatJsapiSignUtil.getJSApiTicket(ConfigUtil.APPID, ConfigUtil.APPSECRET);
		WechatJsapiSign wechatJsapiSign = WechatJsapiSignUtil.getSign(ConfigUtil.APPID, wechatJsapiTicket, url);
		model.addAttribute("jsApiSign", wechatJsapiSign);
		return "user/nearbyStores";
	}

	@RequestMapping(value = "/shopDetail", method = { RequestMethod.GET, RequestMethod.POST })
	public String shopDetail(HttpSession session, Model model, Integer mallId) throws Exception {
		ShoppingMallExpand shoppingMallExpand = userService.findAllShppingMallById(mallId);
		model.addAttribute("mall", shoppingMallExpand);
		return "user/shopDetail";
	}

	@RequestMapping(value = "/userNearbyStoresResult", method = { RequestMethod.GET, RequestMethod.POST })
	public String userNearbyStoresResult(HttpSession session, Model model, WechatPosition wechatPos, Integer distance,
			Integer page) throws Exception {
		final int countPerPage = 20; // 每页显示20条

		List<ShoppingMallExpand> sortedMalls = new ArrayList<ShoppingMallExpand>();
		List<ShoppingMallExpand> malls = new ArrayList<ShoppingMallExpand>();
		List<ShoppingMallExpand> allMalls = null;
		allMalls = userService.findAllShppingMalls();
		System.out.println("allMalls:" + allMalls);

		if (distance == null)
			distance = 0;
		if (page == null)
			page = 1;

		// 所有商城
		distance = 2000000000;
		if (allMalls != null && allMalls.size() != 0) {
			for (ShoppingMallExpand mall : allMalls) {
				WechatPosition mallPos = new WechatPosition(mall.getMallPos_lat(), mall.getMallPos_lnt());
				double dis = Math.abs(WechatUtil.getDistance(wechatPos, mallPos));
				System.out.println(dis + "\t" + distance);
				// BigDecimal bg = new BigDecimal(dis / 1000);
				// double f1 = bg.setScale(2,
				// BigDecimal.ROUND_HALF_UP).doubleValue();
				mall.setDistance(PreciseComputeUtil.round(dis / 1000, 2));
				if (dis <= distance) {
					sortedMalls.add(mall);
				}
			}
			System.out.println("sortedMalls-1:" + sortedMalls);
			java.util.Collections.sort(sortedMalls);
			System.out.println("sortedMalls-2:" + sortedMalls);
			int totalSize = sortedMalls.size();
			malls.addAll(sortedMalls.subList((page - 1) * countPerPage,
					page * countPerPage <= totalSize ? page * countPerPage : totalSize)); // 每页10条记录
			System.out.println("malls:" + malls);
			if (malls.size() > 0)
				model.addAttribute("malls", malls);
		}
		// 总的记录数
		model.addAttribute("mallSize", sortedMalls.size());
		// 当前位置信息
		model.addAttribute("wechatPos", wechatPos);
		model.addAttribute("distance", distance);
		return "user/nearbyStoresResult";
	}

	class UserNearbyStoresResultJson {
		private int count;
		private List<ShoppingMallExpand> sets;
	}

	@RequestMapping(value = "/userNearbyStoresResultPage", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String userNearbyStoresResultPage(HttpSession session, Model model, WechatPosition wechatPos,
			Integer distance, Integer page) throws Exception {
		Gson gson = new Gson();
		UserNearbyStoresResultJson jsobObj = new UserNearbyStoresResultJson();
		final int countPerPage = 20; // 每页显示20条

		System.out.println(wechatPos);
		System.out.println(distance);
		System.out.println(page);

		List<ShoppingMallExpand> sortedMalls = new ArrayList<ShoppingMallExpand>();
		List<ShoppingMallExpand> malls = new ArrayList<ShoppingMallExpand>();
		List<ShoppingMallExpand> allMalls = null;
		allMalls = userService.findAllShppingMalls();
		System.out.println("allMalls:" + allMalls);

		if (distance == null)
			distance = 0;
		if (page == null)
			page = 1;

		// 所有商城
		distance = 2000000000;
		if (allMalls != null && allMalls.size() != 0) {
			for (ShoppingMallExpand mall : allMalls) {
				WechatPosition mallPos = new WechatPosition(mall.getMallPos_lat(), mall.getMallPos_lnt());
				double dis = Math.abs(WechatUtil.getDistance(wechatPos, mallPos));
				System.out.println(dis + "\t" + distance);
				mall.setDistance(PreciseComputeUtil.round(dis / 1000, 2));
				if (dis <= distance) {
					sortedMalls.add(mall);
				}
			}
			System.out.println("sortedMalls-1:" + sortedMalls);
			java.util.Collections.sort(sortedMalls);
			System.out.println("sortedMalls-2:" + sortedMalls);
			int totalSize = sortedMalls.size();
			malls.addAll(sortedMalls.subList((page - 1) * countPerPage,
					page * countPerPage <= totalSize ? page * countPerPage : totalSize)); // 每页10条记录
			System.out.println("malls:" + malls);
			jsobObj.count = malls.size();
			jsobObj.sets = malls;
		}
		return gson.toJson(jsobObj);
	}

	@RequestMapping(value = "/recharge", method = { RequestMethod.GET, RequestMethod.POST })
	public String recharge(HttpServletRequest request, HttpServletResponse response, HttpSession session, String code,
			String state, Model model) throws Exception {
		UserExpand user = (UserExpand) session.getAttribute("user");
		if (user == null) {
			return "user/403";
		}
		RoleExpand roleExpand = userService.findRoleByUserId(user.getId());
		user.setRole(roleExpand);
		if (!user.getRole().getRoleName().equals("商家")) {// 商家
			return "user/403";
		}

		String url = request.getRequestURL().toString();
		if (request.getQueryString() != null)
			url += ("?" + request.getQueryString());
		String wechatJsapiTicket = WechatJsapiSignUtil.getJSApiTicket(ConfigUtil.APPID, ConfigUtil.APPSECRET);
		WechatJsapiSign wechatJsapiSign = WechatJsapiSignUtil.getSign(ConfigUtil.APPID, wechatJsapiTicket, url);
		model.addAttribute("jsApiSign", wechatJsapiSign);
		model.addAttribute("code", code);
		return "user/recharge";
		// request.setAttribute("code", code);
		// request.getRequestDispatcher("/paytest/recharge.jsp").forward(request,
		// response);
	}

	@RequestMapping(value = "/paySuccess", method = { RequestMethod.GET, RequestMethod.POST })
	public String paySuccess(HttpServletRequest request, Model model) throws Exception {
		return "user/paySuccess";
	}

	@RequestMapping(value = "/withdraws", method = { RequestMethod.GET, RequestMethod.POST })
	public String withdraws(HttpServletRequest request, HttpSession session, String code, String state, Model model)
			throws Exception {
		UserExpand user = (UserExpand) session.getAttribute("user");
		if (user == null) {
			return "userCenter";
		}
		Double balance = userService.getMoneyAccountBalance(user.getId());
		Double canMoney = balance - balance % 100;
		model.addAttribute("code", code);
		model.addAttribute("balance", balance);
		model.addAttribute("canMoney", canMoney);
		return "user/withdraws";
	}

	@RequestMapping(value = "/withdrawsSubmit", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String withdrawsSubmit(HttpServletRequest request, HttpSession session, String txMoney, Model model)
			throws Exception {
		Gson gson = new Gson();
		JsonResult jsonResult = new JsonResult("0", "0", "提现成功");
		UserExpand user = (UserExpand) session.getAttribute("user");
		if (user == null) {
			jsonResult.logicCode = "-1";
			jsonResult.resultMsg = "页面超时，请重新登录";
			return gson.toJson(jsonResult);
		}

		if (txMoney == null || !txMoney.matches("^\\d*$")) {
			jsonResult.logicCode = "-2";
			jsonResult.resultMsg = "提现金额异常";
			return gson.toJson(jsonResult);
		}

		Double txMoneyVal = Double.valueOf(txMoney);
		Double balance = userService.getMoneyAccountBalance(user.getId());
		Double canMoney = balance - balance % 100;
		if (txMoneyVal > canMoney || txMoneyVal <= 0 || (txMoneyVal % 100 != 0)) {
			jsonResult.logicCode = "-3";
			jsonResult.resultMsg = "提现金额不正确";
			return gson.toJson(jsonResult);
		}

		/*
		 * // 1.提现条件判断 if (userService.getCashFlag(user.getId()) != 0) {
		 * jsonResult.logicCode = "-3"; jsonResult.resultMsg =
		 * "本月交易行为不满足提现条件，提现功能暂停使用！"; return gson.toJson(jsonResult); }
		 */

		// 3.提现成功，判断是否第一次提现
		// if (userService.getWithDrawRecordCounts(user.getId()) > 0) {
		// if (userService.getCurrentMonthConsumeRecordCounts(user.getId()) < 3)
		// {
		// user.setGetCashFlag(1);
		// userService.setCashFlag(user);
		// jsonResult.logicCode = "0";
		// jsonResult.resultMsg = "提现成功，但由于本月交易行为不满足提现条件，提现功能暂停使用！";
		// }
		// }

		if (userService.getWithDrawRecordCounts(user.getId()) > 0) { // 不是第一次提现
			// JournalBookExpand firstJournalBookExpand =
			// userService.findFirstJournalBookByClientId(user.getId());
			RechargeAndWithDrawRecordExpand firstWithDrawRecord = userService.findFirstWithDrawRecord(user.getId());
			if (firstWithDrawRecord == null) {
				jsonResult.logicCode = "-1";
				jsonResult.resultMsg = "提现失败：找不到任何提现记录.";
				return gson.toJson(jsonResult);
			}
			Date date = firstWithDrawRecord.getOperateTime();
			Date now = new Date();
			System.out.println("now is :" + now);
			System.out.println("date is : " + date);
			if (date.getYear() != now.getYear() || date.getMonth() != now.getMonth()) { // 非首次报单一月之内
				if (userService.getCurrentMonthConsumeRecordCounts(user.getId()) < 3) {
					jsonResult.logicCode = "-1";
					jsonResult.resultMsg = "提现失败：本月交易行为(次数)不满足提现条件.";
					return gson.toJson(jsonResult);
				}
			}
			// 获取最后一次取现记录
			RechargeAndWithDrawRecordExpand lastWithDrawRecord = userService.findLastWithDrawRecord(user.getId());
			// 判断距离现在是否小于7天
			date = lastWithDrawRecord.getOperateTime();
			System.out.println("now is :" + now);
			System.out.println("date is : " + date);
			System.out.println("-----------" + now.getYear() + "-" + now.getMonth() + "-" + now.getDate());
			System.out.println("-----------" + date.getYear() + "-" + date.getMonth() + "-" + date.getDate());
			if (DateUtil.getIntervalDays(date,now) < 7) {
				jsonResult.logicCode = "-1";
				jsonResult.resultMsg = "提现失败：距离最后一次提现时间不足7天！";
				return gson.toJson(jsonResult);
			}
		}

		/*
		 * Double serviceMoney = txMoneyVal <= 1000 ? 2 : (txMoneyVal > 1000 &&
		 * txMoneyVal <= 10000) ? txMoneyVal * 0.005 : txMoneyVal * 0.003;
		 */
		Double serviceMoney = txMoneyVal * 0.02;
		System.out.println(serviceMoney);

		Date date = new Date();
		DateFormat format = new SimpleDateFormat("yyyyMMdd");
		String time = format.format(date);
		format = new SimpleDateFormat("MMddHHmmss");
		String rand = format.format(date);
		String orderNo = ConfigUtil.MCH_ID + time + rand;
		String clientIp = IpAddressUtil.getIpAddr(request);
		RechargeAndWithDrawRecordExpand record = new RechargeAndWithDrawRecordExpand(ConfigUtil.TradeType.WITHDRAW,
				orderNo, txMoneyVal, serviceMoney, ConfigUtil.TradeState.PAYPENDING, clientIp);
		record.setUser(user);
		userService.userWithDraw(record);

		if (!withDrawToWx(user, orderNo, clientIp, (txMoneyVal - serviceMoney))) {
			jsonResult.logicCode = "-4";
			jsonResult.resultMsg = "服务器暂时无法完成提现操作";
			return gson.toJson(jsonResult);
		}
		return gson.toJson(jsonResult);
	}

	public String HttpsCret(String url, String data, String cretPath, String cretPasswd) throws Exception {
		// String cretPath =
		// "/usr/local/apache-tomcat-7.0.70/webapps/wechat/WEB-INF/cert/apiclient_cert.p12";
		// String cretPawd = "";
		KeyStore keyStore = KeyStore.getInstance("PKCS12");
		FileInputStream instream = new FileInputStream(new File(cretPath));
		keyStore.load(instream, cretPasswd.toCharArray());
		instream.close();
		SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, cretPasswd.toCharArray()).build();
		SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslcontext, new String[] { "TLSv1" }, null,
				SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
		CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
		HttpPost httpost = new HttpPost(url); // 璁剧疆鍝嶅簲澶翠俊鎭?
		httpost.addHeader("Connection", "keep-alive");
		httpost.addHeader("Accept", "*/*");
		httpost.addHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
		httpost.addHeader("Host", "api.mch.weixin.qq.com");
		httpost.addHeader("X-Requested-With", "XMLHttpRequest");
		httpost.addHeader("Cache-Control", "max-age=0");
		httpost.addHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0) ");
		httpost.setEntity(new StringEntity(data, "UTF-8"));
		CloseableHttpResponse response = httpclient.execute(httpost);
		HttpEntity entity = response.getEntity();
		String str = EntityUtils.toString(entity, "UTF-8");
		EntityUtils.consume(entity);
		return str;
	}

	private boolean withDrawToWx(UserExpand user, String orderNo, String clientIp, double txMoney) throws Exception {
		SortedMap<Object, Object> parameters = new TreeMap<Object, Object>();
		SortedMap<Object, Object> params = new TreeMap<Object, Object>();
		parameters.put("wxappid", ConfigUtil.APPID);
		parameters.put("mch_id", ConfigUtil.MCH_ID);
		parameters.put("nonce_str", WechatJsapiSignUtil.create_nonce_str());

		parameters.put("mch_billno", orderNo);
		parameters.put("send_name", ConfigUtil.BUSINESSNAME);
		parameters.put("re_openid", user.getOpenId());
		parameters.put("total_amount", (int) txMoney * 100 + "");
		// parameters.put("re_user_name", "NO_CHECK");
		parameters.put("total_num", 1 + "");
		parameters.put("wishing", "用户提现");
		parameters.put("client_ip", clientIp);
		parameters.put("act_name", "act_name");
		parameters.put("remark", "remark");
		parameters.put("scene_id", "PRODUCT_1");
		String sign = WechatJsapiSignUtil.createPaySign(ConfigUtil.PAYKEY, "UTF-8", parameters);
		parameters.put("sign", sign);
		String data = WechatJsapiSignUtil.getRequestXml(parameters);
		System.out.println("---------requestXML: ------" + data);

		String result = HttpsCret(ConfigUtil.SEND_RED_PACKT_URL, data, ConfigUtil.CRETPATH, ConfigUtil.CRETPASSWD);
		System.out.println("----result---->" + result);
		Map<String, String> map = XMLUtil.doXMLParse(result);// 解析微信返回的信息，以Map形式存储便于取值
		// 失败，提示服务器重新发送
		if (map.get("return_code").toString().equalsIgnoreCase("FAIL")
				|| map.get("result_code").toString().equalsIgnoreCase("FAIL")) {// 通信失败
			return false;
		}

		// 获取订单状态
		RechargeAndWithDrawRecordExpand record = userService
				.findRechargeRecordByOrderNo((String) map.get("mch_billno"));
		if (record == null) {
			// 报警.
			return false;
		}

		// 查看该订单是否已经处理过
		if (record.getOperateState() != ConfigUtil.TradeState.PAYPENDING.ordinal()) {// 已经处理过了
			return false;
		}

		// 获取交易结果
		if (map.get("result_code").toString().equalsIgnoreCase("SUCCESS")) {
			record.setOperateState(ConfigUtil.TradeState.PAYSUCCESS.ordinal());
		} else {
			record.setOperateState(ConfigUtil.TradeState.PAYERROR.ordinal());
		}
		userService.updateWithDrawRecordState(record);
		return true;
	}

	@RequestMapping(value = "/withDrawsRecords", method = { RequestMethod.GET, RequestMethod.POST })
	public String withDrawsRecords(HttpServletRequest request, HttpSession session, String txMoney, Model model)
			throws Exception {
		UserExpand user = (UserExpand) session.getAttribute("user");
		if (user == null) {
			return "forward: userCenter.action";
		}

		List<RechargeAndWithDrawRecordExpand> records = userService.findAllWithDrawsRecords(user.getId());
		if (records != null && records.size() > 0)
			model.addAttribute("records", records);
		return "user/withDrawsRecord";
	}

	@RequestMapping(value = "/offlineConsumeRecord", method = { RequestMethod.GET, RequestMethod.POST })
	public String offlineConsumeRecord(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		UserExpand user = (UserExpand) session.getAttribute("user");
		if (user == null) {
			return "forward: userCenter.action";
		}

		List<JournalBookExpand> journalBookExpands = userService.findAllJournalBookRecordsByClientId(user.getId());
		if (journalBookExpands != null && journalBookExpands.size() > 0)
			model.addAttribute("records", journalBookExpands);
		return "user/offlineConsumeRecord";
	}
}
