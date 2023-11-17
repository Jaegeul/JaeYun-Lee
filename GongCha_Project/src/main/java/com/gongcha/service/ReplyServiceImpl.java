package com.gongcha.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gongcha.dao.ReplyDAO;
import com.gongcha.dto.ReplyDTO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyDAO replyDao;

	@Override
	public List<ReplyDTO> replyList(ReplyDTO dto) {
		return replyDao.replyList(dto);
	}

	@Override
	public void replyRegi(ReplyDTO re) {
		replyDao.replyRegi(re);
	}

}
