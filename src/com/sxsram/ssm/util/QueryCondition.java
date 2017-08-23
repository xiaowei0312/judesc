package com.sxsram.ssm.util;

import java.util.List;

import com.sxsram.ssm.exception.SQLOperatorNotSupportedException;

public class QueryCondition {
	private List<QueryConditionItem> whereCondList;
	private String whereCond;

	public QueryCondition(List<QueryConditionItem> whereCondList) throws SQLOperatorNotSupportedException {
		super();
		this.whereCondList = whereCondList;
		if (this.whereCondList == null || whereCondList.size() == 0)
			return;
		StringBuilder sBuilder = new StringBuilder();
		for (QueryConditionItem item : whereCondList) {
			String key = item.getKey();
			String value = item.getValue();
			if (StringUtil.isEmpty(value))
				continue;
			switch (item.getOperator()) {
			case EQ:
				sBuilder.append("(" + key + "='" + value + "')");
				break;
			case LT:
				sBuilder.append("(" + key + "<'" + value + "')");
				break;
			case GT:
				sBuilder.append("(" + key + ">'" + value + "')");
				break;
			case LE:
				sBuilder.append("(" + key + "<='" + value + "')");
				break;
			case GE:
				sBuilder.append("(" + key + ">='" + value + "')");
				break;
			case LIKE:
				sBuilder.append("(" + key + " like '%" + value + "%')");
				break;
			case BETWEEN:
				// sBuilder.append("(" + key + "=" + value + ")");
				break;
			case IN:
				break;
			default:
				throw new SQLOperatorNotSupportedException(item.getOperator().name());
			}
			sBuilder.append(" and ");
		}
		if (sBuilder != null && sBuilder.length() > 0)
			whereCond = sBuilder.substring(0, sBuilder.length() - " and ".length()).toString();
	}

	public QueryCondition(String whereCondJson) {
		setWhereCond(whereCondJson);
	}

	public QueryCondition() {
		super();
	}

	public String getWhereCond() {
		return whereCond;
	}

	public void setWhereCond(String whereCond) {
		this.whereCond = whereCond;
	}

	@Override
	public String toString() {
		return "QueryCondition [whereCond=" + getWhereCond() + "]";
	}

	public static void main(String[] args) {
		String whereCondJsonTpl = "{\"province\":\"=,%1$s\",\"city\":\"=,%2$s\",\"area\":\"=,%3$s\",\"mallName\":\"like,%4$s\"}";
		QueryCondition queryCondition = new QueryCondition(String.format(whereCondJsonTpl, "1", "2", "3", "zhangsan"));
		System.out.println(queryCondition);
	}
}
