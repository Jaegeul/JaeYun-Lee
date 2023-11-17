package com.gongcha.dao;

import java.util.List;

import com.gongcha.dto.ReplyDTO;

public interface ReplyDAO {

	List<ReplyDTO> replyList(ReplyDTO dto);

	void replyRegi(ReplyDTO re);

}
