package com.sxsram.ssm.mapper;

import java.util.List;

import com.sxsram.ssm.entity.Notice;
import com.sxsram.ssm.entity.NoticeQueryVo;
import com.sxsram.ssm.entity.NoticeType;
import com.sxsram.ssm.entity.NoticeTypeQueryVo;

public interface NoticeMapper {

	/**
	 * Notice Operation
	 */

	void updateNotice(Notice notice) throws Exception;

	void addNewNotice(Notice notice) throws Exception;

	void deleteNotice(Integer id) throws Exception;

	Integer queryNoticeListCount(NoticeQueryVo noticeQueryVo) throws Exception;

	List<Notice> queryMultiNotices(NoticeQueryVo noticeQueryVo) throws Exception;

	Notice querySingleNotice(NoticeQueryVo noticeQueryVo) throws Exception;

	
	/**
	 * Notice Types Operation
	 */

	void updateNoticeType(NoticeType noticeType) throws Exception;

	void addNewNoticeType(NoticeType noticeType) throws Exception;

	void deleteNoticeType(Integer id) throws Exception;

	Integer queryNoticeTypeListCount(NoticeTypeQueryVo noticeTypeQueryVo) throws Exception;

	List<NoticeType> queryMultiNoticeTypes(NoticeTypeQueryVo noticeTypeQueryVo) throws Exception;

	NoticeType querySingleNoticeType(NoticeTypeQueryVo noticeTypeQueryVo) throws Exception;
}
