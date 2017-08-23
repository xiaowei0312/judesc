package com.sxsram.ssm.service;

import com.sxsram.ssm.entity.OnlineJournalBook;

public interface OrderService {

	void purchase(OnlineJournalBook newOrder, double d, String string, Integer id)throws Exception;

	void addNewOrder(OnlineJournalBook newOrder)throws Exception;

	OnlineJournalBook getOnlineOrderById(Integer orderId) throws Exception;

}