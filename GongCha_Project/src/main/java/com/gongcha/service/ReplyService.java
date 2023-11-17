package com.gongcha.service;

import java.util.List;

import com.gongcha.dto.ReplyDTO;

public interface ReplyService {

	List<ReplyDTO> replyList(ReplyDTO dto);

	void replyRegi(ReplyDTO re);
}
